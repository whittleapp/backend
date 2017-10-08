class Business < ApplicationRecord
  validates :name, presence: true
  
  has_many :transactions
end
