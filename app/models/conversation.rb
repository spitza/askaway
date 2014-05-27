class Conversation < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :destroy
  validates :user_id, presence: true
  validates :prompt, presence: true, length: { maximum: 500 }
end
