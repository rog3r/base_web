
admin_admin  = Ability.create!( domain: 'admin', ability: 'admin' )

user_index   = Ability.create!( domain: 'user',  ability: 'index' )
user_show    = Ability.create!( domain: 'user',  ability: 'show' )
user_create  = Ability.create!( domain: 'user',  ability: 'create' )
user_update  = Ability.create!( domain: 'user',  ability: 'update' )
user_destroy = Ability.create!( domain: 'user',  ability: 'destroy' )

role_index   = Ability.create!( domain: 'role',  ability: 'index' )
role_show    = Ability.create!( domain: 'role',  ability: 'show' )
role_create   = Ability.create!( domain: 'role',  ability: 'create' )
role_update  = Ability.create!( domain: 'role',  ability: 'update' )
role_destroy   = Ability.create!( domain: 'role',  ability: 'destroy' )


admin_role = Role.create!( name: 'administrator')
admin_role << admin_admin

user_role  = Role.create!( name: 'user')
user_role << [user_index, user_show, user_create, user_update, user_destroy]

support_role  = Role.create!( name: 'supporte')
support_role << [user_index, user_show, user_create, user_update, user_destroy, role_index, role_show, role_create, role_update, role_destroy]

guest_role = Role.create!( name: 'guest')
# no Roles



User.create!([ 
  { name: 'admin'       , email: 'admin@example.com',   password: 'abc123456' , roles: [admin_role ]},
  { name: 'user_role'   , email: 'user@example.com',    password: 'abc123456' , roles: [ user_role, guest_role ] },
  { name: 'support_role', email: 'support@example.com', password: 'abc123456' , roles: [ support_role ] },
  { name: 'guest_role'  , email: 'view@example.com' ,   password: 'abc123456' , roles: [ guest_role ] }
])

