require 'sinatra/base'
require 'sinatra/activerecord'
Dir['./app/models/**/*.rb'].each { |file| require file }

class App < Sinatra::Base
  before do
    content_type :json
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  get '/' do
    '{}'
  end

  get '/songs' do
    Song.select(:id, :file_id, :title, 'a.name artist_name')
      .joins('left join artists a on songs.artist_id = a.id')
      .where.not(file_id: nil)
      .order('artist_name')
      .map { |s| serialize(s) }
      .to_json
  end

  private

  def serialize(song)
    {
      id: song.id,
      artist: song.artist_name,
      file_id: song.file_id,
      title: song.title
    }
  end
end
