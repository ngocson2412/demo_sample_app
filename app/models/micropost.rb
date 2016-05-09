class Micropost < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy

  default_scope -> { order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, length: {maximum: 140}
  validate :picture_size
  has_many :passive_like_posts, class_name:  "Likepost",
                                   foreign_key: "post_id",
                                   dependent:   :destroy
  has_many :likers_post, through: :passive_like_posts, source: :user   
  def picture_size
    if picture.size > 5.megabytes
      error.add(:picture, "should be less than 5MB")
    end
  end
end