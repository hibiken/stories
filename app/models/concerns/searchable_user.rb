module SearchableUser
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    # Sync up Elasticsearch with PostgreSQL.
    after_commit :index_document, on: [:create, :update]
    after_commit :delete_document, on: [:destroy]

    settings index: { number_of_shards: 1 } do
      mappings dynamic: 'false' do
        indexes :username, analyzer: 'english'
        indexes :email
        indexes :avatar_url
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
      methods: [:avatar_url], only: [:username, :email, :avatar_url]
    })
  end

  def index_document
    ElasticsearchIndexJob.perform_later('index', 'User', self.id)
  end

  def delete_document
    ElasticsearchIndexJob.perform_later('delete', 'User', self.id)
  end

end

