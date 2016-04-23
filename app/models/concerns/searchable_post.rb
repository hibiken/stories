module SearchablePost
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    # Sync up Elasticsearch with PostgreSQL.
    after_commit :index_document, on: [:create, :update]
    after_commit :delete_document, on: [:destroy]

    settings INDEX_OPTIONS do
      mappings dynamic: 'false' do
        indexes :title, analyzer: 'autocomplete'
        indexes :body, analyzer: 'english'
        indexes :published_at
        indexes :slug
        indexes :tags do
          indexes :name, analyzer: 'english'
        end
        indexes :user do
          indexes :username, analyzer: 'english'
          indexes :avatar_url
        end
      end
    end

    def self.search(term)
      __elasticsearch__.search(
        {
          query: {
            filtered: {
              query: {
                multi_match: {
                  query: term,
                  fields: ['title^10', 'body', 'user.username', 'tags.name^10']
                }
              },
              filter: {
                exists: {
                  field: "published_at"
                }
              }
            }
          }
        }
      )
    end
  end

  def as_indexed_json(options = {})
    self.as_json({
      only: [:title, :body, :published_at, :slug],
      include: {
        user: {methods: [:avatar_url], only: [:username, :avatar_url] },
        tags: { only: :name }
      }
    })
  end

  def index_document
    ElasticsearchIndexJob.perform_later('index', 'Post', self.id) if self.published?
  end

  def delete_document
    ElasticsearchIndexJob.perform_later('delete', 'Post', self.id) if self.published?
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
