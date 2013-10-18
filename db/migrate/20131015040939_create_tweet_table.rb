class CreateTweetTable < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :name
      t.string :content
      t.string :keyword

      t.timestamps
    end
  end
end
