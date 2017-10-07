require 'httparty'

class User < ApplicationRecord
  has_many :accounts

  def create_accounts
    p HTTParty.get('https://www.google.com')
  end
end
