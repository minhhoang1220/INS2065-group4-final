class Usertable < ApplicationRecord
    belongs_to :user
    has_many :swipes_as_swiper, class_name: 'Swipe', foreign_key: 'SwiperUserID'
    has_many :swipes_as_swiped, class_name: 'Swipe', foreign_key: 'SwipedUserID'
    has_many :matches_as_user1, class_name: 'Match', foreign_key: 'User1ID'
    has_many :matches_as_user2, class_name: 'Match', foreign_key: 'User2ID'
    has_many :sent_messages, class_name: 'Message', foreign_key: 'SenderID'
    has_many :received_messages, class_name: 'Message', foreign_key: 'ReceiverID'
    has_one_attached :image
    belongs_to :membership, optional: true

    validates_presence_of :name, :email, :age, :gender
    validates :active, inclusion: { in: [true, false] }
    validates_uniqueness_of :email
    validates_numericality_of :age, only_integer: true, greater_than_or_equal_to: 18, less_than_or_equal_to: 100
    validates_inclusion_of :gender, in: %w[male female other]

    attribute :active, :boolean

    def matches
        Match.where('User1ID = :id OR User2ID = :id', id: id)
    end
end
