ActiveAdmin.register_page "Merchant" do

  content only: :index do
    render 'index'
  end

  controller do
    def index
      @merchants = User.where("user_type =? ", true)
    end

    def destroy
    	@user = User.find(params[:id])
    	@user.destroy
    	redirect_to admin_merchant_path
    end
  end
end