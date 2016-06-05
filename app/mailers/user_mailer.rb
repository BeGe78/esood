class UserMailer < ApplicationMailer
    default from: 'bgardin@gmail.com'

  def new_customer_email
    mail(to: 'bgardin@gmail.com', subject: 'New customer on ESoOD')
  end
  def payment_problem_email
    mail(to: 'bgardin@gmail.com', subject: 'Payment problem on ESoOD')
  end
  def destroy_customer_email
    mail(to: 'bgardin@gmail.com', subject: 'Customer deleted on ESoOD')
  end
end
