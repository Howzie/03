class NotificationMailer < ApplicationMailer
    def transaction_complete_notification(order)
        @order = order
        @user_email = order.user.email
        @admin_email = AdminUser.first.email
        mail(to: [@user_email, @admin_email], subject: 'Notification for completed transaction')
    end


    def purchase_notification(order, email)
        @order = order
        @user_email = email
        @admin_email = AdminUser.first.email
        mail(to: [@user_email, @admin_email], subject: 'Notification for purchase items')
    end

    def order_deliver_notification(order, email)
       @order = order
       @user_email = email
       @admin_email = AdminUser.first.email
       mail(to: [@user_email, @admin_email], subject: 'Notification for deliver yours item') 
    end
end
