class Swipe < ApplicationRecord
    belongs_to :swiper, class_name: 'Usertable', foreign_key: 'SwiperUserID'
    belongs_to :swiped_user, class_name: 'Usertable', foreign_key: 'SwipedUserID'

    validates_presence_of :SwiperUserID, :SwipedUserID, :SwipeType
    validates_inclusion_of :SwipeType, in: %w[like dislike]
    validates_uniqueness_of :SwiperUserID, scope: :SwipedUserID, message: 'User can only swipe another user once'

    before_create :set_timestamp

    private

    def set_timestamp
        self.SwipeTimestamp = Time.current
    end
end
