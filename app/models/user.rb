class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :email, type: String

    # nameカラムに関するバリデーション
  validates :name,{presence: true}
  
  # emailカラムに関するバリデーション
  validates :email,{presence: true, uniqueness: true}
end
