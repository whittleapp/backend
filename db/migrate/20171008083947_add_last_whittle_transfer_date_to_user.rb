class AddLastWhittleTransferDateToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :last_whittle_transfer_date, :date
  end
end
