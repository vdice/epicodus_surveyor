require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application

describe("Surveyr", {:type => :feature}) do

 describe('the survey creation path') do
   it("allows the user to create a survey") do
     visit('/')
     fill_in("name", :with => 'epicodus Survey')
     click_button('Submit')
     expect(page).to have_content('Epicodus Survey')
   end
  end

  it("allows the user to create a question") do
    survey = Survey.create({:name => 'My Survey', :done => false})
    visit('/')
    click_link(survey.name())
    fill_in("query", :with => 'Do you enjoy programming?')
    click_button('Create')
    expect(page).to have_content('Do you enjoy programming?')
  end
end
