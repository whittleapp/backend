require 'httparty'

class User < ApplicationRecord
  has_many :accounts
  
  def create_accounts
    # create an account for each of users accounts in their information
    account_details = get_account_details
    # checks for valid account types (certain account types off limits for hackathon test data)
    valid_account_types = ['BCD', 'CCD', 'DDA']
    account_details.each do |account_data|
      if valid_account_types.include?(account_data['ProductCode'])
        # private method handles actual creation
        create_single_account(account_data)
      end
    end
  end

  def transfer_whittle_savings
    if @last_savings_transfer != nil && @last_savings_transfer.month == $date.month
      p "not yet time to transfer again"
    else
      p "transferring whittle savings"
    end
  end
end


private 

  def get_user_data
    # call api to get account info
    HTTParty.post('http://api119525live.gateway.akana.com:80/user/accounts',
      :body => {LegalParticipantIdentifier: self.participant_id}.to_json,
      :headers => {'Content-Type' => 'application/json', 'Accept' => 'application/json'})
  end

  def get_account_details
    # calls private get_user_data method to get api response data and desired parsed data
    response = get_user_data 
    response["AccessibleAccountDetailList"] 
  end

  def create_single_account(account_data) 
    # single account creation
    Account.create({
          operating_company_identifier: account_data["OperatingCompanyIdentifier"],
          product_code: account_data["ProductCode"],
          primary_identifier: account_data["PrimaryIdentifier"],
          user_id: self.id 
          })
  end


