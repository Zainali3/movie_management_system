class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  TOKEN = 'qasdfghjyuiop0643werxv'

  has_one :attachment, as: :attachable
  has_many :report_reviews, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :favourite_movies, dependent: :destroy
  has_many :reviews, dependent: :destroy

  accepts_nested_attributes_for :attachment

  def show_profile_picture(style = :original)
    profile_picture = self.attachment
    profile_picture ? profile_picture.try(:image).url(style) : "#{style.to_s}/missing.png"
  end

end
