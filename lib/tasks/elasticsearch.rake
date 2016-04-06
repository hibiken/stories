namespace :elasticsearch do
  desc 'reindex Elasticsearch for all searchable models'
  task :reindex => :environment do
    [User, Post, Tag].each do |klass|
      # Delete the previous index in Elasticsearch
      klass.__elasticsearch__.client.indices.delete index: klass.index_name rescue nil

      # Create the new index with the new mapping
      klass.__elasticsearch__.client.indices.create \
        index: klass.index_name,
        body: { settings: klass.settings.to_hash, mappings: klass.mappings.to_hash }

      # Index all records from the DB to Elasticsearch
      if klass == Post
        klass.all.published.import
      else
        klass.import
      end
    end

  end
end
