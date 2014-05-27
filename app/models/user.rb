class User < ActiveRecord::Base
  has_many :conversations, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :source

  #checking to see if the user already exists
  
  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  #creating a new one from the omniauth hash
  
  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.id = auth["uid"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.fullname = auth["info"]["name"]
      user.avatarurl = auth["info"]["image"].sub("normal", "")
      user.bannerurl = auth["extra"]["raw_info"]["profile_banner_url"]
    end
  end
  
  #logic to check to see if a user has voted already.
  
  def user_has_upvoted?(question)
    evaluations.where(target_type: question.class, target_id: question.id, value: "1").present?
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
