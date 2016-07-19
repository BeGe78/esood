# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview  
  def new_customer
    UserMailer.new_customer_email  
  end
  def payment_problem
    UserMailer.payment_problem_email
  end
  def destroy_customer
    UserMailer.destroy_customer_email 
  end
  def invoice_email
    UserMailer.invoice_email(User.first.email, "tmp/test_invoice.pdf")     
  end  
end
