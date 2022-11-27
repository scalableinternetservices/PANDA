class Tag < ApplicationRecord
    paginates_per 5
    has_many :posts
end
