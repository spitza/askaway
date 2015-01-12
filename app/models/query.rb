class Query < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  
  belongs_to :akser, :class_name => 'User'
  belongs_to :askee, :class_name => 'User'
  has_reputation :votes, source: :user, aggregated_by: :sum, dependent: :destroy
  has_one :response, dependent: :destroy
  
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
  
end
