class CreateAbilities < ActiveRecord::Migration
  def change
    create_table :abilities do |t|
      t.string :domain
      t.string :ability

      t.timestamps
    end
    add_index(:abilities, [ :domain, :ability ])
  end
end
