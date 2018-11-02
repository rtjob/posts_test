class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :subject, type: String
  field :contents, type: String

  # subjectカラムに関するバリデーション
  validates :subject,{presence: true}
  
  # contentsカラムに関するバリデーション
  validates :contents,{presence: true}
end
