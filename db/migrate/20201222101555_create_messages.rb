class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :message_text, null: false
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.timestamps
    end
  end
end
