# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
# new customer mail preview    
  def new_customer    
    UserMailer.new_customer_email(User.first)
  end
# payment problem mail preview   
  def payment_problem
    UserMailer.payment_problem_email(User.first)
  end
# destroy customer mail preview   
  def destroy_customer
    UserMailer.destroy_customer_email(User.first.email)
  end
# invoice mail preview   
  def invoice_email
    UserMailer.invoice_email(User.first.email, "tmp/test_invoice.pdf")     
  end  
end
