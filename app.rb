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

get('/surveys/:id') do
  survey_id = params.fetch('id').to_i()
  @survey = Survey.find(survey_id)
  erb(:survey)
end

post('/surveys/:id') do
  survey_id = params.fetch('id').to_i()
  query = params.fetch('query')
  new_question = Question.create({:query => query, :survey_id => survey_id})

  @survey = Survey.find(survey_id)
  erb(:survey)
end
