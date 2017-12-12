class ContactMailer < ApplicationMailer
    def contact_email(name, email, body)
        @name = name
        @email = email
        @body = body

        mail(to: "office@howzie.net", subject: 'Contact Request')
    end
end
