class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation
  validates :user_id, presence: true
  validates :content, presence: true
  validates :conversation_id, presence: true
  has_one :answer, dependent: :destroy
  has_reputation :votes, source: :user, aggregated_by: :sum
  
  def self.popular
    reorder('votes desc').find_with_reputation(:votes, :all)
  end
  
end
