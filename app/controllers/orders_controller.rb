class OrdersController < ApplicationController
before_action :set_order, only: %i[show edit assign_copen payment]

  def new
    @order = Order.new

  end

  def show

  end

  def edit

  end

  def create
    @order = current_user.orders.create(status: 0)
    @cart_items = current_user.cart.cart_items.update(order_id: @order.id, cart_id: nil)
    subtotal = 0
    @order.cart_items.each { |item| subtotal += item.unit_price * item.quantity }
      if @order.update(subtotal: subtotal)
        redirect_to order_path(@order), notice: 'Your order is placed!'
      else
        render :new, status: :unprocessable_entity
      end
  end

  def update

  end

  def assign_copen
    copen = params[:post][:copen]
    copen = Coupen.find_by(coupen_code: copen)
    if copen
      @order.update(total: (@order.subtotal-(@order.subtotal * copen.discount)),coupen_id:  copen.id)
      notice ="Copon is Applied "
    else
      @order.update(total: @order.subtotal)
      notice ="Invalid Copon"
    end
    redirect_to order_path(@order) ,alert: notice
  end

  def payment
    @order.update(status: 1)
    redirect_to products_path, alert: "Thanks for shopping"
  end

  private

  def set_order
    @order = Order.find(params[:id] || params[:order_id])
  end

end
