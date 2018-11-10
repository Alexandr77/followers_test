class User < ApplicationRecord
  belongs_to :group, inverse_of: :users
  has_many :followers, inverse_of: :user
  has_many :subscriptions, foreign_key: 'follower_id', class_name: 'Follower'

  validates :group, :name, presence: true

  def is_followed_by?(current_user)
    return true if follower(current_user)
  end

  def follower(current_user)
    @follower ||= followers.find { |i| i.follower_id == current_user.id }
  end
end
