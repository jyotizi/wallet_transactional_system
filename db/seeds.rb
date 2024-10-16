# Create Users
user1 = User.create(email: 'johndoe@example.com',password: "john@123")
user1.create_wallet(balance: 1000.00)

user2 = User.create(email: 'janesmith@example.com', password: "jane@123")
user2.create_wallet(balance: 1500.00)

# Create Teams
team1 = Team.create(name: 'Development Team')
team1.create_wallet(balance: 5000.00)

team2 = Team.create(name: 'Marketing Team')
team2.create_wallet(balance: 3000.00)

# Create Stocks
stock1 = Stock.create(name: 'Acme Corp')
stock1.create_wallet(balance: 2000.00)

stock2 = Stock.create(name: 'Tech Innovations')
stock2.create_wallet(balance: 3500.00)

puts "Seed data created successfully!"
