class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :place
      t.string :price
      t.string :detail
      t.string :image
      t.integer :kind
      t.integer :genre
      t.integer :prefecture
      t.datetime :start_time
      t.time :finish_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
