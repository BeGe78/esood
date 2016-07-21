# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# Default values for application mailer
class ApplicationMailer < ActionMailer::Base
  default from: "bgardin@gmail.com"
  layout 'mailer'
end
