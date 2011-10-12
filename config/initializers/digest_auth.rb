#TODO: Maybe it's better to do in environment section

DIGEST_AUTH = {
  'realm' => 'Admin',
  'admin' => ( [ "test", "development" ].include?(Rails.env) ? "098f6bcd4621d373cade4e832627b4f6" : "7a3b70ca07190e9855b91aed19d68495" )
}