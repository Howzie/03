class PagesController < ApplicationController

	def about_us
		
	end

	def faqs
		
	end

	def send_mail
		name = params[:name]
	    email = params[:email]
	    body = params[:description]
	    ContactMailer.contact_email(name, email, body).deliver_now
	    redirect_to root_path, notice: 'Message sent successfully'
	end
end
