class Tag < ActiveRecord::Base
  belongs_to :expense

  validates_presence_of :expense
end
