module SearchableUser
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    # Sync up Elasticsearch with PostgreSQL.
    after_commit :index_document, on: [:create, :update]
    after_commit :delete_document, on: [:destroy]

    settings INDEX_OPTIONS do
      mappings dynamic: 'false' do
        indexes :username, analyzer: 'autocomplete'
        indexes :email
        indexes :avatar_url
        indexes :slug
      end
    end

    def self.search(term)
      __elasticsearch__.search(
        {
          query: {
            multi_match: {
              query: term,
              fields: ['username^10', 'email']
            }
          }
        }
      )
    end
  end


  def as_indexed_json(options ={})
    self.as_json({
      methods: [:avatar_url], only: [:username, :email, :avatar_url, :slug]
    })
  end

  def index_document
    ElasticsearchIndexJob.perform_later('index', 'User', self.id)
    self.posts.find_each do |post|
      ElasticsearchIndexJob.perform_later('index', 'Post', post.id) if post.published?
    end
  end

  def delete_document
    ElasticsearchIndexJob.perform_later('delete', 'User', self.id)
    self.posts.find_each do |post|
      ElasticsearchIndexJob.perform_later('delete', 'Post', post.id) if post.published?
    end
  end

  INDEX_OPTIONS =
    { number_of_shards: 1, analysis: {
    filter: {
      "autocomplete_filter" => {
        type: "edge_ngram",
        min_gram: 1,
        max_gram: 20
      }
    },
    analyzer: {
      "autocomplete" => {
        type: "custom",
        tokenizer: "standard",
        filter: [
          "lowercase",
          "autocomplete_filter"
        ]
      }
    }
  }
  }

end
