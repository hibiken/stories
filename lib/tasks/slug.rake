namespace :slug do
  desc 'regenerate slug for sluggable models'
  task :regenerate => :environment do
    # FriendlyId will generate slug only when the slug field is nil
    [User, Tag].each do |klass|
      klass.find_each do |record|
        record.slug = nil
        record.save!
      end
    end

    Post.find_each do |post|
      if post.published?
        post.publish
      else
        post.save_as_draft
      end
    end
  end
end
