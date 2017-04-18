class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :track
      t.string :album
      t.string :artists
	  t.string :uri
      t.timestamps
    end
  end
end
