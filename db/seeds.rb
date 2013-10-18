# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name(role)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.confirm!
user.add_role :admin


p = Page.create!({key: 'home', title: 'Renuo CMS Demo - Startseite'})
c = ContentRichText.create!({name: 'Inhalt Startseite', content: '<p><h2>Willkommen bei der CMS Demo</h2></p>'.html_safe})
p.content_types << c

ContentRichText.create!({key: 'copyright', name: 'Copyright Fusszeile', content: '<p>Copyright &copy; <a href="https://www.renuo.ch">Renuo GmbH</a> - <a href="https://www.renuo.ch/ueber-uns">Über uns</a> | <a href="https://www.renuo.ch/kontakt">Kontakt</a></p>'.html_safe})
