namespace :idp do
  namespace :db do
    namespace :test do
      task :prepare do
        result = system "curl 'https://raw.githubusercontent.com/18F/identity-idp/master/db/schema.rb' > db/idp_schema.rb"
        raise 'IdP schema download failed' unless result

        ENV['RAILS_ENV'] = 'test'
        ENV['SCHEMA'] = 'db/idp_schema.rb'
        Rails.env = 'test'
        Rails.application.config.paths['config/database'] = 'config/idp_database.yml'

        Rake::Task['db:environment:set'].invoke
        Rake::Task['db:schema:load'].invoke
      end
    end
  end
end
