# frozen_string_literal: true

class ErrorsController < ApplicationController
  rescue_from StandardError, with: :internal_server_error
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def show
    raise env['action_dispatch.exception']
  end

  def not_found
    render 'not_found', status: :not_found, layout: 'error'
  end

  def internal_server_error
    render 'internal_server_error', status: :internal_server_error, layout: 'error'
  end
end
