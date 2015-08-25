class Survey < ActiveRecord::Base
  has_many(:questions)
  scope(:not_done, -> do
  where({:done => false})
end)
end
