# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  username     :string(255)
#  email        :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  topics_count :integer          default(0)
#  posts_count  :integer          default(0)
#

class User < ActiveRecord::Base
	attr_accessible :username, :email, :password, :password_confirmation
  has_secure_password
  has_many :topics, :dependent => :destroy
	has_many :posts, :dependent => :destroy

  before_save { |user| user.email = email.downcase
                        user.username = username.downcase
               }
  before_save :create_remember_token

  extend FriendlyId
  friendly_id :username

  VALID_USERNAME_REGEX = /\A[a-z0-9]+\z/i
  validates :username, presence: true, length: { maximum: 50 }, 
            format: {with: VALID_USERNAME_REGEX}, uniqueness: { case_sensitive: false },
            length: {minimum: 3}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
