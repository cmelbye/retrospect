module Retrospect
  class Project
    include DataMapper::Resource
    
    property :id,         Integer,  :serial => true
    property :name,       String,   :nullable => false
    property :permalink,  String
    property :uri,        URI,      :nullable => false, :length => 255
    property :branch,     String,   :nullable => false, :default => "master"
    property :created_at, DateTime
    property :updated_at, DateTime
    
    before :save, :set_permalink
    
    private
      def set_permalink
        attribute_set(:permalink, (name || "").downcase.
          gsub(/'s/, "s").
          gsub(/&/, "and").
          gsub(/[^a-z0-9]+/, "-").
          gsub(/-*$/, ""))
      end
  end
end