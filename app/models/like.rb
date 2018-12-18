class Like
  include Mongoid::Document
  field :user_id, type: String
  field :post_id, type: String

  # user_idカラムに関するバリデーション
  validates :user_id,{presence: true}

end
