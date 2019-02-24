class CreateSongs < ActiveRecord::Migration[5.2]
  def change
    create_table :songs do |t|
      t.text :title, null: false
      t.text :file_id
      t.integer :duration, null: false
      t.references :artist, index: true, foreign_key: true
      t.references :album, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
