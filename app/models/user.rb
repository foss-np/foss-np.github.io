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

  before_save { |user| user.email = email.downcase }

  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
