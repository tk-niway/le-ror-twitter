class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :follower, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy # rubocop:disable Rails/InverseOf
  has_many :followed, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy # rubocop:disable Rails/InverseOf

  attachment :profile_image

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    !follower.find_by(followed_id: user.id).nil?
  end
end
