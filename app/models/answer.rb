class Answer < ActiveRecord::Base
  validates :content, presence: true, length: { maximum: 500 }
  validates :question_id, presence: true
  belongs_to :question
  
end