class UserdataController < ApplicationController
  before_action :set_user

  # GET /users/:user_id/userdata
  def index
    render json: @user.userdata
  end

  # POST /users/:user_id/userdata
  def create
    data = Userdatum.new(data_params)
    data.user_id = params[:user_id]
    if data.valid?
      data.save
      render json: data, status: :created
    else
      render json: data, adapter: :json_api,
             serializer: ActiveModel::Serializer::ErrorSerializer,
             status: :unprocessable_entity
    end
  end

  # DELETE /users/:user_id/userdata/:id
  def destroy
    data = @user.userdata.where(id: params[:id])
    data.destroy
    head :no_content
  end

  private

  def data_params
    params.require(:data).require(:attributes).
        permit(:user_id, :data_type, :data) ||
        ActionController::Parameters.new
  end

  def set_user
    @user = User.find(params[:user_id])
  end

end