class User < ApplicationRecord
    # Relation with articles, one(1) User have many(m) Articles
    has_many :articles

    # before save, email change to lowecasse
    before_save { self.email = email.downcase }

    # validate values
    validates :name, presence: true, length: {minimum: 3, maximum: 150}
    # case_sensitive: false for compare two string, for example: joe, Joe, joE is equal
    validates :username, presence: true, uniqueness: { case_sensitive: false },length: {minimum: 3, maximum: 25}
    # VALID_EMAIL_REGEX, validate type a email
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: { case_sensitive: false },length: { maximum: 105 }, format: { with: VALID_EMAIL_REGEX }

    # Secure password input password of User.password
    has_secure_password
end
