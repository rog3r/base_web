class CreateAbilitiesRoles < ActiveRecord::Migration
  def change
    create_table :abilities_roles do |t|
      t.references :ability
      t.references :role
      t.timestamps
    end
     add_index(:abilities_roles, [ :ability_id, :role_id ]) 
  end
end
