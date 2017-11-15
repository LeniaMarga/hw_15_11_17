require('pg')
require_relative('../db/sql_runner.rb')
require_relative('artist.rb')

class Album

  attr_reader :id
  attr_accessor :title, :genre, :artist_id

  def initialize (info)
    @title = info['title']
    @genre = info['genre']
    @id = info['id'].to_i if info['id']
    @artist_id = info['artist_id'].to_i
  end

  def save
    sql = "INSERT INTO albums (title, genre) VALUES ($1, $2) RETURNING *"
    values = [@title, @genre]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.delete
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map {|album_hash| Album.new(album_hash)}
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    artist = SqlRunner.run(sql, values)
    return artist.map { |artist_hash| Artist.new(artist_hash)}
  end


end
