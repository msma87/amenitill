class CartsController < ApplicationController
  def index
    # Get all the products from the database to display in the view
    # All products from database
    @products = Product.all

    # Initialize the cart in the session if it doesn't exist
    # The cart is a list of product codes in the session
    @cart = session[:cart] || []

    # Get an array of all the products in the cart
    # Loop through each code in the cart
    # Find the product with the matching code
    # Add it to an array
    @cart_items = @cart.map { |code| Product.find_by(code: code) }

   # Calculate the total price, applying special pricing rules
   @total = calculate_total(@cart_items)
  end

  # The "add" action is called when the user clicks on the "Add to cart"
  # button from the homepage. This action adds the product code of the
  # item clicked on to the session's cart and then redirects them
  # back to the homepage to see the updated cart.
  #
  # The session's cart is an array of product codes. The cart is
  # initialized as an empty array if it doesn't already exist.
  def add
    # Initialize the session cart if it doesn't already exist
    # This is only necessary if the user has never added anything to
    # their cart before.
    session[:cart] ||= []

    # Add the product code of the item just clicked on
    # to the session's cart. This is the code that will be
    # used to find the product in the database when we
    # display the cart.
    session[:cart] << params[:code]

    # Redirect the user back to the homepage to see the updated cart.
    # We'll display the updated cart in the view.
    redirect_to root_path
  end

  def remove
    # Initialize the session cart if it doesn't already exist
    # This is only necessary if the user has never added anything to
    # their cart before.
    session[:cart] ||= []

    # Find the index of the product code in the session cart
    # (i.e. the position of the product in the cart)
    # so we can delete it from the cart.
    index = session[:cart].index(params[:code])

    # If the product code is not in the cart, the index will be
    # `nil`, and we can't delete at `nil`, so we'll just delete
    # at the end of the array if that happens.
    index ||= session[:cart].length

    # Delete the product at the index we just found
    session[:cart].delete_at(index)

    # Redirect the user back to the homepage to see the updated cart.
    # We'll display the updated cart in the view.
    redirect_to root_path
  end

  # The "empty" action is called when the user wants to clear their cart.
  # This action sets the session's cart to an empty array and redirects
  # the user back to the homepage to see the updated cart.
  #
  # The session's cart is an array of product codes. When we set it
  # to an empty array, we effectively clear the cart.
  def empty
    # Clear the session's cart by setting it to an empty array
    session[:cart] = []

    # Redirect the user back to the homepage to see the updated cart.
    redirect_to root_path
  end

  private

  # Calculates the total price of the cart, applying all discount rules
  def calculate_total(items)
    # Group items by product code (e.g., all GR1 items together)
    # This is done so that we can apply the correct discount rules
    # based on the product type.
    grouped = items.group_by(&:code)

    # Initialize the total price of the cart to 0
    total = 0

    # Loop through each group of items
    grouped.each do |code, group|
      case code
      # If the item is Green Tea (GR1), the discount rule is:
      # Buy-One-Get-One-Free
      # Example: 2 items = pay 1; 3 items = pay 2
      when 'GR1'
        # Calculate the number of items we have to pay for
        # (i.e., the number of items divided by 2, rounded up)
        items_to_pay_for = (group.count / 2.0).ceil
        # Calculate the total cost of the items (items_to_pay_for * price)
        # and add it to the total
        total += items_to_pay_for * group.first.price

      # If the item is Strawberries (SR1), the discount rule is:
      # If buying 3 or more, price drops to €4.50 each
      when 'SR1'
        # If the number of items is 3 or more, use the discounted price
        # of €4.50. Otherwise, use the default price.
        price = group.count >= 3 ? 4.50 : group.first.price
        # Calculate the total cost of the items (number of items * price)
        # and add it to the total
        total += group.count * price

      # If the item is Coffee (CF1), the discount rule is:
      # If buying 3 or more, each costs 2/3 of the original price
      when 'CF1'
        # If the number of items is 3 or more, use the discounted price
        # of 2/3 of the original price. Otherwise, use the default price.
        price = group.count >= 3 ? (group.first.price * 2 / 3).round(2) : group.first.price
        # Calculate the total cost of the items (number of items * price)
        # and add it to the total
        total += group.count * price

      # If any other product is added, use the default price
      else
        # Calculate the total cost of the items (number of items * price)
        # and add it to the total
        total += group.sum(&:price)
      end
    end

    # Round the total to 2 decimal places and return it
    total.round(2)
  end
end
