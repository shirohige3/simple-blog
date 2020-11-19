class CreateBlogTags < ActiveRecord::Migration[6.0]
  def change
    create_table :blog_tags do |t|
      t.references :blog, null: false, foreign_key: true
      t.references :tag,  null: false, foreign_key: true
      t.timestamps
    end
  end
end
