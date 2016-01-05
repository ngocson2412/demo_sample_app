class Comment < ActiveRecord::Base

  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  belongs_to :user
  belongs_to :micropost

  validates :content, presence: true
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  has_many :passive_likes, class_name:  "Like",
                                   foreign_key: "liked_id",
                                   dependent:   :destroy
  has_many :likers, through: :passive_likes, source: :liker                                
end