class PaymentMailer < ApplicationMailer

	def beacon_creation_email(payment)
	  @key = payment.key
	  @business = payment.location.business
	  @location = payment.location
	  @url = new_beacon_url(key: @key)
	  mail(to: 'wesfed@gmail.com', subject: 'New iBeacon Order')
	end

end
