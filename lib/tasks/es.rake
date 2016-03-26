namespace :es do
  desc 'recreate index of nescesary model !'
  task :recreate_index => :environment do
    [User, Post, Tag].each do |klass|
      # Delete the previous users index in Elasticsearch
      klass.__elasticsearch__.client.indices.delete index: klass.index_name rescue nil

      # Create the new index with the new mapping
      klass.__elasticsearch__.client.indices.create \
        index: klass.index_name,
        body: { settings: klass.settings.to_hash, mappings: klass.mappings.to_hash }

      # Index all user records from the DB to Elasticsearch
      klass.import
    end
  end
end
