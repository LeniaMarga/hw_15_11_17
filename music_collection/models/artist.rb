require('pg')
require_relative('../db/sql_runner.rb')
require_relative('album.rb')

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize (info)
    @name = info['name']
    @id = info['id'].to_i if info['id']
  end

  def save
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING *"
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.delete
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map {|artist_hash| Artist.new(artist_hash)}
  end

  def album
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    album = SqlRunner.run(sql, values)
    return album.map { |album_hash| Album.new(album_hash)}
  end

  # def delete()
  #
  # end


end
