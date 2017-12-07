class ContactMailer < ApplicationMailer
    def contact_email(name, email, body)
        @name = name
        @email = email
        @body = body

        mail(to: "rupaliji@hotmail.com", subject: 'Contact Request')
    end
end
