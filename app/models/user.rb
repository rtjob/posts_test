class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :email, type: String
  field :password, type: String
  field :userImage, type: String

  # nameカラムに関するバリデーション
  validates :name,{presence: true, uniqueness: true}
  
  # emailカラムに関するバリデーション
  validates :email,{presence: true, uniqueness: true}

  # passwordカラムに関するバリデーション
  validates :password,{presence: true}

end
