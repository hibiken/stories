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
      only: [:username, :email]
    })
  end

  def index_document
    UserIndexJob.perform_later('index', self.id)
  end

  def delete_document
    UserIndexJob.perform_later('delete', self.id)
  end

end

