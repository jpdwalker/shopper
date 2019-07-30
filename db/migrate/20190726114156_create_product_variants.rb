class CreateProductVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :product_variants do |t|
      t.belongs_to :product, null: false
      t.string :title, null: false
      t.decimal :price, null: false, precision: 15, scale: 2

      t.timestamps
    end

    add_foreign_key :product_variants, :products, name: 'fk_product_variants_to_product'
  end
end
