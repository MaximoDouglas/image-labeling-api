class CreateImageClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :image_classes do |t|
      t.string :name
      t.references :domain, foreign_key: true

      t.timestamps
    end
  end
end
