module RailsAdmin
  module ApplicationHelper
    include RailsAdmin::MainHelper
    include CustomHelper

    def page_name
      if @abstract_model
        if @page_name
          "#{@page_name.capitalize} | #{@abstract_model.try(:pretty_name) || @page_name}"
        else
          "#{@abstract_model.try(:pretty_name) || 'Dashboard'}"
        end
      else
        "Dashboard"
      end
    end

    def wording_for(*)
      ""
    end

    def authorized?(action, abstract_model = nil, object = nil)
      true
    end

    def current_action
      @action.key.to_sym if @action
    end

    def current_action?(action, abstract_model = nil)
      @action.custom_key == action.custom_key &&
        (!abstract_model || @abstract_model.try(:to_param) == abstract_model.try(:to_param))
    end

    def link_to_action(action, abstract_model = nil, object = nil)
      action = RailsAdmin::Config::Actions.find(action.to_sym) if action.is_a?(String) || action.is_a?(Symbol)
      wording = wording_for(:menu, action)
      url = rails_admin.url_for(action: action.action_name, controller: 'rails_admin/main', model_name: abstract_model.try(:to_param), id: (object.try(:persisted?) && object.try(:id) || nil))
      link_to wording, url
    end

    def bulk_menu
      render partial: 'rails_admin/main/bulk_menu'
    end

    def menu_for(type, abstract_model = nil, object = nil, only_icon = false)
      bindings = { 
        controller: self, 
        abstract_model: abstract_model,
        object: object
      }
      
      actions = RailsAdmin::Config::Actions.all(type, bindings).select do |action|
        action.enabled? && authorized?(action.authorization_key, abstract_model, object)
      end
      
      actions.map do |action|
        action_label = wording_for(:menu, action)
        action_url = rails_admin.url_for(action: action.action_name, controller: 'rails_admin/main', model_name: abstract_model.try(:to_param), id: (object.try(:persisted?) && object.try(:id) || nil))
        
        content_tag(:li, class: 'nav-item') do
          link_to action_url, class: 'nav-link', title: action_label do
            i = content_tag(:i, '', class: "fas #{action.link_icon}")
            only_icon ? i : i + content_tag(:span, action_label)
          end
        end
      end.join.html_safe
    end

    def action(key, abstract_model = nil, object = nil)
      RailsAdmin::Config::Actions.find(key.to_sym, bindings: {
        controller: self,
        abstract_model: abstract_model,
        object: object
      })
    end
  end
end 