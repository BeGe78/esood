# test/mailers/previews/my_mailer_preview.rb  
# Preview all emails at http://localhost:3000/rails/mailers/my_mailer  
# {MyMailer Corresponding mailer:}   
class MyMailerPreview < ActionMailer::Preview
  # confirmation intructions mail preview
  def confirmation_instructions
    MyMailer.confirmation_instructions(User.first, 'faketoken', {})
  end
  
  # reset password intructions mail preview
  def reset_password_instructions
    MyMailer.reset_password_instructions(User.first, 'faketoken', {})
  end
  
  # change password intructions mail preview  
  def password_change
    MyMailer.password_change(User.first, {})
  end
  
  # unlock intructions mail preview
  def unlock_instructions
    MyMailer.unlock_instructions(User.first, 'faketoken', {})
  end
end
