# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  state      :boolean          default(TRUE)
#  position   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ActiveRecord::Base
  
  # Associations
  has_many :forums, :dependent => :destroy
  
  # Accessors
  attr_accessible :title, :state, :position, :category_id
  
  # Scopes
  default_scope :order => 'position ASC'
  
  # Validations
  validates :title,       :presence => true
end
