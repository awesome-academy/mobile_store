class Comment < ApplicationRecord
    belongs_to :product
    belongs_to :user
    has_many :sub_comments
    scope :sort_by_created, -> { order(created_at: :desc) }
    validates :content, presence: :true

end
