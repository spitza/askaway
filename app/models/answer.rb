class Answer < ActiveRecord::Base
  validates :content, presence: true
  validates :question_id, presence: true
  belongs_to :question
  
end