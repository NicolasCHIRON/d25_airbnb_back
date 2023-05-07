class CreateAccomodations < ActiveRecord::Migration[7.0]
  def change
    create_table :accomodations do |t|
      t.text :title
      t.integer :available_beds
      t.integer :price
      t.text :description
      t.boolean :has_wifi
      t.text :welcome_message
      t.belongs_to :city, index:true
      t.belongs_to :administrator, class_name: "User", index:true

      t.timestamps
    end
  end
end
