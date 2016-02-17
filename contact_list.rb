require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList
  LINE = "-".yellow * 30

  # -----------------------
  # Make new contact
  # -----------------------
  
  def new_contact
    puts "Enter name: "
    name = STDIN.gets.chomp.capitalize
    
    puts "Enter email: "
    email = STDIN.gets.chomp.downcase
    
    puts "Enter mobile: "
    mobile = STDIN.gets.chomp
    Contact.create(name, email, mobile)
  end

  # -----------------------
  # List all contacts
  # -----------------------
  
  def list_all
    system "clear"
    Contact.all.each do |hash| 
      hash.each do |key, value|
        puts "#{key.white.on_blue.bold}: #{value}"
        puts LINE
      end
      puts " ".on_yellow * 30 
      puts LINE
    end 
  end

  # -----------------------
  # Show a single contact
  # -----------------------
  
  def search_id(id)
    system "clear"
    id = id.to_i
    begin
      Contact.find(id).each do |key, value|
        puts "#{key.white.on_blue.bold}: #{value}"
        puts LINE
      end
    rescue
      puts "There is an Error."
    end
  end

  # -----------------------
  # Seach through contacts
  # -----------------------
  
  def search(search_term)
    system "clear"
    if Contact.search(search_term) == []
      puts LINE
      return puts "Search not found.\n".red + LINE
    else
      Contact.search(search_term).each do |hash|
        hash.each do |key, value|
          puts "#{key.white.on_blue.bold}: #{value}"
          puts LINE
        end
      end
    end
  end

end #end of Class

case ARGV[0].downcase
  when  "new_contact"
    contact_list = ContactList.new
    contact_list.new_contact
  when  "list_all"
    contact_list = ContactList.new
    contact_list.list_all
  when  "find"
    contact_list = ContactList.new
    contact_list.search_id(ARGV[1])
  when  "search"
    contact_list = ContactList.new
    contact_list.search(ARGV[1])
end


