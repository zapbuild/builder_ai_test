class Show < ApplicationRecord
  belongs_to :channel
  has_many :favourites
end
