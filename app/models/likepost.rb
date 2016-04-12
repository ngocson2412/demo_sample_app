class Likepost < ActiveRecord::Base
	belongs_to :user, class_name: "User"
  	belongs_to :post, class_name: "Micropost"
  	validates :user_id, presence: true
  	validates :post_id, presence: true
end
