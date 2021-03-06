class CreateMenuElements < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_elements do |t|
      # basic attributes
      t.string :title
      t.string :css

      t.timestamps

      # link attributes
      t.string :url

      # page and album attributes
      t.integer :page_id
      t.integer :album_id

      # divider similar with base attributes

      # STI field

      t.string :type
    end
  end
end
