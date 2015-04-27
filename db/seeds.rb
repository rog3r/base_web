Ability.create!([
  { id: 1,  domain: 'admin', ability: 'admin' },
  { id: 2,  domain: 'user',  ability: 'index' },
  { id: 3,  domain: 'user',  ability: 'show' },
  { id: 4,  domain: 'user',  ability: 'create' },
  { id: 5,  domain: 'user',  ability: 'update' },
  { id: 6,  domain: 'user',  ability: 'destroy' },
  { id: 7,  domain: 'role',  ability: 'index' },
  { id: 8,  domain: 'role',  ability: 'show' },
  { id: 9,  domain: 'role',  ability: 'create' },
  { id: 10, domain: 'role',  ability: 'update' },
  { id: 11, domain: 'role',  ability: 'destroy' }
])

Role.create!([
  { id: 1, name: 'Administrator' },
  { id: 2, name: 'User' },
  { id: 3, name: 'View' } 
])

AbilityRole.create!([
  { role_id: 1, ability_id: 1 }, 
  { role_id: 2, ability_id: 2 },
  { role_id: 2, ability_id: 3 },
  { role_id: 2, ability_id: 4 },
  { role_id: 2, ability_id: 5 },
  { role_id: 2, ability_id: 6 }, 
  { role_id: 3, ability_id: 7 },
  { role_id: 3, ability_id: 8 },
  { role_id: 3, ability_id: 9 },
  { role_id: 3, ability_id: 10 },
  { role_id: 3, ability_id: 11 } 
])

User.create!([ 
  { name: 'admin'    ,  email: 'admin@example.com', password: 'adminadmin' },
  { name: 'user_role',   email: 'user@example.com' , password: 'useruser' },
  { name: 'role_role',   email: 'role@example.com' , password: 'rolerole' },
  { name: 'view_role',   email: 'view@example.com' , password: 'viewview' }
])

