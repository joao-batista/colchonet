class Room < ActiveRecord::Base
  extend FriendlyId

  has_many :reviews, dependent: :destroy 
  has_many :reviewed_rooms, through: :reviews, source: :room
  belongs_to :user
  
  validates :title, presence: true 
  validates :location, presence: true 
  validates :description, presence: true, length: { minimum: 10 }
  validates :slug, presence: true
  validates :picture, presence: true

  friendly_id :title, use: [:slugged, :finders]
  mount_uploader :picture, PictureUploader 
  scope :most_recent, -> { order('created_at DESC') }
  
  def complete_name 
    "#{title}, #{location}"
  end 

  def self.search(query) 
    if query.present? 
      where(['location LIKE :query OR title LIKE :query 
        OR description LIKE :query', :query => "%#{query}%"])
    else
      all
    end
  end

end
