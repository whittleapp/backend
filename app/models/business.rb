class Business < ApplicationRecord
  validates :name, presence: true
  
  has_many :transactions

  def monthly_total(date)
    sum = 0
    self.monthly_transactions(date).each do |transaction|
      sum += transaction.posted_amount
    end
    sum
  end

  def monthly_transactions(date)
    self.transactions.select{ |transaction| transaction.month == date.month }
  end
end
