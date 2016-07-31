class RoomCollectionPresenter 
	delegate :current_page, :num_pages, :total_pages, :limit_value, to: :@rooms

	def initialize(rooms, context) 
		@rooms = rooms 
		@context = context 
	end

	def to_ary 
		@rooms.map do |room| 
			RoomPresenter.new(room, @context, false) 
		end 
	end 
end