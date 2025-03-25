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
end
