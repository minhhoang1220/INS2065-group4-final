# Require models
require 'user'
require 'usertable' 
require 'message'
require 'match'
require 'membership'
require 'swipe'

RailsAdmin.config do |config|
  config.asset_source = :sprockets

  config.main_app_name = ["Dating App", "- Admin Panel"]

  # Cấu hình navigation
  config.navigation_static_links = {
    'Logout' => '/users/sign_out'
  }
  
  config.navigation_static_label = "Links"

  # Eager load models
  config.included_models = ['User', 'Usertable', 'Message', 'Match', 'Membership', 'Swipe']

  config.parent_controller = 'ApplicationController'

  # Thêm helper methods
  config.model 'RailsAdmin::Main' do
    visible false
  end

  config.actions do
    dashboard do
      statistics true
    end
    index                         # mandatory
    new
    export
    bulk_delete do
      only ['Usertable', 'Message', 'Match']
    end
    show
    edit
    delete do
      controller do
        proc do
          if @object.destroy
            flash[:success] = "#{@model_config.label} successfully deleted"
            redirect_to index_path
          else
            flash[:error] = "#{@model_config.label} could not be deleted"
            redirect_to index_path
          end
        end
      end
    end
    show_in_app
  end
  
  config.model 'Usertable' do
    label 'Profile'
    label_plural 'Profiles'
    
    list do
      field :id
      field :name
      field :email
      field :age
      field :gender
      field :active, :boolean do
        label 'Status'
        formatted_value do
          bindings[:object] ? 'Active' : 'Inactive'
        end
      end
      field :membership
      field :created_at
    end

    edit do
      field :name
      field :email
      field :age
      field :gender
      field :active, :boolean do
        label 'Status'
        formatted_value do
          bindings[:object] ? 'Active' : 'Inactive'
        end
      end
      field :membership do
        render do
          bindings[:view].render partial: 'select_membership', locals: {
            field: self,
            form: bindings[:form],
            memberships: Membership.all
          }
        end
      end
    end

    show do
      field :id
      field :name
      field :email
      field :age
      field :gender
      field :active
      field :membership
      field :created_at
      field :updated_at
    end
  end

  config.model 'Membership' do
    list do
      field :id
      field :TypeMem
      field :price
      field :description
      field :created_at
    end

    edit do
      field :TypeMem
      field :price
      field :description
    end
  end

  config.model 'Message' do
    list do
      field :id
      field :senderID
      field :receiverID
      field :messageText
      field :messageTimestamp
      field :actions, :string do
        label 'Actions'
        formatted_value do
          bindings[:view].render partial: 'message_actions', locals: { 
            object: bindings[:object],
            model_name: 'message'
          }
        end
      end
    end

    edit do
      field :senderID
      field :receiverID
      field :messageText
      field :messageTimestamp
    end
  end

  config.model 'Match' do
    list do
      field :id
      field :User1ID
      field :User2ID
      field :created_at
    end

    edit do
      field :User1ID
      field :User2ID
    end
  end

  config.model 'Dashboard' do
    navigation_label 'Analytics'
    
    list do
      field :total_users do
        formatted_value do
          bindings[:object].instance_eval do
            Usertable.count rescue 0
          end
        end
      end

      field :premium_users do
        formatted_value do
          bindings[:object].instance_eval do
            begin
              Usertable.joins(:membership)
                      .where(memberships: { TypeMem: 'premium' })
                      .count
            rescue
              0
            end
          end
        end
      end

      field :total_matches do
        formatted_value do
          bindings[:object].instance_eval do
            Match.count rescue 0
          end
        end
      end

      field :messages_today do
        formatted_value do
          bindings[:object].instance_eval do
            Message.where('created_at >= ?', Time.zone.now.beginning_of_day).count rescue 0
          end
        end
      end
    end
  end

  config.model 'User' do
    list do
      field :id
      field :email
      field :first_name
      field :last_name
      field :admin
      field :created_at
      field :updated_at
      field :actions, :string do
        label 'Actions'
        formatted_value do
          bindings[:view].render partial: 'list_actions', locals: { 
            object: bindings[:object],
            model_name: 'user',
            edit_url: bindings[:view].edit_path(model_name: 'user', id: bindings[:object].id),
            delete_url: bindings[:view].delete_path(model_name: 'user', id: bindings[:object].id)
          }
        end
      end
    end

    edit do
      field :email
      field :password
      field :password_confirmation
      field :first_name
      field :last_name
      field :admin, :boolean do
        label 'Admin Access'
        formatted_value do
          bindings[:object] ? 'Yes' : 'No'
        end
        render do
          bindings[:view].render partial: 'boolean_field', locals: {
            field: self,
            form: bindings[:form],
            value: bindings[:object].admin
          }
        end
      end
    end
  end

  # Áp dụng cấu hình actions cho các model còn lại
  ['Membership', 'Match'].each do |model_name|
    config.model model_name do
      list do
        field :actions, :string do
          label 'Actions'
          formatted_value do
            bindings[:view].render partial: 'list_actions', locals: { 
              object: bindings[:object],
              model_name: model_name.downcase,
              edit_url: bindings[:view].edit_path(model_name: model_name.downcase, id: bindings[:object].id),
              delete_url: bindings[:view].delete_path(model_name: model_name.downcase, id: bindings[:object].id)
            }
          end
        end
      end
    end
  end

  # Cập nhật cấu hình chung cho tất cả models
  config.models do |config|
    config.list.fields.reject! { |f| f.name == :_id }
    config.list.fields.reject! { |f| f.name == :id && f.class == RailsAdmin::Config::Fields::Types::Id }
  end
end
