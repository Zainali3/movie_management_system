class Actor < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }
  has_many :casts, dependent: :destroy
  has_many :movies, through: :casts
end
