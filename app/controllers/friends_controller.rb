class FriendsController < ApplicationController
  before_action :set_user

  # GET /users/:user_id/friends
  def index
    render json: @user.friends
  end

  # POST /users/:user_id/friends
  def create
    friend = Friend.new(friend_params)
    friend.user_id = params[:user_id]
    if friend.valid?
      inverse_friendship = Friend.new({user_id: params['data']['attributes'][:friend_id], friend_id: params[:user_id]})
      friend.save
      inverse_friendship.save
      render json: [friend, inverse_friendship], status: :created
    else
      render json: friend, adapter: :json_api,
             serializer: ActiveModel::Serializer::ErrorSerializer,
             status: :unprocessable_entity
    end
  end

  # DELETE /users/:user_id/friends/:id
  def destroy
    friend = @user.friends.where(id: params[:id]).first
    inverse_friendship = Friend.where(user_id: friend.friend_id, friend_id: friend.user_id).first
    friend.destroy
    inverse_friendship.destroy
    head :no_content
  end

  private

  def friend_params
    params.require(:data).require(:attributes).
        permit(:user_id, :friend_id) ||
        ActionController::Parameters.new
  end

  def set_user
    @user = User.find(params[:user_id])
  end

end