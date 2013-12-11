require_relative './lib/searchable'
require_relative './lib/classmethods'
require_relative './lib/artist'
require_relative './lib/database'
require_relative './lib/genre'
require_relative './lib/song'

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

    get '/:choice' do |choice|
      @choice = search(choice)
      erb symbolize(@choice.class)
    end

    helpers do
      def search(choice)
        @artists.detect {|element| element.name == choice} || @songs.detect {|element| element.name == choice} || @genres.detect {|element| element.name == choice}
      end

      def symbolize(word)
        word.to_s.downcase.to_sym
      end
    end

    helpers do

        def simple_partial(template)
          erb template
        end
    
        def intermediate_partial(template, locals=nil)
          locals = locals.is_a?(Hash) ? locals : {template.to_sym => locals}
          template = :"_#{template}"
          erb template, {}, locals        
        end
   
        def adv_partial(template,locals=nil)
          if template.is_a?(String) || template.is_a?(Symbol)
            template = :"_#{template}"
          else
            locals=template
            template = template.is_a?(Array) ? :"_#{template.first.class.to_s.downcase}" : :"_#{template.class.to_s.downcase}"
          end
          if locals.is_a?(Hash)
            erb template, {}, locals      
          elsif locals
            locals=[locals] unless locals.respond_to?(:inject)
            locals.inject([]) do |output,element|
              output << erb(template,{},{template.to_s.delete("_").to_sym => element})
            end.join("\n")
          else 
            erb template
          end
        end
      end
  end
end