class UserIndexJob < ActiveJob::Base
  queue_as :elasticsearch

  def perform(operation, user_id)
    if operation =~ /index|delete/
      self.send(operation, user_id)
    else
      logger.warn "UserIndexJob cannot process #{operation}"
    end
  end

  private

    def index(user_id)
      user = User.find(user_id)
      user.__elasticsearch__.index_document
    end

    def delete(user_id)
      client = User.__elasticsearch__.client
      client.delete index: 'users', type: 'user', id: user_id
    end
end
