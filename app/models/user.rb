require 'httparty'

class User < ApplicationRecord
  has_many :accounts

  def create_accounts
    # call api to get account info

    # create an account for each of them
    response = HTTParty.post('http://api119525live.gateway.akana.com:80/user/accounts',
      :body => {LegalParticipantIdentifier: self.participant_id}.to_json,
      :headers =>{'Content-Type' => 'application/json', 'Accept' => 'application/json'})
    
    response["AccessibleAccountDetailList"].each do |account_data|
      Account.create({
        operating_company_identifier: account_data["OperatingCompanyIdentifier"],
        product_code: account_data["ProductCode"],
        primary_identifier: account_data["PrimaryIdentifier"],
        user_id: self.id 
        })
    end
  end
end
