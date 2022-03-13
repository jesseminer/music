DB_CONNECTION = Sinatra::Application.development? ?
  PG.connect(dbname: 'music_dev') :
  PG.connect(ENV.fetch('DATABASE_URL'))

DB_CONNECTION.type_map_for_results = PG::BasicTypeMapForResults.new(DB_CONNECTION)
