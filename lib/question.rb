class Question < ActiveRecord::Base

  belongs_to(:survey)

  has_many :questions_answers
  has_many :answers, :through => :questions_answers
end
