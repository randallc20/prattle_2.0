class UserWithFriendsSerializer < ActiveModel::Serializer
  attributes :id, :username, :friends

  has_many :channels

  # def pairs
  #   pair_hash = self.pairs.map { |pair| pair.attributes }
  #   return pair_hash
  # end

  def friends
    friends_hash =
      self.object.friends.map do |friend|
        {
          "username" => friend.attributes["username"],
          "id" => friend.attributes["id"]
        }
      end
    return friends_hash
  end
end
