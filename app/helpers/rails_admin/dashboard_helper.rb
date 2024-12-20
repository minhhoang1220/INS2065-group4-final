module RailsAdmin
  module DashboardHelper
    def user_growth_rate
      current_month = Usertable.where('created_at >= ?', 1.month.ago).count
      last_month = Usertable.where(created_at: 2.months.ago..1.month.ago).count
      growth = ((current_month - last_month).to_f / last_month * 100).round(1)
      growth.positive? ? "+#{growth}%" : "#{growth}%"
    end

    def active_users_count
      Message.where('created_at >= ?', 7.days.ago)
            .select(:senderID)
            .distinct
            .count
    end

    def premium_conversion_rate
      total = Usertable.count
      premium = Usertable.where(membership: 'premium').count
      rate = (premium.to_f / total * 100).round(1)
      "#{rate}%"
    end

    def format_membership_stats
      Usertable.joins(:membership)
               .group('memberships.membership_type')
               .count
               .transform_keys { |key| key.titleize }
    end
  end
end 