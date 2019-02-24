class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.text :name, null: false
      t.timestamps null: false
    end
  end
end
