class AddPermissionsToRoles < ActiveRecord::Migration
  def up
    create_table :permissions_roles do |t|
      t.references :permission
      t.references :role
    end
    add_index(:permissions_roles, [ :permission_id, :role_id ])
  end

  def down
    drop_table :permissions_roles
  end
end
