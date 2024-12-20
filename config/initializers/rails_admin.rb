RailsAdmin.config do |config|
  config.asset_source = :sprockets

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true
  config.main_app_name = ["Dating App", "- Admin Panel"]

  config.actions do
    dashboard do
      statistics true
      template 'main/dashboard'
    end
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  
  config.model 'Usertable' do
    list do
      field :name
      field :email
      field :membership
      # other fields
    end
  end

  config.model 'Dashboard' do
    navigation_label 'Analytics'
    
    list do
      field :total_users do
        formatted_value do
          bindings[:object].instance_eval do
            Usertable.count
          end
        end
      end

      field :premium_users do
        formatted_value do
          bindings[:object].instance_eval do
            Usertable.where(membership: 'premium').count
          end
        end
      end

      field :total_matches do
        formatted_value do
          bindings[:object].instance_eval do
            Match.count
          end
        end
      end

      field :messages_today do
        formatted_value do
          bindings[:object].instance_eval do
            Message.where('created_at >= ?', Time.zone.now.beginning_of_day).count
          end
        end
      end
    end
  end
end
