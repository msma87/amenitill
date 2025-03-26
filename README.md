# 🧾 AmeniTill – Cash Register App (Tech Challenge)

AmeniTill is a simple, modern and responsive web app built with Ruby on Rails for the a Tech Challenge. It simulates a cash register that allows users to add products to a cart and automatically applies dynamic pricing rules based on promotions.

![image](https://github.com/user-attachments/assets/e0d3c32b-0b55-4f18-a072-5e4fbee6ff77)

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
```
  
---

## 📸 Screenshots

Desktop	

![image](https://github.com/user-attachments/assets/c1cc9b10-670e-471c-a4a0-68611f86f6c7)

Mobile
<p align="center">
  <img src="https://github.com/user-attachments/assets/350d3141-2029-42c7-8359-47f31a23f543" alt="Desktop view" width="45%" style="margin-right: 10px;">
  <img src="https://github.com/user-attachments/assets/d800a355-6ed5-4d76-8ab2-8118a1c2f76b" alt="Mobile view" width="45%">
</p>

---

## 📂 Project Structure Highlights

```bash
├── app/
│   ├── controllers/
│   │   └── carts_controller.rb       # Main logic (add/remove/discounts)
│   ├── views/
│   │   └── carts/
│   │       ├── index.html.erb        # Full UI with products and cart
│   │       └── _cart.html.erb        # Cart partial for Turbo updates
│   └── assets/
│       └── stylesheets/              # Custom styling (Bootstrap overrides)
├── spec/
│   └── models/
│       └── discount_spec.rb          # Unit tests for discount rules
├── config/
│   └── routes.rb                     # Defines cart routes (add/remove/empty)
```

---

## 🧠 Learning Reflection
As a junior developer, I focused on:
- Building readable and modular code
- Applying clean UI/UX principles
- Following the TDD approach using RSpec
- Making the app responsive and enjoyable to use

---

## ▶️ How to Run Locally
```bash
git clone https://github.com/msma87/amenitill.git
cd amenitill
bundle install
bin/rails db:setup
bin/rails s
Visit http://localhost:3000
```
