require_relative './lib/searchable'
require_relative './lib/classmethods'
require_relative './lib/artist'
require_relative './lib/database'
require_relative './lib/genre'
require_relative './lib/song'
require 'open-uri'

require 'bundler'
Bundler.require

module Playlister
  class App < Sinatra::Application
    
    database = Database.new('./public/data')

    before do
      @artists ||= database.artists
      @songs ||= database.songs
      @genres ||= database.genres
    end

    get '/' do
      erb :index
    end

    get '/artists' do
      erb :artists
    end

    get '/genres' do
      erb :genres
    end

    get '/:type/:choice' do |type, choice|
      @choice = search(listize(type), choice)
      if @choice
        @url = get_url("https://gdata.youtube.com/feeds/api/videos?q=#{@choice.artist.name.gsub(/[\s\-]/, "%20")}+#{@choice.name.gsub(" ", "%20")}+music+video").match(/\=(.*)&/)[1] if @choice.is_a?(Song)
        erb symbolize(@choice.class)
      else
        erb :not_found
      end
    end

    post '/search' do
      @choice = partial_search(params["search"])

      if @choice.empty?
        erb :not_found
      else
        erb :search
      end
    end

    not_found do
      erb :not_found
    end

    helpers do
      def get_url(url)
        html = Nokogiri::HTML(open(url.gsub(" ", "%20")))
        html.xpath('//link[contains(@href, "https://www.youtube.com/watch")]').map {|link| link['href']}.first
      end

      def pluralize(list, word)
        list.size > 1 ? word + "s" : word
      end

      def partial_select(list, choice)
        list.select {|element| element.name.downcase.include?(choice.downcase)}
      end

      def search(list, choice)
        list.detect {|element| element.name.downcase == choice.downcase}
      end

      def partial_search(choice)
        partial_select(@artists, choice) + partial_select(@songs, choice) + partial_select(@genres, choice)
      end

      def symbolize(word)
        word.to_s.downcase.to_sym
      end

      def listize(word)
        eval("@#{word.to_s.downcase}s")
      end

      def simple_partial(template)
        erb template
      end
    end
  end
end