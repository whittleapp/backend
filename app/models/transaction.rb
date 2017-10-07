class Transaction < ApplicationRecord
  belongs_to :business
  belongs_to :account 

  def initialize(args)
    super
  end
end
