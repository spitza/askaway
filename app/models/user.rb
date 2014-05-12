class User < ActiveRecord::Base
  has_many :conversations, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :evaluations, class_name: "ReputationSystem::Evaluation", as: :source

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.id = auth["uid"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.fullname = auth["info"]["name"]
      user.avatarurl = auth["info"]["image"].sub("normal", "bigger")
      user.bannerurl = auth["extra"]["raw_info"]["profile_banner_url"]
    end
  end
  
  def voted_for?(question)
    evaluations.exists?(target_type: question.class, target_id: question.id)
  end
  
  def portrait(size)

      # Twitter
      # mini (24x24)                                                                  
      # normal (48x48)                                            
      # bigger (73x73)                                                
      # original (variable width x variable height)

      if self.image.include? "twimg"

          # determine filetype        
          case 
          when self.image.downcase.include?(".jpeg")
              filetype = ".jpeg"
          when self.image.downcase.include?(".jpg")
              filetype = ".jpg"
          when self.image.downcase.include?(".gif")
              filetype = ".gif"
          when self.image.downcase.include?(".png")
              filetype = ".png"
          else
              raise "Unable to read filetype of Twitter image for User ##{self.id}"
          end

          # return requested size
          if size == "original"
              return self.image
          else
              return self.image.gsub(filetype, "_#{size}#{filetype}")
          end

      end

  end
  
  
  
end
