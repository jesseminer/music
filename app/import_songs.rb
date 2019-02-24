module ImportSongs
  def self.import(tsv_file_path, remote = true)
    contents = remote ? Net::HTTP.get(URI(tsv_file_path)) : File.read(tsv_file_path)
    songs = contents.split("\r").map do |row|
      row.split("\t")
    end

    songs.each do |row|
      artist = nil
      album = nil

      if row[2].present?
        artist = Artist.find_or_create_by!(name: row[2])
        if row[3].present?
          album = Album.find_or_create_by!(title: row[3], artist: artist)
        end
      end

      Song.create!(
        album: album,
        artist: artist,
        duration: parse_duration(row[1]),
        title: row[0]
      )

      print '.'
    end
  end

  def self.parse_duration(duration_str)
    min_sec = duration_str.to_s.split(':')
    return 0 if min_sec.count != 2

    min_sec[0].to_i * 60 + min_sec[1].to_i
  end
end
