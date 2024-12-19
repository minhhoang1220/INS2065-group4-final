module MessagesHelper
  def should_show_timestamp?(message)
    # Lấy tin nhắn trước đó
    previous_message = @messages
                        .where('"messages"."messageTimestamp" < ?', message.messageTimestamp)
                        .order('"messages"."messageTimestamp" DESC')
                        .first

    # Hiển thị timestamp nếu:
    # 1. Đây là tin nhắn đầu tiên
    return true if previous_message.nil?

    # 2. Người gửi khác với tin nhắn trước
    return true if previous_message.senderID != message.senderID

    # 3. Khoảng thời gian giữa 2 tin nhắn > 15 phút
    time_diff = (message.messageTimestamp - previous_message.messageTimestamp) / 60 # Chuyển đổi sang phút
    return true if time_diff > 15

    false
  end

  # Helper method để format timestamp
  def format_message_time(timestamp)
    if timestamp.today?
      timestamp.strftime("%H:%M")
    else
      timestamp.strftime("%d/%m/%Y %H:%M")
    end
  end
end
