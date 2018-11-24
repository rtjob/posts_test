class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :id, type: String
  field :subject, type: String
  field :contents, type: String

  # _idカラムに関するバリデーション
  validates :id,{presence: true}

  # subjectカラムに関するバリデーション
  validates :subject,{presence: true}
  
  # contentsカラムに関するバリデーション
  validates :contents,{presence: true}
end
