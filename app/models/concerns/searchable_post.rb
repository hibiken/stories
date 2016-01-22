module SearchablePost
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    # Sync up Elasticsearch with PostgreSQL.
    after_commit :index_document, on: [:create, :update]
    after_commit :delete_document, on: [:destroy]

    settings index: { number_of_shards: 1 } do
      mappings dynamic: 'false' do
        indexes :title, analyzer: 'english'
        indexes :body, analyzer: 'english'
        indexes :tags do
          indexes :name, analyzer: 'english'
        end
        indexes :user do
          indexes :username, analyzer: 'english'
        end
      end
    end

    def self.search(term)
      __elasticsearch__.search(
        {
          query: {
            multi_match: {
              query: term,
              fields: ['title^10', 'body', 'user.username^5', 'tags.name^5']
            }
          }
        }
      )
    end
  end

  def as_indexed_json(options = {})
    self.as_json({
      only: [:title, :body],
      include: {
        user: { only: :username },
        tags: { only: :name }
      }
    })
  end

  def index_document
    ElasticsearchIndexJob.perform_later('index', 'Post', self.id)
  end

  def delete_document
    ElasticsearchIndexJob.perform_later('delete', 'Post', self.id)
  end
end
