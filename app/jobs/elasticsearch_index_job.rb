class ElasticsearchIndexJob < ActiveJob::Base
  queue_as :elasticsearch

  def perform(operation, searchable_class, searchable_id)
    if operation =~ /index|delete/
      self.send(operation, searchable_class, searchable_id)
    else
      logger.warn "PostIndexJob cannot process #{operation}"
    end
  end

  private

    def index(searchable_class, searchable_id)
      searchable = searchable_class.constantize.find_by(id: searchable_id)
      searchable.__elasticsearch__.index_document if searchable.present?
    end

    def delete(searchable_class, searchable_id)
      client = searchable_class.constantize.__elasticsearch__.client
      client.delete index: searchable_class.underscore.downcase.pluralize, 
                    type: searchable_class.underscore.downcase, 
                    id: searchable_id
    end
end
