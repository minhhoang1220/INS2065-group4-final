class AddDefaultMembershipToExistingUsers < ActiveRecord::Migration[7.0]
  def up
    default_membership = Membership.default_tier
    Usertable.where(membership_id: nil).update_all(membership_id: default_membership.id)
  end

  def down
    # No need to revert as this is a data fix
  end
end