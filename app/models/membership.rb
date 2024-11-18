class Membership < ApplicationRecord
    has_many :usertable

    validates_presence_of :TypeMem, :price
    validates_uniqueness_of :TypeMem
    validates_numericality_of :price, greater_than_or_equal_to: 0

end
