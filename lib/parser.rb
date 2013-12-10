require './song'
require './artist'
require './genre'

class Database
  attr_accessor :files

  MATCH = /(?<artist>.*)\s\-\s(?<song>.*)\s\[(?<genre>.*)\]/

  def initialize(directory)
    @files = Dir.entries(directory).select {|f| !File.directory? f}
  end

  def parse
    files.each do |file|
      match = MATCH.match(file)
      artist = exists_or_create(match[:artist], Artist)
      song = exists_or_create(match[:song], Song)
      song.genre = exists_or_create(match[:genre], Genre)
      artist.add_song(song)
    end
  end

  def exists_or_create(match, class_name)
    class_name.search(match) || class_name.new.tap {|object| object.name = match}
  end
end