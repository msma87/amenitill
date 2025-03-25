class CartsController < ApplicationController
  # Main page: show available products and cart items
  def index
    @products = Product.all # All products from database
    @cart = session[:cart] || [] # Use session to persist cart
    @cart_items = @cart.map { |code| Product.find_by(code: code) } # Convert codes to products
  end

  # Add a product to the cart
  def add
    session[:cart] ||= [] # Initialize session cart if empty
    session[:cart] << params[:code] # Add product code to session cart
    redirect_to root_path # Redirect back to the homepage to see the updated cart
  end

    # Remove one occurrence of the product code from the cart
  def remove
    session[:cart] ||= []
    session[:cart].delete_at(session[:cart].index(params[:code]) || session[:cart].length)
    redirect_to root_path
  end
end
