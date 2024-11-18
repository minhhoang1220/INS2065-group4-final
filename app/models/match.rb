class Match < ApplicationRecord
    belongs_to :user1, class_name: 'Usertable'
    belongs_to :user2, class_name: 'Usertable'
    has_many :messages

    validates_presence_of :User1ID, :User2ID
    validates_uniqueness_of :User1ID, scope: :User2ID, message: 'Match already exists between these users'
    validate :users_cannot_match_themselves

    def users_cannot_match_themselves
        errors.add(:User1ID, 'cannot match with themselves') if User1ID == User2ID
    end
end
