module ValidatesCaptcha
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def validates_captcha
      helper CaptchaHelper
      include ValidatesCaptcha::InstanceMethods
    end
  end
  
  module InstanceMethods
    def captcha_validated?
      if session[:captcha_alreadysubmited] == true or CaptchaUtil::encrypt_string(params[:captcha].to_s.gsub(' ', '').gsub('0', 'o').downcase) == params[:captcha_validation]
        session[:captcha_alreadysubmited] = true
        return true
      else
        return false
      end
    end    
  end  
end  