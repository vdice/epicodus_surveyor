ENV['RACK_ENV'] = 'test'

require('rspec')
require('pg')
require('sinatra/activerecord')
require('question')
require('survey')
require('answer')
require('questions_answer')

RSpec.configure do |config|
  config.after(:each) do
    Survey.all().each() do |s|
      s.destroy()
    end

    Question.all().each() do |q|
      q.destroy()
    end

    Answer.all().each() do |a|
      a.destroy()
    end
  end
end
