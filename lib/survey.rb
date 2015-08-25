class Survey < ActiveRecord::Base
  has_many(:questions)

  before_save(:capitalize)

  scope(:not_done, -> do
    where({:done => false})
  end)


private

  define_method(:capitalize) do
    words = self.name().split(" ")
    words.each() do |word|
      word.capitalize!()
    end
    self.name=words.join(" ")
  end
end
