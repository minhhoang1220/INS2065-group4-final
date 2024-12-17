class Message < ApplicationRecord
    belongs_to :match
    belongs_to :sender, class_name: 'Usertable', foreign_key: 'senderID'
    belongs_to :receiver, class_name: 'Usertable', foreign_key: 'receiverID'
  

    validates_presence_of :matchID, :senderID, :receiverID, :messageText
    validates_length_of :messageText, maximum: 500, message: 'Message text cannot exceed 500 characters'
    validate :sender_and_receiver_must_be_part_of_match

    def sender_and_receiver_must_be_part_of_match
      unless Match.where(id: match_id).where('User1ID = ? OR User2ID = ?', sender_id, sender_id)
                  .where('User1ID = ? OR User2ID = ?', receiver_id, receiver_id).exists?
        errors.add(:base, 'Sender and Receiver must be part of the match')
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
