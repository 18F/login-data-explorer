# Login.gov Data Explorer

A Rails app that uses the [blazer](https://github.com/ankane/blazer) gem to make
it easy to create queries and dashboards.

## Installation

You'll need Ruby 2.5.x on your machine. If you don't already have it, try
running the [laptop](https://github.com/18F/laptop) script.

Note that it is not currently possible to test the app with any of our deployed
databases. The easiest way to test and create queries is to run the
[identity-idp](https://github.com/18F/identity-idp) repo locally, then update
`config/blazer.yml` in this repo to point to the local DB, like this:

```yaml
data_sources:
  login-dot-gov-db:
    url: postgres:///upaya_development
```

To simulate 1000 users in the DB, you can run this script from the root of the
`identity-idp` repo:
```console
rake dev:random_users NUM_USERS=1000
```
Users will have an email address `testuser1@example.com` up to
`testuser1000@example.com`.

To generate random events for all of these users, run this from the Rails
console of the `identity-idp` repo:
```ruby
User.find_each do |user|
  event_names = Event.event_types.keys
  Event.create(event_type: event_names.sample, user_id: user.id)
end
```

To set up this repo:

```console
bin/setup
```

## Credentials and email fingerprints
Note that this is a Rails 5.2 app that uses the new
[credentials](https://guides.rubyonrails.org/security.html#custom-credentials).

To be able to convert an email address to an `email_fingerprint`, the app needs
access to the `hmac_fingerprinter_key`. To make it easy to test locally, it is
set by default to the same value as the one in the `development` section of
`identity-idp`'s `application.yml` . Before the app is deployed, we'll need to
run `rails credentials:edit`, then update `hmac_fingerprinter_key` to the same
value as the one in the target `identity-idp` server. You can only decrypt the
credentials if you have the correct `config/master.key`, which is `.gitignored`.

Rotation of `master.key` is done as follows:
1. View the contents of the credentials file:
```console
rails credentials:show
```
2. Copy the contents

3. Move both `config/credentials.yml.enc` and `config/master.key` away from the
repo

4. Generate a new credentials file:
```console
rails credentials:edit
```
This will also automatically create a new `master.key`

5. Paste the contents into the new file and save it.

## Running the app
```console
foreman start -p 8080
```

To access the page where you can look up a user by their email address, visit:
http://localhost:8080/email_fingerprint/

To see the list of all saved queries and dashboards, visit:
http://localhost:8080/blazer/

You should see a few queries already created, such as `User Counts` and
`Events for specific user`.

## Running the tests

The test suite uses rspec.

The app needs a dummy IDP database in addition to a test application database.
To setup the databases, run the following rake task:

```
rake db:test:prepare && rake idp:db:test:prepare
```

One the test database is setup run the tests with the following:

```
bundle exec rspec
```

## Sharing queries with the team
If you add queries to the app and want other folks to see them when they run
the app locally, you can use the `bin/export` script, which will save the
Postgres DB to `data/login_data_explorer_development.dump`. This file will need
to be checked in to the repo, and once merged, the other team members can then
run `bin/import` to get the latest changes.
