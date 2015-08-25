require('spec_helper')

describe(Survey) do
  describe("#questions") do
    it("returns a list of questions within the survey") do
      test_survey = Survey.create({:name => "Epicodus Survey", :done => false})
      test_question1 = Question.create({:query => "Do you enjoy it here?", :survey_id => test_survey.id })
      test_question2 = Question.create({:query => "What did you learn this week?", :survey_id => test_survey.id })
      expect(test_survey.questions()).to(eq([test_question1, test_question2]))
    end
  end

  describe('.not_done') do
    it('returns whether or not the survey has been completed') do
      test_survey1 = Survey.create({:name => "Epicodus Survey", :done => false})
      test_survey2 = Survey.create({:name => "Epicodus Survey 2", :done => false})
      not_done_surveys = [test_survey1, test_survey2]
      done_survey = Survey.create({:name => "All done", :done => true})
      expect(Survey.not_done()).to(eq(not_done_surveys))
    end
  end
end
