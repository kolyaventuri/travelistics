# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

def parse_csv(filename)
  CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
    yield row.to_h
  end
end

parse_csv('./db/seeds/languages.csv') do |data|
  Language.create(name: data[:english], code: data[:alpha2])
end

parse_csv('./db/seeds/countries.csv') do |data|
  languages = data[:languages].delete(' ').split(',')

  currency = Currency.create(code: data[:currency])
  country = Country.new(
    name: data[:country_name],
    code: data[:country_code],
    side_of_road: data[:what_side_of_road],
    currency: currency
  )

  languages.map do |lang|
    language = Language.find_by(code: lang)
    country.languages.push(language) if language
  end

  country.save
end
