# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :set_flag_no_footer
    before_action :forbid_test_user, only: [:update]
    prepend_before_action :check_captcha, only: [:create]
    # before_action :configure_sign_up_params, only: [:create]
    # before_action :configure_account_update_params, only: [:update]

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    # def create
    #   super
    # end

    # GET /resource/edit
    # def edit
    #   super
    # end

    # PUT /resource
    def update
      super
      resource.avatar.attach(account_update_params[:avatar]) if account_update_params[:avatar].present?
    end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_up_params
    #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
    # end

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_account_update_params
    #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    # end

    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end

    def set_flag_no_footer
      @flag = true
    end

    private

      def forbid_test_user
        return unless @user.email == 'test@example.com'

        flash[:notice] = 'テストユーザーのため変更できません'
        redirect_to root_path
      end

      def check_captcha
        return if verify_recaptcha

        self.resource = resource_class.new sign_up_params
        resource.validate
        return if verify_recaptcha(model: resource)

        respond_with_navigational(resource) { render :new }
      end
  end
end
