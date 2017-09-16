class CreateAddress < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :emailtype
      t.string :event
      t.string :timestamp
      t.string :date
      t.string :time
    end
  end
end
