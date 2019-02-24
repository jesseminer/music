class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.text :title, null: false
      t.references :artist, null: false, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
