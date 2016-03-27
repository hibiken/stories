namespace :slug do
  desc 'regenerate slug for sluggable models'
  task :regenerate => :environment do
    # FriendlyId will generate slug only when the slug field is nil
    User.find_each do |user|
      user.slug = nil
      user.save!
    end
  end
end
