# 🧾 AmeniTill – Cash Register App (Tech Challenge)

AmeniTill is a simple, modern and responsive web app built with Ruby on Rails for the a Tech Challenge. It simulates a cash register that allows users to add products to a cart and automatically applies dynamic pricing rules based on promotions.

![Screenshot](public/screenshot.png) 

---

## 🚀 Features

- ✅ Add products to cart
- ✅ See quantity, subtotal, and discounts
- ✅ Promotions are applied dynamically:
  - GR1 – Green Tea: Buy-One-Get-One-Free
  - SR1 – Strawberries: €4.50 each when you buy 3+
  - CF1 – Coffee: 33% off when you buy 3+
- ✅ Remove single items or empty entire cart
- ✅ Real-time cart update with Turbo Stream (no page refresh!)
- ✅ Fully responsive layout with modern Bootstrap 5 styling
- ✅ Icons and badges for enhanced UX

---

## 🛠 Tech Stack

- Ruby on Rails 7
- Turbo (Hotwire)
- Bootstrap 5
- RSpec (TDD)

---

## 🧪 Tests

This project follows the TDD approach with RSpec:

- ✅ Discount logic unit tests (GR1, SR1, CF1)
- ✅ Request test for cart interaction (optional)
- Run tests with:

```bash
bundle exec rspec
📸 Screenshots
Desktop	Mobile
📂 Project Structure Highlights
shell
Copy
Edit
.
├── app/
│   ├── controllers/carts_controller.rb  # main logic (add/remove/discounts)
│   ├── views/carts/index.html.erb       # UI with products and cart
│   ├── views/carts/_cart.html.erb       # cart partial for Turbo
│   └── assets/stylesheets/...           # custom styling
├── spec/
│   └── models/discount_spec.rb          # test discount rules (RSpec)
├── config/
│   └── routes.rb                        # routing for cart actions
🧠 Learning Reflection
As a junior developer, I focused on:

Building readable and modular code

Applying clean UI/UX principles

Following the TDD approach using RSpec

Making the app responsive and enjoyable to use

▶️ How to Run Locally
bash
Copy
Edit
git clone https://github.com/msma87/amenitill.git
cd amenitill
bundle install
bin/rails db:setup
bin/rails s
Visit http://localhost:3000

✨ By Máira Senna Martins de Almeida
💡 Thanks for the opportunity!
