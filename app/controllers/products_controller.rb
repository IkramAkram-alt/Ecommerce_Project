class ProductsController < ApplicationController
  before_action :authenticate_user!, :set_product, only: %i[ edit update destroy ]
  before_action :set_cart, only: %i[show index]
  # GET /products or /product.json
  def index
    @products = Product.all
    @cart_item = @cart.cart_items.new
  end

  # GET /products/1 or /products/1.json
  def show
    @product = Product.find(params[:id])
    @cart_item = @cart.cart_items.new

  end

  # GET /products/new
  def new
    @product = Product.new
    authorize @product
  end

  # GET /products/1/edit
  def edit
    authorize @product
  end

  # POST /products or /products.json
  def create

    @product = current_user.products.new(product_params)
    authorize @product
    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path, notice: "product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    authorize @product
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_path, notice: "product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    authorize @product
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_path(@user), notice: "product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def set_cart
      @cart = current_user.cart
    end

    def product_params
      params.require(:product).permit(:name, :price,:user_id,:brand,images:[])
    end
end
