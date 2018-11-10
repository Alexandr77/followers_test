class Follower < ApplicationRecord
  belongs_to :user, inverse_of: :followers, counter_cache: true
end
