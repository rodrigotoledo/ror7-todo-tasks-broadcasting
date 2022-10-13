# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :todos, dependent: :destroy
  after_create :create_in_broadcast_service

  private

  def create_in_broadcast_service
    uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=#{Rails.application.credentials.firebase_api_key}")
    response = Net::HTTP.post_form(uri, email: email, password: password)
    data = JSON.parse(response.body)

    update(external_auth_id: data['localId'])
  end
end
