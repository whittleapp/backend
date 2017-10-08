class AddWhittleAndTargetToBusinesses < ActiveRecord::Migration[5.1]
  def change
    add_column :businesses, :whittle, :boolean, default: false
    add_column :businesses, :whittle_target, :float, default: 0
  end
end
