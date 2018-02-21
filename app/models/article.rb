class Article < ApplicationRecord
    # Relation with articles, one(1) User have many(m) Articles
    belongs_to :user

    validates :title, presence: true, length: {minimum: 5}
    validates :description, presence: true, length: {minimum: 15}
    validates :user_id, presence: true
end
