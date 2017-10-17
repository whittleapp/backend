require 'httparty' 

class Account < ApplicationRecord
  validates :operating_company_identifier, :product_code, :primary_identifier, :user_id, presence: true

  belongs_to :user
  has_many :transactions

  
  def create_transactions 
    # uses private get_transaction_data method to call api
    transactions_data = get_transactions_data["MonetaryTransactionResponseList"]
    # uses DDA and BCD/CDD methods to determine correct business
    if self.product_code == 'BCD' || self.product_code == 'CCD'
      transactions_data.each do |data|
        business = find_BCD_CCD_business(data)
        business.transactions.create(posted_date: data["PostedDate"], posted_amount: data["PostedAmount"], account_id: self.id)
      end
    elsif self.product_code == 'DDA'
      transactions_data.each do |data|
        business = find_DDA_business(data)
        if business 
          business.transactions.create(posted_date: data["PostedDate"], posted_amount: data["PostedAmount"], account_id: self.id)
        end
      end
    end
  end

  private 

  def get_transactions_data 
    # calls api to get correct transaction data
    HTTParty.post('https://api119622live.gateway.akana.com:443/account/transactions',
      :body => {
        OperatingCompanyIdentifier: self.operating_company_identifier,
        ProductCode: self.product_code,
        PrimaryIdentifier: self.primary_identifier
        }.to_json,
        :headers => {'Content-Type' => 'application/json', 'Accept' => 'application/json'})
  end

  def find_BCD_CCD_business(transaction_data)
    # handles BCD and CCD types
    business = Business.find_by(name: transaction_data["TransactionDescription"])
    if business.nil?
      business = Business.create(name: transaction_data["TransactionDescription"])
    end
    business
  end

  def find_DDA_business(transaction_data)
    # handles DDA types
    if transaction_data["OperatorIdentifier"] != nil
      business = Business.find_by(name: transaction_data["OperatorIdentifier"])
      if business.nil?
        business = Business.create(name: transaction_data["OperatorIdentifier"])
      end
    end
    business
  end

end

