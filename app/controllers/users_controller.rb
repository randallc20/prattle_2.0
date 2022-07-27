class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show
    user = User.find_by(id: params[:id])
    render json: user, serializer: UserWithFriendsSerializer
  end

  def search
    matches =
      User.all.filter { |user| user["username"].include?(params["username"]) }
    search =
      matches.map do |match|
        { "user_id" => match["id"], "username" => match["username"] }
      end
    render json: search
  end

  def add_friend
    user = User.find_by(id: params[:userId])
    new_friend = User.find_by(username: params[:friendName])
    if (new_friend)
      if (user.friends?(new_friend))
        render json: {
                 error: "you and #{params[:friendName]} are already friends"
               }
      else
        user.become_friends(new_friend)
        render json: {
                 "username" => new_friend.attributes["username"],
                 "id" => new_friend.attributes["id"]
               }
      end
    else
      render json: { error: "#{params[:friendName]} does not exist" }
    end
  end

  def user_messages
    user = User.find_by(id: params[:id])
    connection = User.find_by(username: params[:username])
    render json: user.current_pair_messages(connection)
  end

  def send_message
    user = User.find_by(id: params[:user_id])
    recipient = User.find_by(username: params[:recipient])
    render json: user.send_pair_message(recipient, params[:message])
  end

  def channels_send_message
    user = User.find_by(id: params[:user_id])
    recipient = Channel.find_by(channel_name: params[:recipient])
    render json: user.send_channel_message(recipient, params[:message])
  end

  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      render json: { success: true, user_id: user.id, message: "success" }
    else
      render json: { success: false, user_id: 0, message: "please try again" }
    end
  end

  def signup
    user = User.find_by(username: params[:username])
    if user
      render json: {
               success: false,
               user_id: 0,
               message: "this username is taken"
             }
    else
      user =
        User.create(
          username: params[:username],
          password: params[:password],
          logged_in: true
        )
      render json: { success: true, user_id: user.id, message: "success" }
    end
  end
end
