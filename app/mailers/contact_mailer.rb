class ContactMailer < ApplicationMailer
	# default to: # my email address

    def contact_email(name, email, body)
        @name = name
        @email = email
        @body = body

        mail(to: email, subject: 'Contact Request')
    end
end
