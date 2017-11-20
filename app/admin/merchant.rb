ActiveAdmin.register_page "Merchant" do

  content only: :index do
    render 'index'
  end

  # content only: :edit do
  #   render partial: 'edit'
  # end

  controller do
    def index
      @merchants = User.where("user_type =? ", true)
    end

    # def edit
    #   @page = Page.find params[:id]
    # end
  end
end