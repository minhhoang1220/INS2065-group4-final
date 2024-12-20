module RailsAdmin
  module CustomHelper
    def model_icon(model)
      case model.label
      when 'User', 'Usertable'
        'fa-user'
      when 'Message'
        'fa-envelope'
      when 'Match'
        'fa-heart'
      when 'Membership'
        'fa-crown'
      when 'Swipe'
        'fa-hand-pointer'
      else
        'fa-database'
      end
    end
  end
end 