class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :path
      t.string :orig_url
      t.text :source

      t.timestamps
    end
  end
end
