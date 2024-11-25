class Message < ApplicationRecord
    belongs_to :match
    belongs_to :sender, class_name: 'Usertable'
    belongs_to :receiver, class_name: 'Usertable'

    validates_presence_of :matchID, :senderID, :receiverID, :messageText
    validates_length_of :messageText, maximum: 500, message: 'Message text cannot exceed 500 characters'
    validate :sender_and_receiver_must_be_part_of_match

    def sender_and_receiver_must_be_part_of_match
        unless Match.where(id: matchID).where('User1ID = ? OR User2ID = ?', senderID, senderID)
                .where('User1ID = ? OR User2ID = ?', receiverID, receiverID).exists?
            errors.add(:base, 'Sender and Receiver must be part of the match')
        end
    end

end
