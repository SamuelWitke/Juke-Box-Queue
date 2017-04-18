json.extract! song, :id, :track, :album, :artists, :created_at, :updated_at
json.url song_url(song, format: :json)
