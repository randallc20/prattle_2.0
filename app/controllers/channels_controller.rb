class ChannelsController < ApplicationController
  def index
    render json: Channel.all
  end

  def create
    channel_exists = Channel.find_by(channel_name: params[:channelName])
    if (!channel_exists)
      new_channel = Channel.create(channel_name: params[:channelName])
      created_by = User.find_by(id: params[:userId])
      ChannelUser.create(user: created_by, channel: new_channel)
      render json: new_channel
    else
      render json: { error: "channel already exists" }
    end
  end

  def join
    channel_exists = Channel.find_by(channel_name: params[:channelName])
    if (channel_exists)
      joined_by = User.find_by(id: params[:userId])
      ChannelUser.create(user: joined_by, channel: channel_exists)
      render json: channel_exists
    else
      render json: { error: "channel does not exist" }
    end
  end

  def search
    matches =
      Channel.all.filter do |channel|
        channel["channel_name"].include?(params["channel_name"])
      end
    search =
      matches.map do |match|
        { "channel_id" => match["id"], "channel_name" => match["channel_name"] }
      end
    render json: search
  end

  def messages
    channel = Channel.find_by(channel_name: params[:channelName])
    render json: channel.serialize_channel_messages
  end
end
