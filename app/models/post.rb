class Post
  include Mongoid::Document
  field :contents, type: String
end
