class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :id, type: String
  field :subject, type: String
  field :contents, type: String
  field :user_id, type:String

  # _idカラムに関するバリデーション
  validates :id,{presence: true}

  # subjectカラムに関するバリデーション
  validates :subject,{presence: true}
  
  # contentsカラムに関するバリデーション
  validates :contents,{presence: true}

  # user_idカラムに関するバリデーション
  validates :user_id,{presence: true}

  def user
    return User.find_by(id: self.user_id)
  end

  def likeCount
    return Like.where(post_id: self.id).count
  end

  def like(current_id)
    return Like.find_by(user_id: current_id,post_id: self.id)
  end
end
