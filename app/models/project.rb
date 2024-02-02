class Project < ApplicationRecord
  has_many :workreports
  has_many :users, through: :workreports
end
