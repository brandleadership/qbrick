module Qbrick
  module Cms
    class BackendController < ActionController::Base
      respond_to :html
      layout 'qbrick/cms/application'
      before_action :set_content_locale, :authenticate_admin!
      after_action :reset_remembered_locale

      def set_content_locale
        # this was taken from: https://github.com/screenconcept/hieronymus_shop/pull/218/files
        # and needs further work:
        # TODO: document how to implement in frontend
        # TODO: implement frontend part in our rails_template
        # TODO: add specs
        new_locale = params[:content_locale] || session['backend_locale'] || I18n.locale
        session['backend_locale'] = new_locale.to_s
        return if I18n.locale == new_locale || !I18n.locale_available?(new_locale)

        session['remembered_locale'] = I18n.locale
        I18n.locale = new_locale
      end

      def reset_remembered_locale
        return if session['remembered_locale'].blank?

        I18n.locale = session.delete 'remembered_locale'
      end

      def default_url_options
        { content_locale: I18n.locale }.merge(super)
      end
    end
  end
end
