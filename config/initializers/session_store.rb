# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ror_session',
  :secret      => '0be28c04bba039b9bb674b33e1143a84cc263e5e3211987739699b767c74272109c64e3a2aba652f7754b8e44ef44f1785476bded96d1d8f405a8be2e17372fa'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
