class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :abstract
      t.string :byline
      t.string :url
    end
  end
end