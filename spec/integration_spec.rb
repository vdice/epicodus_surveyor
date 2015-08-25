require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application

describe("Surveyr", {:type => :feature}) do

 describe('the survey creation path') do
   it("allows the survey designer to create a survey") do
     visit('/')
     fill_in("name", :with => 'epicodus Survey')
     click_button('Submit')
     expect(page).to have_content('Epicodus Survey')
   end
  end

  it("allows the survey designer to create a question") do
    survey = Survey.create({:name => 'My Survey', :done => false})
    visit('/')
    click_link(survey.name())
    fill_in("query", :with => 'Do you enjoy programming?')
    click_button('Create')
    expect(page).to have_content('Do you enjoy programming?')
  end

  it("allows the survey designer to update a survey with a new name") do
    survey = Survey.create({:name => 'My Survey', :done => false})
    visit("/surveys/#{survey.id()}")
    fill_in("name", :with => 'New Survey Name')
    click_button('UPDATE')
    expect(page).to have_content('New Survey Name')
  end

  it("allows the survey designer to delete a survey from the database") do
    survey = Survey.create({:name => 'My Survey', :done => false})
    visit("/surveys/#{survey.id()}")
    click_button("DELETE")
    expect(page).to have_content("Surveyr")
    expect(page).to_not have_content('My Survey')
  end

  it("allows the survey designer to remove questions from a survey") do
   survey = Survey.create({:name => 'My Survey', :done => false})
   question = Question.create({:query => "Do you enjoy programming?", :survey_id => survey.id})
   visit("/surveys/#{survey.id()}")
   click_link(question.query())
   click_button("Delete Query")
   expect(page).to have_content("My Survey")
   expect(page).to_not have_content("Do you enjoy programming?" )
  end

  it("allows the survey designer to add possible answers to a question") do
    survey = Survey.create({:name => 'My Survey', :done => false})
    question = Question.create({:query => "Do you enjoy programming?", :survey_id => survey.id})
    visit("/queries/#{question.id()}")
    fill_in("answer", :with => 'yes')
    click_button("Add Answer")
    fill_in("answer", :with => 'no')
    click_button("Add Answer")
    expect(page).to have_content("Yes")
    expect(page).to have_content("No")
  end

end
