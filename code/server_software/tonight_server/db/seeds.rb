# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Create some categories

cat_list = [
"House", 
"Acoustic", 
"80's",
"Dance", 
"Techno", 
"Adult", 
"Drum and Bass", 
"Rock", 
"Jazz", 
"Charts"
]
cat_list.each do |name|
  Category.create( cat_name: name);
end

city_list = [
"Birmingham",
"Coventry",
"London", 
"Hull",
"Manchester", 
"Liverpool",
"Cardiff", 
"Bristol",
"Newcastle",
"Southampton", 
"Redding", 
"Bolton"
]
city_list.each do |name|
  City.create( name: name);
end
