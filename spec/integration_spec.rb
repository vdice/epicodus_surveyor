require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application

describe("Surveyr", {:type => :feature}) do

  describe('the survey creator stories') do
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

    it('allows the survey designer to return to the unique survey list from a question page') do
      survey = Survey.create({:name => 'My Survey', :done => false})
      question = Question.create({:query => "Do you enjoy programming?", :survey_id => survey.id})
      visit("/queries/#{question.id()}")
      click_link('Back')
      expect(page).to have_content('My Survey')
    end
  end

  describe("Surveytaker") do
    it("allows a user to view the different surveys and choose among them") do
      survey = Survey.create({:name => 'My Survey', :done => false})
      question = Question.create({:query => "Do you enjoy programming?", :survey_id => survey.id})
      answer = Answer.create({:name => "Yes"})
      question.answers << answer
      visit("/survey_taker")
      click_link(survey.name())
      find('#answer_select').find("#option_#{answer.id()}").select_option
      click_button('Submit')
      expect(page).to have_content('Thank You!')
    end

    it("allows the user to navigate to the surveytaker page from the index") do
      survey = Survey.create({:name => 'My Survey', :done => false})
      question = Question.create({:query => "Do you enjoy programming?", :survey_id => survey.id})
      answer = Answer.create({:name => "Yes"})
      question.answers << answer
      visit('/')
      click_link("Take Survey")
      expect(page).to have_content('Here are your surveys')
    end

    it("allows the user to input his own answer to a query") do
      survey = Survey.create({:name => 'My Survey', :done => false})
      question = Question.create({:query => "Do you enjoy programming?", :survey_id => survey.id})
      visit("/surveys_for_taker/#{survey.id()}")
      fill_in('answer', :with => 'Your answer')
      click_button("Submit")
      expect(page).to have_content('Thank You!')
    end

    it('allows the user to choose which survey to complete') do
      survey = Survey.create({:name => 'My Survey', :done => false})
      question = Question.create({:query => "Do you enjoy programming?", :survey_id => survey.id})
      survey2 = Survey.create({:name => 'My Survey 2', :done => false})
      question2 = Question.create({:query => "Do you enjoy walking?", :survey_id => survey2.id})
      visit('/survey_taker')
      click_link(survey2.name())
      expect(page).to have_content(survey2.name())
    end
  end
end
