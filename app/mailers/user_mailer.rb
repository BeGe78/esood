# @author Bruno Gardin <bgardin@gmail.com>
# @copyright GNU GENERAL PUBLIC LICENSE  
#   Version 3, 29 June 2007
# Define values for mails to admin  
#![Class Diagram](diagram/my_mailer_diagram.png)
class UserMailer < ApplicationMailer
    default from: 'bgardin@gmail.com'
  # Construct mail for new registration
  # @return [new_customer_email.html.erb]
  # @param user [Record]
  def new_customer_email(user)
    @user = user  
    mail(to: 'bgardin@gmail.com', subject: 'New customer on ESoOD')
  end
  # Construct mail for payment_problem
  # @return [payment_problem_email.html.erb]
  # @param user [Record]
  def payment_problem_email(user)
    @user = user 
    mail(to: 'bgardin@gmail.com', subject: 'Payment problem on ESoOD')
  end
  # Construct mail for registration suppression
  # @return [destroy_customer_email.html.erb]
  # @param email [String]
  def destroy_customer_email(email)
    @email = email  
    mail(to: 'bgardin@gmail.com', subject: 'Customer deleted on ESoOD') do |format|
      format.html {
      render locals: { email: @email }
      }
    end
  end
  # Construct mail for invoice mail to end user
  # @return [invoice_email.html.erb]
  # @param email (String)
  # @param invoice_pdf (Filename)
  def invoice_email(email,invoice_pdf)
    attachments.inline['invoice.pdf'] = File.read(invoice_pdf)  
    mail(to: email, subject: t('ESoOD_Invoice'))
  end  
end
