class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.string :location
      t.time :time
      t.date :date

      t.timestamps
    end
  end
end
