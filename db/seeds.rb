User.delete_all
Account.delete_all
Transaction.delete_all 

user_data = {
  name: "Ransom",
  participant_id: "908997180284469041"
}

new_user = User.new(user_data)
unless new_user.save 
  puts "NAHHHHHHHHH"
end

new_user.create_accounts

# new_user.accounts.each do |account|
#   account.create_transactions
# end 

new_user.accounts.first.create_transactions




# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
