class HandleExistingUsertables < ActiveRecord::Migration[7.0]
  def up
    # First, remove any duplicate email entries if they exist
    duplicates = Usertable.group(:email).having('count(*) > 1').pluck(:email)
    duplicates.each do |email|
      records = Usertable.where(email: email).order(created_at: :asc)
      records[1..-1].each(&:destroy) # Keep the oldest record, delete others
    end

    # Then associate existing usertables with users
    Usertable.find_each do |usertable|
      if user = User.find_by(email: usertable.email)
        usertable.update_column(:user_id, user.id)
      end
    end
  end

  def down
    # No need to reverse this data migration
  end
end 