class Response < ActiveRecord::Base
  validates :content, presence: true, length: { maximum: 500 }
  validates :query_id, presence: true
  belongs_to :query
  belongs_to :user
  
  def linked_content
    "#{Rinku.auto_link(self.content, :all, 'target="_blank"')}"
  end
  
end