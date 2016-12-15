require 'rails_helper'

RSpec.describe ClientMailer, type: :mailer do
  context 'Sending email' do
    before(:each) do
      @client = create(:client)
      @driver = create(:driver)
      @order = create(:order)
      @order.driver_id = @driver.id
      @order.save
    end

    it 'should send email ' do
      email = ClientMailer.welcome_email(@order.id, @client.email)

      assert_emails 1 do
        email.deliver_now
      end

      assert_equal 'Taxi', email.subject
      assert_equal [@client.email], email.to
    end
  end
end
