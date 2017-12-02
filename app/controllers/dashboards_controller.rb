class DashboardsController < ApplicationController
	before_action :authenticate_user!
	require 'csv'

	def index
		session.delete(:items_id) if session[:items_id].present? 
		session.delete(:postal_code) if session[:postal_code].present?
		session.delete(:delivery_add) if session[:delivery_add].present?
		session.delete(:delivery_date) if session[:delivery_date].present?
		session.delete(:item) if session[:item].present?

		@user_orders = Order.where("user_id =?", current_user.id).paginate(:page => params[:page], :per_page => 50)
		@merchant_items = Item.where("user_id =?", current_user.id).paginate(:page => params[:page], :per_page => 50)
	end

	def import
		csv_text = File.read(params[:file].path)
	    if !csv_text.blank?
	    	csv = CSV.parse(csv_text, :headers => true)
	        csv.each do |row|
	        	Item.create!(user_id: current_user.id, code: row["Code"], name: row["Name"], specification: row["Specification"], price: row["Price"], stock: row["Stock"], delivery_days: row["Delivery_Days"], gst: row["GST"])
	      	end
		end
		flash[:success] = "CSV has been uploaded!!"
		redirect_to dashboards_path
	end

	def upload_inventory
		
	end
end
