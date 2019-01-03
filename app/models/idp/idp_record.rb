IDP_SCHEMA = YAML.load(
  ERB.new(
    File.read(
      Rails.root.join('config', 'idp_database.yml')
    )
  ).result
)[Rails.env]

module Idp
  class IdpRecord < ActiveRecord::Base
    self.abstract_class = true
    establish_connection IDP_SCHEMA
  end
end
