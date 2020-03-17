class CreateShows < ActiveRecord::Migration[5.2]
  def change
    create_table :shows do |t|
      t.string :name
      t.datetime :play_time
      t.integer :channel_id

      t.timestamps
    end
  end
end
