class AddIgnoreToBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_column :businesses, :ignore, :boolean, default: false
  end
end
