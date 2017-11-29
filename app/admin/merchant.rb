ActiveAdmin.register_page "Merchant" do


  content only: :index do
    render 'index'
  end

  controller do
    def index
      @merchants = User.where("user_type =? ", true)
    end
  end
end