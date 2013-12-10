require_relative 'searchable'
require_relative 'classmethods'

class Genre
  extend Searchable
  extend ClassMethods

  attr_accessor :name, :songs, :artists

  class << self
    attr_accessor :genres
  end

  @genres = []

  def initialize
    @songs = []
    @artists = []
    Genre::genres << self
  end
  
  def page
    puts "\n#{name.capitalize}: #{artists.size} Artists, #{songs.size} Songs\n\n"
    artists.each_with_index do |artist, i|
      print "#{i+1}. #{artist.name}: "
      artist.songs.each {|song| puts "#{song.name}" if song.genre == self}
    end
    PlayLister.memoize(artists)
  end

  def self.index
    puts
    sorted_genres = genres.reverse.sort_by {|genre| genre.songs.size}
    sorted_genres.each_with_index do |genre, i|
      puts "#{i + 1}. #{genre.name.capitalize}: #{genre.songs.size} Songs, #{genre.artists.size} Artists"
    end
    PlayLister.memoize(sorted_genres)
  end
end