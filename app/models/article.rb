class Article < ApplicationRecord
  has_one_attached :image

  belongs_to :user, optional: true

  has_many :article_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length:{maximum:3000}

  def self.looks(search,word)
    if search == "perfect_match"
      @article = Article.where("title LIKE?", "#{word}")
    elsif search == "forward_match"
      @article = Article.where("title LIKE?", "#{word}%")
    elsif search == "backword_match"
      @article = Article.where("title LIKE?", "%#{word}")
    elsif search == "partial_match"
      @article = Article.where("title LIKE?", "%#{word}%")
    else
      @article = Article.all
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
