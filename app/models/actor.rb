class Actor < ActiveRecord::Base
  has_many :casts, dependent: :destroy
  has_many :movies, through: :casts
end
