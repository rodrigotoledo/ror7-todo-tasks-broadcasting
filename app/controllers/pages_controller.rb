require 'net/http'
require 'uri'
require 'json'
class PagesController < ApplicationFirebaseController
  layout :set_layout
  before_action :set_user_data, only: %i[signup login]
  before_action :authenticate_user, except: %i[signup login]

  def login
    uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=#{Rails.application.credentials.firebase_api_key}")

    response = Net::HTTP.post_form(uri, email: @email, password: @password)
    data = JSON.parse(response.body)

    if response.is_a?(Net::HTTPSuccess)
      session[:user_id] = data['localId']
      session[:data] = data
      redirect_to home_path, notice: 'Login with success'
    end
  end

  def signup
    uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=#{Rails.application.credentials.firebase_api_key}")

    response = Net::HTTP.post_form(uri, email: @email, password: @password)
    data = JSON.parse(response.body)

    session[:user_id] = data['localId']
    session[:data] = data

    redirect_to home_path, notice: 'Signup with success' if response.is_a?(Net::HTTPSuccess)
  end

  def home
    @todos = TodosService.all
  end

  private

  def set_user_data
    @email = params[:email]
    @password = params[:password]
  end

  def set_layout
    case action_name
    when 'signup', 'login'
      'devise'
    else
      'application_firebase'
    end
  end

  def authenticate_user
    redirect_to login_path, notice: 'You must be logged' unless current_user
  end
end
