class OrdersController < ApplicationController
	before_action :authenticate_user!
	require 'csv'

	def index
		# @merchant_items = Item.where("user_id =?", current_user.id)
		@sample_csv = ["code", "item", "qty"]
	    respond_to do |format|
	      format.html
	      format.csv { send_data @sample_csv.to_csv}
	      ##we can also change the downloaded CSV file name by setting filename attribute of send_data method
	      #format.csv { send_data @employees.to_csv, :filename => '<file_name>.csv' }
	    end
	end

	def user_order
		session[:items_id] = [] if session[:items_id].blank?
		id = params[:id]
		m = id.match /(.+)-(\d+)/
		item = Item.find(m[1]).code
		
		session[:items_id] << params[:id]
		# puts session[:items_id].inspect
		session[:items_id].each do |a|
			inner_id = a.match /(.+)-(\d+)/
			b = Item.find(inner_id[1]).code

			if item == b and session[:items_id].size > session[:count]
				session[:items_id].delete_if{|i|i == a}
			end
		end
		# puts session[:items_id].inspect
		render :nothing => true
	end

	def show_order
		@start_date = Date.today
		@b, @c = [], []
		session[:items_id].each do |a|
			id = a.match /(.+)-(\d+)/
			@b << id[1]
			@c << id[2]
		end
		@items = Item.where("id IN (?)", @b)
		# abort @items.inspect
	end


	def modify_order
		@start_date = Date.today
		@end_date = session[:delivery_date].to_date
		@b, @c, @short_items = [], [], []
		session[:items_id].each do |a|
			id = a.match /(.+)-(\d+)/
			item_code = Item.find(id[1])

			@c << id[2]

			@items = Item.where("code =? and name =? and stock >=?", item_code.code, item_code.name, id[2]).limit(3)

      		@short = @items.sort_by {|x| [x.price, x.delivery_days] }
      		@short_items << @short
		end
		@i = session[:items_id]
	end

	def upload
		session[:delivery_add] = params[:delivery_add]
		session[:postal_code] = params[:postal_code]
		session[:delivery_date] = params[:delivery_date]
		@start_date = Date.today
		@end_date = params[:delivery_date].to_date
		csv_text = File.read(params[:file].path)
	    if !csv_text.blank?
	    	csv = CSV.parse(csv_text, :headers => true)
	    	@short_items = []
	    	@qty = []
	        csv.each do |row|
	        	@items = Item.where("code =? and name =? and stock >=?", row["code"], row["item"], row["qty"]).limit(3)
	        	@qty << row["qty"]
	      		@short = @items.sort_by {|x| [x.price, x.delivery_days] }
	      		@short_items << @short
	      	end
		end
	end

	def make_order
		@delivery_address = session[:delivery_add]
		if session[:items_id].present?
			session[:recent_orders] = []
			session[:items_id].each do |a|
				id = a.match /(.+)-(\d+)/
				item = Item.find(id[1])

				delivery_date =  Date.today + item.delivery_days
				order = Order.create!(user_id: current_user.id, merchant_id: item.user_id, item_id: item.id, item_qty: id[2], delivery_add: session[:delivery_add], postal_code: session[:postal_code], delivery_date: delivery_date, is_confirm: true )

				session[:recent_orders] << order.id

				@stock = item.update_attributes(stock: item.stock.to_i - id[2].to_i)

			end
			session.delete(:items_id)
			session.delete(:postal_code)
			session.delete(:delivery_add)
			session.delete(:delivery_date)
			session.delete(:count)
			# @my_orders = Order.where("is_delivered = ?", false)
			@my_orders = Order.where("id IN (?)", session[:recent_orders])
			flash[:message] = "Order placed successfully!"		
		else
			@my_orders = Order.where("id IN (?)", session[:recent_orders])
		end
	end

	def my_orders
		@my_orders = Order.where("merchant_id =?", current_user.id)
	end

	def deliver_order
		@order = Order.find_by("id =?", params[:id])
		if @order.is_delivered == true and @order.status == true
			@updated_order = @order.update_attributes(is_delivered: false, status: false)
		else
			@updated_order = @order.update_attributes(is_delivered: true, status: true)
		end
		render :nothing => true
	end

	def order_status
		@user_order = Order.find_by("id =?", params[:id])
		if @user_order.is_completed == true
			@update_order = @user_order.update_attributes(is_completed: false)
		else
			@update_order = @user_order.update_attributes(is_completed: true)
		end
		render :nothing => true
	end

	def show
		@user_order = Order.find(params[:id])
	end
end
