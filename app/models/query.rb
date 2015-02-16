class Query < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  include FriendlyId
  belongs_to :akser, :class_name => 'User'
  belongs_to :askee, :class_name => 'User'
  has_reputation :votes, source: :user, aggregated_by: :sum, dependent: :destroy
  has_one :response, dependent: :destroy
  validates :content, presence: true, length: { maximum: 500 }
  friendly_id :query_url, use: :slugged
  scope :responded_to, -> { where(has_response: 't') }
  
  def linked_content
    "#{Rinku.auto_link(self.content, :all, 'target="_blank"')}"
  end
  
  def askerfunction
    @id = self.asker_id
    User.find(@id)
  end
  
  def self.popular
    reorder('votes desc').find_with_reputation(:votes, :all)
  end
  
  def query_url
    short_q = truncate("#{content}", length: 20, separator: ' ')
    "#{self.askerfunction.name}" + " asked " + "#{self.askee.name}" + " #{short_q}"
  end
  
end
