class User
  include Mongoid::Document
  include Mongoid::Timestamps

  include ActiveModel::SecurePassword
    
  field :id, type: String
  field :name, type: String
  field :email, type: String
  # field :password, type: String
  field :userImage, type: String
  field :password_digest, type: String

  # has_secure_password_パスワード暗号化
  has_secure_password

  # _idカラムに関するバリデーション
  validates :id,{presence: true}

  # nameカラムに関するバリデーション
  validates :name,{presence: true, uniqueness: true}
  
  # emailカラムに関するバリデーション
  validates :email,{presence: true, uniqueness: true}

  # passwordカラムに関するバリデーション
  # validates :password,{presence: true}

  # password_digestカラムに関するバリデーション
  # validates :password_digest,{presence: true}
  
  def posts
    return  Post.where(user_id: self.id)
  end


end
