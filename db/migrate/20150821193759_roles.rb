class Roles < ActiveRecord::Migration
  def change
    create_table(:roles) do |t|
      t.string :name, uniq: true , index: true

      t.timestamps
    end
  end
end
