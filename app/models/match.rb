class Match < ApplicationRecord
    belongs_to :user1, class_name: 'Usertable', foreign_key: 'User1ID'
    belongs_to :user2, class_name: 'Usertable', foreign_key: 'User2ID'
    has_many :messages, foreign_key: 'matchID'

    validates_presence_of :User1ID, :User2ID
    validates_uniqueness_of :User1ID, scope: :User2ID, message: 'Match already exists between these users'
    validate :users_cannot_match_themselves

    # Lấy profile của người còn lại trong match
    def get_other_profile(current_user_id)
        if self.User1ID == current_user_id
            self.user2
        else
            self.user1
        end
    end

    # Lấy tất cả matches của một user
    def self.get_user_matches(user_id)
        where('"matches"."User1ID" = :user_id OR "matches"."User2ID" = :user_id', user_id: user_id)
    end

    private

    def users_cannot_match_themselves
        errors.add(:base, 'Users cannot match with themselves') if self.User1ID == self.User2ID
    end

    def self.search(term)
        if term
            joins(:user1, :user2)
                .where('usertables.name LIKE ?', "%#{term}%")
        else
            all
        end
    end
end
