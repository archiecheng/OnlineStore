admin = User.find_or_create_by!(name: "admin") do |u|
  u.email = "admin@example.com"
  u.password = "password"
  u.admin = true
end

products = [
  { name: "Practical Object-Oriented Design", price: 45.0, stock: 10, image: "https://images-na.ssl-images-amazon.com/images/I/41-DhH4Z1BL._SX380_BO1,204,203,200_.jpg", description: "A Ruby classic by Sandi Metz." },
  { name: "Eloquent Ruby", price: 40.0, stock: 12, image: "https://images-na.ssl-images-amazon.com/images/I/51QV5skU3CL._SX379_BO1,204,203,200_.jpg", description: "Idiomatic Ruby techniques and patterns." },
  { name: "Designing Data-Intensive Applications", price: 60.0, stock: 8, image: "https://images-na.ssl-images-amazon.com/images/I/51FHuMWSBRL._SX379_BO1,204,203,200_.jpg", description: "Martin Kleppmann on building reliable, scalable systems." }
]

products.each do |attrs|
  Product.find_or_create_by!(name: attrs[:name]) do |p|
    p.assign_attributes(attrs)
  end
end

puts "Seeded: #{User.count} users, #{Product.count} products"
