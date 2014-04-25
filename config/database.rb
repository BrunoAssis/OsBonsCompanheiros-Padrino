##
# You can use other adapters like:
#
#   ActiveRecord::Base.configurations[:development] = {
#     :adapter   => 'mysql2',
#     :encoding  => 'utf8',
#     :reconnect => true,
#     :database  => 'your_database',
#     :pool      => 5,
#     :username  => 'root',
#     :password  => '',
#     :host      => 'localhost',
#     :socket    => '/tmp/mysql.sock'
#   }
#
ActiveRecord::Base.configurations[:development] = {
  :adapter   => 'postgresql',
  :database  => 'osbonscompanheiros_com_development',
  :username  => 'root',
  :password  => '',
  :host      => 'localhost',
  :port      => 5432

}

ActiveRecord::Base.configurations[:production] = {
  :adapter   => 'postgresql',
  :database  => 'd1ba9td45oa6dp',
  :username  => 'ktmlkrfyktytni',
  :password  => 'qCGpPKaVyoGoW6p7m4qq163lIF',
  :host      => 'ec2-23-21-243-117.compute-1.amazonaws.com',
  :port      => 5432
}

ActiveRecord::Base.configurations[:test] = {
  :adapter   => 'postgresql',
  :database  => 'osbonscompanheiros_com_test',
  :username  => 'root',
  :password  => '',
  :host      => 'localhost',
  :port      => 5432

}

# Setup our logger
ActiveRecord::Base.logger = logger

if ActiveRecord::VERSION::MAJOR.to_i < 4
  # Raise exception on mass assignment protection for Active Record models.
  ActiveRecord::Base.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL).
  ActiveRecord::Base.auto_explain_threshold_in_seconds = 0.5
end

# Doesn't include Active Record class name as root for JSON serialized output.
ActiveRecord::Base.include_root_in_json = false

# Store the full class name (including module namespace) in STI type column.
ActiveRecord::Base.store_full_sti_class = true

# Use ISO 8601 format for JSON serialized times and dates.
ActiveSupport.use_standard_json_time_format = true

# Don't escape HTML entities in JSON, leave that for the #json_escape helper
# if you're including raw JSON in an HTML page.
ActiveSupport.escape_html_entities_in_json = false

# Now we can establish connection with our db.
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[Padrino.env])

# Timestamps are in the utc by default.
ActiveRecord::Base.default_timezone = :utc
