class Question < ActiveRecord::Base
  include FriendlyId
  include ActionView::Helpers::TextHelper
  belongs_to :user
  belongs_to :conversation, counter_cache: true
  has_one :answer, dependent: :destroy
  has_reputation :votes, source: :user, aggregated_by: :sum, dependent: :destroy
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 500 }
  validates :conversation_id, presence: true
  friendly_id :question_url, use: :slugged
  
  def self.popular
    reorder('votes desc').find_with_reputation(:votes, :all)
  end
  
  def question_url
    short_q = truncate("#{content}", length: 20, separator: ' ')
    "q for " + "#{self.conversation.user.name}" + " by " "#{self.user.name}" + " #{short_q}"
  end
  
  def linked_content
    "#{Rinku.auto_link(self.content, :all, 'target="_blank"')}"
  end
  
end
