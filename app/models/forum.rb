# == Schema Information
#
# Table name: forums
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  description  :text
#  state        :boolean          default(TRUE)
#  topics_count :integer          default(0)
#  posts_count  :integer          default(0)
#  position     :integer          default(0)
#  category_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Forum < ActiveRecord::Base
  
  # Associations
  has_many :topics, :dependent => :destroy
  has_many :posts, :through => :topics
  
  belongs_to :category
  
  # Accessors
  attr_accessible :title, :description, :state, :position, :category_id
  
  # Scopes
  default_scope :order => 'position ASC'
  
  # Validations
  validates :title,       :presence => true
  validates :description, :presence => true
  validates :category_id, :presence => true
end
