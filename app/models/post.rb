class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :subject, type: String
  field :contents, type: String
end
