require('spec_helper')

describe(Question) do
  describe('#survey') do
    it('returns the survey that this question belongs to') do
      test_survey = Survey.create({:name => "Epicodus Survey", :done => false})
      test_question = Question.create({:query => "Do you enjoy it here?", :survey_id => test_survey.id })
      expect(test_question.survey()).to(eq(test_survey))
    end
  end
end
