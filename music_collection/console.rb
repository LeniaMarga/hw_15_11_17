require('pry-byebug')
require('pp')
require_relative('models/album.rb')
require_relative('models/artist.rb')

 Album.delete
 Artist.delete

artist_1 = Artist.new({'name' => 'Pink Floyd'})

artist_1.save()

album_1 = Album.new(
  { 'title' => 'Dark Side of the Moon',
    'genre' => 'Rock',
    'artist_id' => artist_1.id
  }
)

album_2 = Album.new(
  { 'title' => 'The Wall',
    'genre' => 'Rock',
    'artist_id' => artist_1.id
  }
)


album_1.save()
album_2.save()
artists = Artist.all()

album_2.artist
artist_1.album

binding.pry
nil
