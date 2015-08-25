ENV['RACK_ENV'] = 'test'

require('rspec')
require('pg')
require('sinatra/activerecord')
require('question')
require('survey')

RSpec.configure do |config|
  config.after(:each) do
    Survey.all().each() do |s|
      s.destroy()
    end

    Question.all().each() do |q|
      q.destroy()
    end
  end
end
