# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: 'admin@admin.com',
  password: 'aaaaaa',
  )

Item.create!(
  name: '商品名',
  introduction: '商品説明',
  price: '2000',
  sales_status: '0',
  genre_id: '1',
  )