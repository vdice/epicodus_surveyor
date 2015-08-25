class Answer < ActiveRecord::Base
  has_many :questions_answers
  has_many :questions, :through => :questions_answers

  before_save(:capitalize)

private

  define_method(:capitalize) do
    self.name().capitalize!()
  end
end
