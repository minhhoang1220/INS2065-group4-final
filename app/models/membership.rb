class Membership < ApplicationRecord
    has_many :usertable

    validates_presence_of :TypeMem, :price
    validates_uniqueness_of :TypeMem
    validates_numericality_of :price, greater_than_or_equal_to: 0

    def self.search(term)
        if term
          where('group_name LIKE ? OR member_name LIKE ?', "%#{term}%", "%#{term}%")
        else
          all
        end
      end
end
