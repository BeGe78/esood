class UserMailer < ApplicationMailer
    default from: 'bgardin@gmail.com'

  def new_customer_email(user)
    @user = user  
    mail(to: 'bgardin@gmail.com', subject: 'New customer on ESoOD')
  end
  def payment_problem_email(user)
    @user = user 
    mail(to: 'bgardin@gmail.com', subject: 'Payment problem on ESoOD')
  end
  def destroy_customer_email(email)
    @email = email  
    mail(to: 'bgardin@gmail.com', subject: 'Customer deleted on ESoOD') do |format|
      format.html {
      render locals: { email: @email }
      }
end
  end
  def invoice_email(email,invoice_pdf)
    attachments.inline['invoice.pdf'] = File.read(invoice_pdf)  
    mail(to: email, subject: t('ESoOD_Invoice'))
  end  
end
