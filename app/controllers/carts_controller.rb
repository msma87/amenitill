
class CartsController < ApplicationController
  def index
    @products = Product.all
    @cart = session[:cart] || []
    @cart_grouped = @cart.group_by(&:itself).transform_values(&:count)

    @cart_items = @cart_grouped.map do |code, quantity|
      product = Product.find_by(code: code)
      {
        product: product,
        quantity: quantity,
        subtotal: product.price * quantity,
        discount: calculate_discount(product.code, quantity, product.price)
      }
    end

    @total = @cart_items.sum { |item| item[:subtotal] - item[:discount] }
  end

  def add
    session[:cart] ||= []
    session[:cart] << params[:code]

    update_cart_state

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def remove
    session[:cart] ||= []
    index = session[:cart].index(params[:code])
    index ||= session[:cart].length
    session[:cart].delete_at(index)

    update_cart_state

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  def empty
    session[:cart] = []

    update_cart_state

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def update_cart_state
    @cart = session[:cart]
    @cart_grouped = @cart.group_by(&:itself).transform_values(&:count)

    @cart_items = @cart_grouped.map do |code, quantity|
      product = Product.find_by(code: code)
      {
        product: product,
        quantity: quantity,
        subtotal: product.price * quantity,
        discount: calculate_discount(product.code, quantity, product.price)
      }
    end

    @total = @cart_items.sum { |item| item[:subtotal] - item[:discount] }
  end

  def calculate_discount(code, quantity, price)
    case code
    when 'GR1'
      (quantity / 2) * price
    when 'SR1'
      quantity >= 3 ? (price - 4.50) * quantity : 0
    when 'CF1'
      quantity >= 3 ? (price * (1 / 3.0) * quantity).round(2) : 0
    else
      0
    end
  end
end
