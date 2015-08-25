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
end
