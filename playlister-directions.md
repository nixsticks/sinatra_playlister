The goal of the second part of this lab is to create a command line interface got for the playlister application.  
(The third part of the excercise will be evolving the CLI to be a web interface)
 
Write a ruby script that parses the data within the data directory
and uses the classes defined in partA to instantiate Song, Artist, and Genres
for each file. These instances should be correctly associated to each other
so that artist.genre will return a Genre object, etc.  
 
The data directory is filled with a bunch of songs in this format
Artist Name - Song Name [genre_name].mp3
For example A$AP Rocky - Peso [dance].mp3
This file would give us a new artist instance, a new song instance, and a new genre
and you'd want to define the relationships between the objects (ie add the song to the artist's array of songs)
 
Your CLI should prompt the user with "Browse by artist or genre".  If they type "artist" and hit enter it should take them to the next section which should print out a list of artists, or genres.  The artist index must list all the artists. This list must be sorted alphabetically.
In addition to the Artists name, the artists total song count should be displayed.  This list should also say how many Artists there are in total.  Your CLI should prompt the user with "Select Artist"
When they type in the name of an artist your program should print out a list of 
songs and genres.
For example
 
####Dave Matthews Band - 2 Songs  
#####1. Tripping Billies - Uncool Jam Bands  
#####2. What Would You Say - Bands Blake Liked in 1996  
 
The Genre interface for the CLI should prompt the user with "Select Genre"
The genre index must list all the genres. This list must be sorted by the amount of songs.
In addition to the Genres name, the total song and artist count should be listed along side it.

Folk: 8 Songs, 3 Artists
 
Once the user types a genre and hits enter they should be taken to the individual genre "page"
 
The genres page should list the name of the songs, linking to the individual
\# song and artists. Also include the total unique artists and song counts in the genre.
 
####Folk    
#####1. M83 - Midnight City  
#####2. Lady Gaga - Pokerface  
 
So a user should be able to type M83 and be taken to M83's artist "page" or Midnight City and get taken to the songs "page".  The song page should list all the available information on the song, it's artist and genre.
 
If a user types the artist or genre, they should be taken to the genre or artists "page"/interface
\# Extra Credit:
\# Use a ruby module somewhere to refactor common functionality.

Note: if someone browses by artist, and sees the artist has 4 songs and enters song 4, this is song 4 from the entire list of songs, not just the songs we just displayed for the artist.  This is ok, lets not overcomplicate things.