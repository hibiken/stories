class PostIndexJob < ActiveJob::Base
  queue_as :elasticsearch

  def perform(operation, post_id)
    if operation =~ /index|delete/
      self.send(operation, post_id)
    else
      logger.warn "PostIndexJob cannot process #{operation}"
    end
  end

  private

    def index(post_id)
      # TODO: user find_by(id: ) and check for post's presence
      post = Post.find(post_id)
      post.__elasticsearch__.index_document
    end

    def delete(post_id)
      client = Post.__elasticsearch__.client
      client.delete index: 'posts', type: 'post', id: post_id
    end
end
