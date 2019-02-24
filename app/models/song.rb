class Song < ActiveRecord::Base
  belongs_to :album
  belongs_to :artist

  validates :duration, presence: true
  validates :title, presence: true
end
