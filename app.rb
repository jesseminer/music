require 'sinatra/base'
require 'sinatra/activerecord'
Dir['./app/models/**/*.rb'].each { |file| require file }

class App < Sinatra::Base
  before { content_type :json }

  get '/songs' do
    Song.select(:id, :file_id, :title, 'a.name artist_name, l.title album_title')
      .joins('left join artists a on songs.artist_id = a.id')
      .joins('left join albums l on songs.album_id = l.id')
      .where.not(file_id: nil)
      .map { |s| serialize(s) }
      .to_json
  end

  private

  def serialize(song)
    {
      id: song.id,
      album: song.album_title,
      artist: song.artist_name,
      file_id: song.file_id,
      title: song.title
    }
  end
end
