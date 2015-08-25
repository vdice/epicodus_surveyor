require("sinatra")
require("sinatra/reloader")
require('sinatra/activerecord')
require('pg')
also_reload("lib/**/*.rb")
require('./lib/survey')
require('./lib/question')

get('/') do
  @surveys = Survey.all()
  erb(:index)
end

post('/') do
  name = params.fetch("name")
  new_survey = Survey.create({:name => name, :done => false})

  @surveys = Survey.all()
  erb(:index)
end