# frozen_string_literal: true

class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :product, optional: true

  belongs_to :review, optional: true
  belongs_to :room, optional: true
  belongs_to :message, optional: true
  belongs_to :visiter, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true
end
