module ApplicationHelper
  def active_class(path)
    request.path == path ? 'active' : ''
  end

  # def set_cart
  #   current_cart = current_user.cart.find_by(id: session[:cart_id]) || current_user.cart.create
  #   session[:cart_id] = @cart.id
  # end

end
