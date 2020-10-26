class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.string     :title,  null: false 
      # t.text       :text,   null: false
      t.integer    :status, null: false,  default: 0       #下書き保存を作成するためのもの
      t.references :user,   null: false, foreign_key: true

      t.timestamps
    end
  end
end
