json.extract! message, :id, :matchID, :senderID, :receiverID, :messageText, :messageTimestamp, :created_at, :updated_at
json.url message_url(message, format: :json)
