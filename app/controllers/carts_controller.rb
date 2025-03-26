
class CartsController < ApplicationController
  # Index action to display the products and cart
  def index
    # Fetch all products from the database
    @products = Product.all
    # Get the cart from the session or initialize an empty array
    @cart = session[:cart] || []
    # Group the cart items by their code and count the quantity of each item
    @cart_grouped = @cart.group_by(&:itself).transform_values(&:count)

    # Map the grouped cart items to an array of hashes containing product details, quantity, subtotal, and discount
    @cart_items = @cart_grouped.map do |code, quantity|
      product = Product.find_by(code: code)
      {
        product: product,
        quantity: quantity,
        subtotal: product.price * quantity,
        discount: calculate_discount(product.code, quantity, product.price)
      }
    end

    # Calculate the total price of the cart by summing the subtotal minus the discount for each item
    @total = @cart_items.sum { |item| item[:subtotal] - item[:discount] }
  end

  # Add action to add a product to the cart
  def add
    # Get the cart from the session or initialize an empty array
    session[:cart] ||= []
    # Add the product code to the cart
    session[:cart] << params[:code]

    # Update the cart state
    update_cart_state

    # Respond to the request with Turbo Stream or HTML
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  # Remove action to remove a product from the cart
  def remove
    # Get the cart from the session or initialize an empty array
    session[:cart] ||= []
    # Find the index of the product code in the cart
    index = session[:cart].index(params[:code])
    # If the product code is not found, set the index to the length of the cart
    index ||= session[:cart].length
    # Delete the product code from the cart at the found index
    session[:cart].delete_at(index)

    # Update the cart state
    update_cart_state

    # Respond to the request with Turbo Stream or HTML
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  # Empty action to empty the cart
  def empty
    # Set the cart to an empty array
    session[:cart] = []

    # Update the cart state
    update_cart_state

    # Respond to the request with Turbo Stream or HTML
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  # Update the cart state
  def update_cart_state
    # Get the cart from the session
    @cart = session[:cart]
    # Group the cart items by their code and count the quantity of each item
    @cart_grouped = @cart.group_by(&:itself).transform_values(&:count)

    # Map the grouped cart items to an array of hashes containing product details, quantity, subtotal, and discount
    @cart_items = @cart_grouped.map do |code, quantity|
      product = Product.find_by(code: code)
      {
        product: product,
        quantity: quantity,
        subtotal: product.price * quantity,
        discount: calculate_discount(product.code, quantity, product.price)
      }
    end

    # Calculate the total price of the cart by summing the subtotal minus the discount for each item
    @total = @cart_items.sum { |item| item[:subtotal] - item[:discount] }
  end

  # Calculate the discount for a product based on its code and quantity
  def calculate_discount(code, quantity, price)
    case code
    when 'GR1'
      # Buy-one-get-one-free offer for Green Tea
      (quantity / 2) * price
    when 'SR1'
      # Discount for bulk purchases of Strawberries
      quantity >= 3 ? (price - 4.50) * quantity : 0
    when 'CF1'
      # Discount for bulk purchases of Coffee
      quantity >= 3 ? (price * (1 / 3.0) * quantity).round(2) : 0
    else
      # No discount for other products
      0
    end
  end
end
