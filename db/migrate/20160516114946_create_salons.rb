class CreateSalons < ActiveRecord::Migration
  def change
    create_table :salons do |t|
      t.string :name
      t.string :topic
      t.string :detail_location
      t.float :longitude
      t.float :latitude
      t.string :time
      t.string :foreground_color
      t.string :background_color
      t.string :iBeacon
      t.text :detail_info
      t.text :guests
      t.text :help
      t.text :about

      t.references :location, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
