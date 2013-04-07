%w(rack active_record camping camping/session camping/reloader).each { |r| require r }

require './clip.rb'
run Clip


dbconfig = YAML.load(File.read('config/database.yml'))
environment = ENV['DATABASE_URL'] ? 'production' : 'development'
Camping::Models::Base.establish_connection dbconfig[environment]

Clip.create if Clip.respond_to? :create

# Log
log = File.new("#{ENV['RACK_ENV']}.log", 'a+')
$stdout.reopen(log)
$stderr.reopen(log)
