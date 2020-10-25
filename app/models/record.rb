class Record < ApplicationRecord
  belongs_to :user
  @datas = Record.all
end