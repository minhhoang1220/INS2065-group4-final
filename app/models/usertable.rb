class Usertable < ApplicationRecord
    require_relative '../models/concerns/membership_statistics'
    include MembershipStatistics
    belongs_to :user, dependent: :destroy
    has_many :swipes_as_swiper, class_name: 'Swipe', foreign_key: 'SwiperUserID'
    has_many :swipes_as_swiped, class_name: 'Swipe', foreign_key: 'SwipedUserID'
    has_many :matches_as_user1, class_name: 'Match', foreign_key: 'User1ID'
    has_many :matches_as_user2, class_name: 'Match', foreign_key: 'User2ID'
    has_many :sent_messages, class_name: 'Message', foreign_key: 'SenderID'
    has_many :received_messages, class_name: 'Message', foreign_key: 'ReceiverID'
    belongs_to :membership, optional: true

    validates_presence_of :name, :email, :age, :gender
    validates :active, inclusion: { in: [true, false] }
    validates_uniqueness_of :email
    validates_numericality_of :age, only_integer: true, greater_than_or_equal_to: 18, less_than_or_equal_to: 100
    validates_inclusion_of :gender, in: %w[male female other]

    attribute :active, :boolean

    scope :active, -> { where(active: true) }
    scope :premium, -> { joins(:membership).where(memberships: { TypeMem: 'premium' }) }
    scope :recent, -> { where('created_at >= ?', 30.days.ago) }

    def matches
        Match.where('User1ID = :id OR User2ID = :id', id: id)
    end

    rails_admin do
        configure :image do
            pretty_value do
                if value.attached?
                    bindings[:view].tag(:img, src: bindings[:view].main_app.url_for(value), class: 'img-thumbnail')
                else
                    "No Image"
                end
            end
        end
    end

    before_destroy :purge_image

    private

    def purge_image
      # image.purge if image.attached?
    end
end
