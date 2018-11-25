class User
  include Mongoid::Document
  include Mongoid::Timestamps
    
  field :id, type: String
  field :name, type: String
  field :email, type: String
  field :password, type: String
  field :userImage, type: String

  # _idカラムに関するバリデーション
  validates :id,{presence: true}

  # nameカラムに関するバリデーション
  validates :name,{presence: true, uniqueness: true}
  
  # emailカラムに関するバリデーション
  validates :email,{presence: true, uniqueness: true}

  # passwordカラムに関するバリデーション
  validates :password,{presence: true}

  def posts
    return  Post.where(user_id: self.id)
  end


end
