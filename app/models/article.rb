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

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
