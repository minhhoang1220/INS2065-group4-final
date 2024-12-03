class Usertable < ApplicationRecord
    belongs_to :memberships, optional: true
    has_many :swipes
    has_many :matches
    has_many :sent_messages, class_name: 'Messages'
    has_many :received_messages, class_name: 'Messages'
    has_one_attached :image

    validates_presence_of :name, :email, :password, :active, :age, :gender
    validates_uniqueness_of :email
    validates_numericality_of :age, only_integer: true, greater_than_or_equal_to: 18, less_than_or_equal_to: 100
    validates_inclusion_of :gender, in: %w[male female other]
    validates_length_of :password, minimum: 8
    validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP

end
