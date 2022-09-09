class CartItemsController < ApplicationController
before_action :set_cart_items, only: %i[ show edit update destroy ]
before_action :set_cart, only: %i[create new ]

  def new
    @cart_item = @cart.cart_items.new
  end

  def create
    @cart_item = @cart.cart_items.new(cart_items_params)
    respond_to do |format|
      if @cart_item.save
        format.html { redirect_to products_path, notice: "added to cart!" }
        format.json { render :show, status: :created, location: @cart_items }

      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show

  end

  def update
    respond_to do |format|
      if @cart_item.update(cart_items_params)
        format.html { redirect_to carts_show_path, notice: "cart was successfully updated." }
        format.json { render :show, status: :ok, location: @cart_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @cart_item.destroy

    respond_to do |format|
      format.html { redirect_to carts_show_path, notice: "Product was successfully Removed." }
      format.json { head :no_content }
    end
  end

  private

  def set_cart
    @cart = current_user.cart
  end

  def set_cart_items
    @cart_item = CartItem.find(params[:id])
  end

  def cart_items_params
    params.require(:cart_item).permit(:product_id,:quantity)
  end



end
