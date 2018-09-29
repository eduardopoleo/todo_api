require 'bundler'
Bundler.require

Sequel.extension :migration, :core_extensions
DB = Sequel.connect('postgresql://localhost/todo_api')


