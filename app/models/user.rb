class User < ActiveRecord::Base
  attr_accessor :remember_token
	before_save { self.email = email.downcase }
	validates :name,  presence: true, length: { maximum: 50 }
 	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    has_secure_password #dam bao la co password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    # Returns the hash digest of the given string.
	def User.digest(string) # ham muc dich ma hoa xau
  	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                BCrypt::Engine.cost
  	BCrypt::Password.create(string, cost: cost)
	end 
  # Returns a random token.
  def User.new_token
      SecureRandom.urlsafe_base64 # tra ve mot chuoi tring bat ki
  end        
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token)) # luu cai chuoi ngau nhien o tren sau khi ma hoa vao remember_digest
  end
  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil? 
    BCrypt::Password.new(remember_digest).is_password?(remember_token) # so sanh mot remember_token voi mot remember_digest co trong database
  end     
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil) # cap nhat remember_degest bang nil
  end
end
