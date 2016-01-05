class Comment < ActiveRecord::Base

  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  belongs_to :user
  belongs_to :micropost

  validates :content, presence: true
  validates :user_id, presence: true
  validates :micropost_id, presence: true
end