require 'csv'
require 'colorize'
require 'pry'

# Represents a person in an address book.
class Contact

  attr_accessor :id, :name, :email, :mobile

  def initialize(name, email, mobile)
    # TODO: Assign parameter values to instance variables.
    @name = name
    @mobile = mobile
    @email = email
  end

  def to_arr
    [id, name, email, number]
  end

  # Provides functionality for managing a list of Contacts in a csv file.
  # The class methods below work with the csv file
  class << self

    # Returns an Array of Contacts loaded from the csv file.
    def all
      csv = CSV.open('contacts.csv', 'r')
      file = csv.to_a
      key, values = file.first, file[1..-1]
      values.map { |v| key.zip v }.map &:to_h    
    end

    # Creates a new contact, adding it to the csv file, returning the new contact.
    def create(name, email, number)
      contact = Contact.new(name, email, number)
      CSV.open("contacts.csv", "a+") do |csv|
        id = all.length
        id += 1
        csv << contact.to_arr
      end
    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      id = id.to_i
      if id == 0 || id > Contact.all.length
        raise "Invalid ID"
      end
      id -= 1
      all[id]
    end

    # Returns an array of contacts who match the given term.
    def search(search_term)
      stuff = []
      if search_term == nil
        return stuff
      else
        all.each do |hash|
          hash.each do |key, value| 
            if value.include? search_term
              stuff << hash          
            end
          end
        end
      end
      stuff
    end

  end
end



