class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :url
      t.references :image_class, foreign_key: true

      t.timestamps
    end
  end
end
