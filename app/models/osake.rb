class Osake < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @osake = Osake.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @osake = Osake.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @osake = Osake.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @osake = Osake.where("title LIKE?","%#{word}%")
    else
      @osake = Osake.all
    end
  end
end
