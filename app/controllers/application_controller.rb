# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :success, :info, :warning, :danger

  rescue_from SecurityError do |_exception|
    redirect_to root_path, warning: '管理者用のページです。権限があるアカウントでログインしてください。'
  end

  unless Rails.env.development?
    rescue_from ActiveRecord::RecordNotFound, with: :error404
    rescue_from Exception, with: :error500
  end

  def error404
    render file: "#{Rails.root}/public/404.html",
           layout: false, status: :not_found
  end

  def error500(error)
    logger.error error
    logger.error error.backtrace.join("\n\n")
    render file: "#{Rails.root}/public/500.html",
           layout: false, status: :internal_server_error
  end

  def twitter_image_url
    url = image_url('twitter_card.png')
    url = "https:#{url}" if %r{/\A\W/s3/}.match?(url)
    url
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[nickname gender avatar])
      devise_parameter_sanitizer.permit(:account_update, keys: %i[nickname gender avatar])
    end

    def authenticate_admin_user!
      raise SecurityError unless current_user.try(:admin?)
    end
end
