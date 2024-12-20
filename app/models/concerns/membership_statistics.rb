module MembershipStatistics
  extend ActiveSupport::Concern

  class_methods do
    def membership_distribution
      joins(:membership)
        .group('memberships.TypeMem')
        .count
        .transform_keys { |key| key.titleize }
    end

    def user_growth_stats
      group_by_day(:created_at, last: 30).count
    end
  end
end 