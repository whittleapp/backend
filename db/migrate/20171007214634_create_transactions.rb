class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.date :posted_date, null: false 
      t.float :posted_amount, null: false 
      # t.integer :operator_id, null: false 
      t.integer :account_id, null: false 

      t.timestamps
    end
  end
end
