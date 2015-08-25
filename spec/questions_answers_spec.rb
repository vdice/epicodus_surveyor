require('spec_helper')

describe(QuestionsAnswer) do
  describe('#answers') do
    it('returns the possible answers for a question') do
      test_survey = Survey.create({:name => "Epicodus Survey", :done => false})
      test_question = Question.create({:query => "Do you enjoy it here?", :survey_id => test_survey.id })
      answer1 = Answer.create({:name => 'Yes'})
      answer2 = Answer.create({:name => 'No'})
      test_question.answers << answer1
      test_question.answers << answer2
      expect(test_question.answers()).to(eq([answer1, answer2]))
    end
  end
end
