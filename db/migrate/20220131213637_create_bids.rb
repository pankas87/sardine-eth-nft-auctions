class CreateBids < ActiveRecord::Migration[7.0]
  def change
    create_table :bids do |t|
      t.decimal :amount, precision: 2, scale: 12
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
