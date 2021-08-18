class CreateGifts < ActiveRecord::Migration[6.1]
  def change
    create_table :gifts do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :amount
      t.string :status
      t.text :security_key
      t.references :answer, null: false, foreign_key:

      t.timestamps
    end
  end
end
