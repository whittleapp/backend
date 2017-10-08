class Transaction < ApplicationRecord
  validates :posted_date, :posted_amount, :business_id, :account_id, presence: true

  belongs_to :business
  belongs_to :account 

  def initialize(args)
    super
  end

  def month
    self.posted_date.month
  end
end
