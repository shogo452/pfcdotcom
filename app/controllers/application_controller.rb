class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from SecurityError do |exception|
      redirect_to root_path, notice: "管理者用のページです。権限があるアカウントでログインしてください。"
    end

    protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :gender, :avatar])
        devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :gender, :avatar])
      end

      def authenticate_admin_user!
        raise SecurityError unless current_user.try(:admin?)
      end
end
