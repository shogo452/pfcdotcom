# frozen_string_literal: true

json.array! @tags do |tag|
  json.name tag.name
end
