require_relative 'database'

class PlayLister

  extend Searchable
  extend ClassMethods 

  class << self
    attr_accessor :current_list
  end

  attr_accessor :database

  def initialize(database)
    @database = database
    @database.parse
  end

  def run
    puts welcome_message
    browse
    puts select_message
    selector
  end

  def self.memoize(list)
    @current_list = list
  end

  private
  def welcome_message
    "Welcome. Browse by artist or genre? (Type exit to exit at any time.)"
  end

  def get_input
    input = gets.chomp.downcase
    input.match(/^e(xit)?$/) ? exit : input
  end

  def browse
    case get_input
    when "artist"
      Artist.index
    when "genre"
      Genre.index
    else
      puts "Sorry, I didn't understand you."
      browse
    end
  end

  def select_message
    "\nType the name or number of any artist, song, or genre shown above to go to its page.\nType artist or genre to browse by artist or genre."
  end

  def selector
    choice = get_input

    if /artist|genre/ =~ choice
      Artist.index if choice == "artist"
      Genre.index if choice == "genre"
      puts select_message
    elsif exists?(choice)
      exists?(choice).page
      puts select_message
    else
      puts "\nThat choice is not included in the list above. Please try again."
    end

    selector
  end

  def exists?(choice)
    (PlayLister.current_list[choice.to_i - 1] if /\d+/ =~ choice) || Artist.search(choice) || Song.search(choice) || Genre.search(choice) # PlayLister.search(choice) 
  end
end

playlist = PlayLister.new(Database.new("../data"))
playlist.run