class UserConnection < ApplicationRecord
  belongs_to :user
  belongs_to :user_pair
end
