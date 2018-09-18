namespace :elasticsearch do
  desc 'reindex Elasticsearch for all searchable models'
  task :reindex => :environment do
    [User, Post, Tag].each do |klass|
      klass.reindex
    end

  end
end
