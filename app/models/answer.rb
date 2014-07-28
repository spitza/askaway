class Answer < ActiveRecord::Base
  validates :content, presence: true, length: { maximum: 500 }
  validates :question_id, presence: true
  belongs_to :question
  
  def linked_content
    "#{Rinku.auto_link(self.content, :all, 'target="_blank"')}"
  end
  
end