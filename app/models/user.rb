class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :classrooms, dependent: :destroy
  has_one_attached :avatar

  def avatar_thumbnail
    avatar.variant(resize_to_limit: [ 100, 100 ]).processed if avatar.attached?
  end
end
