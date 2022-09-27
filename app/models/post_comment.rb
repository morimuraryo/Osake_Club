class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :osake
end
