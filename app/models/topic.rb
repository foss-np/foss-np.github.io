# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  hits        :integer          default(0)
#  sticky      :boolean          default(FALSE)
#  locked      :boolean          default(FALSE)
#  posts_count :integer
#  forum_id    :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Topic < ActiveRecord::Base
  
  # Associations
  has_many :posts, :dependent => :destroy
  belongs_to :forum, :counter_cache => true
  belongs_to :user, :class_name => "User", :counter_cache => true
  
  # Accessors
  attr_accessor :body
  attr_accessible :title, :body, :sticky, :locked

  extend FriendlyId
  friendly_id :title
  
  # Validations
  validates :title,   :presence => true
  validates :body,    :presence => true, :on => :create
  validates :posts,   :presence => true, :allow_nil => false, :on => :update
  validates :user,    :presence => true
  
  # Scopes
  default_scope :order => 'sticky DESC, updated_at DESC'
  
  # Callbacks
  after_create :create_initial_post
  
  # Methods
  def hit!
    self.class.increment_counter :hits, id
  end
  
  private
    def create_initial_post
      self.posts.build(:body => self.body).tap do |post|
        post.forum = self.forum
        post.user = self.user
        post.save
      end
    end
end
