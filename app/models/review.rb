class Review < ActiveRecord::Base
  POINTS = (1..5).to_a
  
  belongs_to :user
  belongs_to :room, counter_cache: true


  validates :points, presence: true
  validates :points, inclusion: { in: POINTS }
  validates :user_id, presence: true
  validates :user_id, uniqueness: { scope: :room_id }
  validates :room_id, presence: true

  def self.stars 
  	(average(:points) || 0).round 
  end 
  
end
