#TODO: Maybe it's better to do in environment section

DIGEST_AUTH = {
  'realm' => 'Admin',
  'admin' => ( Rails.env == "test" ? "f32f69c81da20e4619bb006028ce7fd6" : "902687f8df3ef87775a6116a92170062" )
}