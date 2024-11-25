class Swipe < ApplicationRecord
    belongs_to :swiper, class_name: 'Usertable'
    belongs_to :swiped_user, class_name: 'Usertable'

    validates_presence_of :SwiperUserID, :SwipedUserID, :SwipeType
    validates_inclusion_of :SwipeType, in: %w[like dislike]
    validates_uniqueness_of :SwiperUserID, scope: :SwipedUserID, message: 'User can only swipe another user once'

end
