Amazon::Ecs.options = {
  :associate_tag => ENV[ASSOCIATE_TAG],
  :AWS_access_key_id => ENV[AWS_ACCESS_KEY_ID],
  :AWS_secret_key => ENV[AWS_SECRET_KEY]
}
