module CustomHelper
  def get_icon_class(name)
    case name.to_s.downcase
    when 'user', 'usertable'
      'fa-user'
    when 'message'
      'fa-envelope'
    when 'match'
      'fa-heart'
    when 'membership'
      'fa-crown'
    when 'swipe'
      'fa-hand-pointer'
    when 'dashboard'
      'fa-chart-bar'
    else
      'fa-database'
    end
  end
end 