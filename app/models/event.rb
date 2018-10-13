class Event < ApplicationRecord
  belongs_to :user
  validates :title, :description, :location, :time, :date, :presence => true
end
