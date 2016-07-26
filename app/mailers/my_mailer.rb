# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# Default values for devise mailer  
# {MyMailerTest Corresponding tests:}   
# {MyMailerPreview Corresponding mails preview:}   
#![Class Diagram](diagram/my_mailer_diagram.png)
class MyMailer < Devise::Mailer   
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views
  # Overrides from to for Devise::Mailer
  def confirmation_instructions(record, token, opts={})
    headers["Custom-header"] = "Bar"
    opts[:from] = 'bgardin@gmail.com'
    opts[:reply_to] = 'bgardin@gmail.com'
    puts(MyMailer.delivery_method)
    super   
  end

  # Overrides same inside Devise::Mailer
  def reset_password_instructions(record, token, opts={})
    set_organization_of record
    super
  end

  # Overrides same inside Devise::Mailer
  def unlock_instructions(record, token, opts={})
    set_organization_of record
    super
  end

  private
  # Sets organization of the user if available
  def set_organization_of(user)
    @organization = user.organization rescue nil
  end
end
