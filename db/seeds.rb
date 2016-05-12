p "Create two users, one with admin right, the other not..."
u1 = User.new(email: "a@a.com", password: "12341234", password_confirmation: "12341234", is_admin: true)
u2 = User.new(email: "b@b.com", password: "12341234", password_confirmation: "12341234", is_admin: false)
u1.save!
u2.save!
p "Users created!"

p "Add three products..."
p1 = Product.new(title: "SONY 70\" Flast-screen TV", description: "This is a SONY 60\" Flat-screen TV, boasting its super color definitions.", quantity: 100, price: 45000)
p2 = Product.new(title: "Unseen City: The Majesty of Pigeons, the Discreet Charm of Snails & Other Wonders of the Urban Wilderness", description: "It all started with Nathanael Johnson's decision to teach his daughter, Josephine, the names of every tree they passed as they walked up the hill to daycare in San Francisco, CA. It was a ridiculous project, not just because she couldn't even say the word \"tree\" yet, but also because he couldn't name a single one of them. When confronted with the futility of his mission, his instinctive response was to expand it, Don Quixote-style, until its audacity obscured its stupidity. And so the project expanded to include an expertise in city-dwelling birds (the raptors, the shockingly shrewd crows, the gulls, the misunderstood pigeons), rodents (raccoons, rats, squirrels), and tiny crawling things (the superpowers of snails, the vast intercontinental warfare of ants). ", quantity: 100, price: 300)
p3 = Product.new(title: "Echo Dot", description: "Uses the Alexa Voice Service to play music, provide information, read the news, set alarms, control smart home devices, and more using just your voice", quantity: 500, price: 5600)
p1.save!
p2.save!
p3.save!
p "Three products created!"
