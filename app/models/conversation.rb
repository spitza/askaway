class Conversation < ActiveRecord::Base
  belongs_to :user
  #validates :uid, presence: true
  validates :prompt, presence: true
end
