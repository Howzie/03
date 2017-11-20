class DashboardsController < ApplicationController
	require 'csv'

	def index
		@user_orders = Order.where("user_id =?", current_user.id)
		@merchant_items = Item.where("user_id =?", current_user.id)
	end

	def home
		render :layout => 'landing'
	end

	def import
		csv_text = File.read(params[:file].path)
	    if !csv_text.blank?
	    	csv = CSV.parse(csv_text, :headers => true)
	        csv.each do |row|
	        	Item.create!(user_id: current_user.id, code: row["code"], name: row["name"], specification: row["specification"], price: row["price"], stock: row["stock"], delivery_days: row["delivery_days"], gst: row["gst"])
	      	end
		end
		flash[:success] = "CSV has been uploaded!!"
		redirect_to dashboards_path
	end

	def upload_inventory
		
	end

	def about_us
		
	end

	def faqs
		
	end
end
