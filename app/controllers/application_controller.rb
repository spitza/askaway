class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  private
  
  def current_user
   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  #not using the following portrait function yet.  For resizing profile images.
  
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

  helper_method :current_user
  helper_method :portrait
end
