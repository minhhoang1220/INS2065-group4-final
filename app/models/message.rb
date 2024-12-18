class Message < ApplicationRecord
    belongs_to :match, foreign_key: 'matchID'
    belongs_to :sender, class_name: 'Usertable', foreign_key: 'senderID'
    belongs_to :receiver, class_name: 'Usertable', foreign_key: 'receiverID'
  

    validates_presence_of :matchID, :senderID, :receiverID, :messageText, :messageTimestamp
    validates_length_of :messageText, maximum: 500, message: 'Message text cannot exceed 500 characters'
    validate :users_must_be_matched

    scope :between_users, ->(user1_id, user2_id) {
      where("(senderID = ? AND receiverID = ?) OR (senderID = ? AND receiverID = ?)", 
            user1_id, user2_id, user2_id, user1_id)
    }

    private

    def users_must_be_matched
      unless Match.exists?(User1ID: senderID, User2ID: receiverID) || Match.exists?(User1ID: receiverID, User2ID: senderID)
        errors.add(:base, "Users must be matched to send messages")
      end
    end

    def self.search(term)
      if term
        where('messageText LIKE ?', "%#{term}%")
      else
        all
      end
    end    
end
