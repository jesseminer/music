require 'sinatra/base'
require 'pg'
require './db_connection'

class App < Sinatra::Base
  SONGS_SQL = <<-SQL
    select s.id, s.file_id, s.title, a.name artist
    from songs s
    left join artists a on a.id = s.artist_id
    where s.file_id is not null
    order by artist
  SQL

  before do
    content_type :json
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  get '/' do
    '{}'
  end

  get '/songs' do
    db_query(SONGS_SQL).to_a.to_json
  end

  private

  def db_query(q)
    DB_CONNECTION.exec(q)
  end
end
