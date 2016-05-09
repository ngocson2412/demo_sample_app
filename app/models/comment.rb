class Comment < ActiveRecord::Base

  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  belongs_to :user
  belongs_to :micropost
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  validates :content, length: {maximum: 140}
  has_many :passive_likes, class_name:  "Like",
                                   foreign_key: "liked_id",
                                   dependent:   :destroy
  has_many :likers, through: :passive_likes, source: :liker   
  validate :picture_size

  def picture_size
    if picture.size > 5.megabytes
      error.add(:picture, "should be less than 5MB")
    end
  end                             
end