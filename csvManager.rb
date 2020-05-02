require 'csv'
require 'faker'
require 'pry'
​
module CSVManager
​
    class CSVPopulator 
​
        def initialize(path=nil)
            @path = path ? path : __dir__ + "/data.csv"
            if !File.exist?(@path)
                file = File.open(@path, 'w')
                file.close
            end
        end
​
        def write(two_d_arr)
            CSV.open(@path, "wb") do |csv|
                two_d_arr.each do |arr|
                    csv << arr
                end
            end
        end
​
    end
​
​
end
​
class Person
​
    @@all = []
​
    def self.all
        @@all
    end
​
    attr_accessor :name, :email, :address, :alias, :superpower, :actionverb, :gender
​
​
    def initialize(name, email, address, superalias, superpower, actionverb, gender)
        @name, @email, @address, @alias, @superpower, @actionverb, @gender = name, email, address, superalias, superpower, actionverb, gender
        @@all << self
    end
end
​
​
​
writer = CSVManager::CSVPopulator.new
​
people = []
100.times do 
    people << [Faker::Name.name, Faker::Internet.email, Faker::Address.full_address, Faker::Superhero.name, Faker::Superhero.power,Faker::Hacker.verb,Faker::Gender.binary_type]
end
​
writer.write(people)
​
​
two_d_arr = CSV.read("data.csv") 
two_d_arr.each do |arr|
    Person.new(*arr)
end
​
binding.pry
