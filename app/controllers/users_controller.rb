class UsersController < ApplicationController
  rescue_from ApiExceptions::BaseException,
              :with => :render_error_response

  HEADING = 'heading'

  # GET /users
  def index
    users = User.order(:last_name)
    render json: users
  end

  # GET /users/:id
  def show
    render json: User.find(params[:id])
  end

  # POST /users
  def create
    user = User.new(user_params)
    if user.valid?
      tinylink = Tinylink.shorten(params['data']['attributes'][:website])
      user.website = tinylink
      user.save
      output = Scraper.scrape_url(user.website)
      if output.any?
        write_user_data(user.id, output)
      end
      render json: user, status: :created
    else
      render json: user, adapter: :json_api,
             serializer: ActiveModel::Serializer::ErrorSerializer,
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:data).require(:attributes).
        permit(:first_name, :last_name, :website) ||
        ActionController::Parameters.new
  end

  def write_user_data(user_id, data)
    data.each do |header|
      datum = Userdatum.new({user_id: user_id, data_type: HEADING, data: header})
      if datum.valid?
        datum.save
      else
        raise ApiExceptions::ScraperError::HeadingError
      end
    end
  end

  def render_error_response(error)
    render json: error, each_serializer: ApiExceptionSerializer, status: 400
  end
end