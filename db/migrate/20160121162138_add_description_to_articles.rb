class AddDescriptionToArticles < ActiveRecord::Migration
  def change
      add_column :articles, :describtion, :text
      add_column :articles, :created_at, :datetime
      add_column :articles, :updated_at, :datetime
  end
end
