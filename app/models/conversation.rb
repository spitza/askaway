class Conversation < ActiveRecord::Base
  belongs_to :user
  include FriendlyId
  include ActionView::Helpers::TextHelper
  has_many :questions, dependent: :destroy
  validates :user_id, presence: true
  validates :prompt, presence: true, length: { maximum: 500 }
  friendly_id :convo_url, use: :slugged
  scope :featured, order('questions_count DESC')
  
  def convo_url
    short_prompt = truncate("#{prompt}", length: 25, separator: ' ')
    "#{self.user.name}" + " " + "#{short_prompt}"
  end
  
  def linked_prompt
    "#{Rinku.auto_link(self.prompt, :all, 'target="_blank"')}"
  end
  
end
