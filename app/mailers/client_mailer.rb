# class to send mails to client
class ClientMailer < ApplicationMailer
  default from: 'taxi@taxi.com'

  def welcome_email(order_id, email)
    @auto = Driver.find(Order.find(order_id).driver_id).auto
    mail(to: email, subject: 'Taxi')
  end

  def cancel_email(order_id, email)
    @order = Order.find(order_id)
    @auto = Driver.find(Order.find(order_id).driver_id).auto
    mail(to: email, subject: 'Taxi')
  end
end
