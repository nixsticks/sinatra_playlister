class Database
  include Searchable

  attr_accessor :files, :artists, :songs, :genres

  MATCH = /(?<artist>.*)\s\-\s(?<song>.*)\s\[(?<genre>.*)\]/

  def initialize(directory)
    @files = Dir.entries(directory).select {|f| !File.directory? f}
    @artists = Array.new
    @songs = Array.new
    @genres = Array.new
    parse
  end

  def parse
    files.each do |file|
      match = MATCH.match(file)
      artist = exists_or_create(match[:artist], Artist)
      song = exists_or_create(match[:song], Song)
      song.genre = exists_or_create(match[:genre], Genre)
      artist.add_song(song)

      artists << artist
      songs << song
      genres << song.genre
    end

    artists.uniq!
    songs.uniq!
    genres.uniq!
  end

  def exists_or_create(match, class_name)
    array = class_name.to_s.downcase + "s"
    eval(array).detect {|element| element.name.downcase == match.downcase} || class_name.new.tap {|object| object.name = match}
  end
end