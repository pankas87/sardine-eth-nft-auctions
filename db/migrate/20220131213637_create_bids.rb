class CreateBids < ActiveRecord::Migration[7.0]
  def change
    create_table :bids do |t|
      t.decimal :amount, precision: 4, scale: 16
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
