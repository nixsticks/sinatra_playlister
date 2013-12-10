require_relative 'searchable'
require_relative 'classmethods'

class Artist
  extend Searchable
  extend ClassMethods

  attr_accessor :name, :songs

  @artists = []

  class << self
    attr_accessor :artists
  end

  def initialize
    @songs = []
    Artist::artists << self
  end

  def add_song(song)
    songs << song
    song.genre.artists << self if song.genre && song.genre.artists.include?(self) == false
    song.artist = self
  end

  def genres
    songs.map {|song| song.genre}
  end

  def songs_count
    songs.size
  end

  def page
    puts "\n#{name} - #{songs.size} Songs"
    songs.each_with_index {|song, i| puts "#{i+1}. #{song.name} (#{song.genre.name})"}
    PlayLister.memoize(songs)
  end

  def self.index
    puts
    artists.each_with_index do |artist, i|
      puts "#{i + 1}. #{artist.name} - #{artist.songs.size} Songs"
    end
    puts "\nTotal: #{artists.size} Artists"
    PlayLister.memoize(artists)
  end
end