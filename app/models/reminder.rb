class Reminder < ActiveRecord::Base
  belongs_to :expense

  validates_presence_of :date, :expense
end
