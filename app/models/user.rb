class User < ActiveRecord::Base
  has_many :conversations, dependent: :destroy

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
      user.fullname = auth["info"]["name"]
      user.avatarurl = auth["info"]["image"]
      user.bannerurl = auth["extra"]["raw_info"]["profile_banner_url"]
    end
  end
end
