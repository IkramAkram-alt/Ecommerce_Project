class CommentsController < ApplicationController
  before_action  :set_comment, only: %i[ show edit update destroy ]
  before_action :set_product, only: %i[ index update new create destroy edit]
  def index
    @comments = @product.comments
  end

  def new
    @comment = @product.comments.new
  end
  def edit
    authorize @comment
  end

  def create
    @comment = @product.comments.build(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to product_path(@product), notice: "commented!" }
        format.json { render :show, status: :created, location: @comment }

      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @comment
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to product_path(@product), notice: "comment was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @comment
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to product_path(@product), notice: "comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id,:product_id)
  end
end
