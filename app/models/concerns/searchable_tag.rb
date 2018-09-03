module SearchableTag
  extend ActiveSupport::Concern

    included do
      searchkick
      #include Elasticsearch::Model
=begin
      # Sync up Elasticsearch with PostgreSQL.
      after_commit :index_document, on: [:create, :update]
      after_commit :delete_document, on: [:destroy]

      settings INDEX_OPTIONS do
        mappings dynamic: 'false' do
          indexes :name, analyzer: 'autocomplete'
          indexes :slug
        end
      end

      def self.search(term)
        __elasticsearch__.search(
          {
            query: {
              multi_match: {
                query: term,
                fields: ['name']
              }
            }
          }
        )
      end
=end
  end

  def search_data(options ={})
    self.as_json({
      only: [:name, :slug]
    })
  end

=begin
  def index_document
    ElasticsearchIndexJob.perform_later('index', 'Tag', self.id)
  end

  def delete_document
    ElasticsearchIndexJob.perform_later('delete', 'Tag', self.id)
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
=end

end
