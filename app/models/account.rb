require 'httparty' 

class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  def create_transactions 
    response = HTTParty.post('https://api119622live.gateway.akana.com:443/account/transactions',
      :body => {
        OperatingCompanyIdentifier: self.operating_company_identifier,
        ProductCode: self.product_code,
        PrimaryIdentifier: self.primary_identifier
      }.to_json,
      :headers => {'Content-Type' => 'application/json', 'Accept' => 'application/json'})

    transactions_data = response["MonetaryTransactionResponseList"]
    transactions_data.each do |data|
      business = Business.find_by(name: data["TransactionDescription"])
      if business.nil?
        business = Business.create(name: data["TransactionDescription"])
      end

      business.transactions.create(posted_date: data["PostedDate"], posted_amount: data["PostedAmount"], account_id: self.id)
    end

  end

end
