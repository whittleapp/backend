class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :operating_company_identifier, null: false 
      t.string :product_code, null: false 
      t.string :primary_identifier, null: false 
      t.integer :user_id, null: false 
      
      t.timestamps
    end
  end
end
