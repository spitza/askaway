class User < ActiveRecord::Base
  has_many :conversations, order: 'created_at desc', dependent: :destroy
  has_many :questions, order: 'created_at desc', dependent: :destroy
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :source, dependent: :destroy
  has_many :queries_asked, :class_name => 'Query', :foreign_key => 'asker_id', dependent: :destroy
  has_many :queries_received, :class_name => 'Query', :foreign_key => 'askee_id', dependent: :destroy
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX, on: :update }
  validates :description, length: { maximum: 300 }
  include FriendlyId
  include ActionView::Helpers::TextHelper
  friendly_id :profile_url, use: :slugged
  self.primary_key = 'id'

  def profile_url
    "#{self.name}"
  end
  
  def first_name
    "#{self.fullname.split(" ")[0]}"
  end
  
  def numQueries
    self.queries_received.count
  end
  
  def self.check_existence(auth)
    where(auth.slice("provider", "uid")).first.empty?
  end
  
  def self.get_existing(auth)
    where(auth.slice("provider", "uid")).first
  end
  
  def linked_description
    "#{Rinku.auto_link(self.description, :all, 'target="_blank"')}"
  end

  #creating a new one from the omniauth hash
  
  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.id = auth["uid"].to_i
      user.uid = auth["uid"].to_i
      user.name = auth["info"]["nickname"]
      user.fullname = auth["info"]["name"]
      user.avatarurl = auth["info"]["image"].sub("_normal", "")
      user.description = auth["info"]["description"]
      user.email = auth["uid"].to_i
      #user.website = auth["info"]["urls"]["Website"]
      #unless "#{auth["extra"]["raw_info"]["profile_banner_url"]}".empty?
      #  user.bannerurl = auth["extra"]["raw_info"]["profile_banner_url"] << "/1500x500"
      #end
      
      
    end
  end
  
  #logic to check to see if a user has voted already.
  
  def user_has_upvoted?(question)
    evaluations.where(target_type: question.class, target_id: question.id, value: "1").present?
  end
  
  def user_has_upvoted?(query)
    evaluations.where(target_type: query.class, target_id: query.id, value: "1").present?
  end
  
  def portrait(size)

      # Twitter
      # mini (24x24)                                                            
      # normal (48x48)                                            
      # bigger (73x73)                                                
      # original (variable width x variable height)

      if self.avatarurl.include? "twimg"

          # determine filetype        
          case 
          when self.avatarurl.downcase.include?(".jpeg")
              filetype = ".jpeg"
          when self.avatarurl.downcase.include?(".jpg")
              filetype = ".jpg"
          when self.avatarurl.downcase.include?(".gif")
              filetype = ".gif"
          when self.avatarurl.downcase.include?(".png")
              filetype = ".png"
          else
              raise "Unable to read filetype of Twitter image for User ##{self.id}"
          end

          # return requested size
          if size == "original"
              return self.avatarurl
          else
              return self.avatarurl.gsub(filetype, "_#{size}#{filetype}")
          end

      end

  end
  
  
  
end
