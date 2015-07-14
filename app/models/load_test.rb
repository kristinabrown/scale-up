require 'capybara/poltergeist'

class LoadTest
  attr_reader :session
  
  def initialize
    @session = Capybara::Session.new(:poltergeist)
  end
  
  def browse
    loop do
      
      visit_root
      log_in("sample@sample.com", "password")
      create_ticket
      log_out
      search_events
      add_to_cart_create_account
      log_in("admin@admin.com", "password")

      session.click_link "Users"
      session.all("tr").sample.click_link "Store"
      session.click_link "Events"
      session.click_link "Manage Events"
      puts "visit events index"
      session.all("tr").sample.click_link "Edit"
      session.fill_in "event[title]", with: ("A".."Z").to_a.shuffle.first(5).join
      session.fill_in "event[date]", with: 33.days.from_now.change({ hour: 5, min: 0, sec: 0  })
      session.fill_in "event[start_time]", with: "2000-01-01 19:00:00"
      session.click_button "Submit"
      puts "edited event"
      session.all("tr").sample.click_link "Delete"
      session.click_link "Create Event"
      session.fill_in "event[title]", with: ("A".."Z").to_a.shuffle.first(5).join
      session.fill_in "event[description]", with: "No description necessary."
      session.fill_in "event[date]", with: 33.days.from_now.change({ hour: 5, min: 0, sec: 0  })
      session.fill_in "event[start_time]", with: "2000-01-01 19:00:00"
      session.click_button "Submit"
      
      log_out
      puts "Admin Done"
    end
  end
  
  def visit_root
    session.visit("http://scale-up.herokuapp.com")
  end
  
  def log_in(email, password)
    session.click_link("Login")
    session.fill_in "session[email]", with: email
    session.fill_in "session[password]", with: password
    session.click_link_or_button("Log in")
    puts "Login"
  end
  
  def create_ticket
    session.click_link("My Hubstub")
    session.click_link("List a Ticket")
    session.select  "TLC", from: "item[event_id]"
    session.fill_in "item[section]", with: "FA"
    session.fill_in "item[row]", with: "555"
    session.fill_in "item[seat]", with: "60"
    session.fill_in "item[unit_price]", with: 30
    session.select  "Electronic", from: "item[delivery_method]"
    session.click_button("List Ticket")
    puts "New ticket created"
  end
  
  def log_out
    session.click_link("Logout")
    puts "Logout"
  end
  
  def search_events
    session.click_link("Buy")
    session.click_link("All Tickets")
    session.click_link("All")
    session.click_link("Sports")
    session.click_link("Music")
    session.click_link("Theater")
    session.click_link("Circus")
    session.click_link("Rodeo")
    session.click_link("Rock")
  end
  
  def add_to_cart_create_account
    session.all("p.event-name a").sample.click
    session.all("tr").sample.find(:css, "input.btn").click
    puts "one thing added to cart"
    session.click_link("Cart(1)")
    session.click_link("Checkout")
    session.click_link("here")
    
    session.fill_in "user[full_name]", with: "Kristina B"
    session.fill_in "user[display_name]", with: ("A".."Z").to_a.shuffle.first(2).join
    session.fill_in "user[email]", with: (1..20).to_a.shuffle.join + "@sample.com"
    session.fill_in "user[street_1]", with: "main st"
    session.fill_in "user[city]", with: "Portland"
    session.select  "Oregon", from: "user[state]"
    session.fill_in "user[zipcode]", with: "97215"
    session.fill_in "user[password]", with: "password"
    session.fill_in "user[password_confirmation]", with: "password"
    session.click_button("Create my account!")
    
    session.click_link("Cart(1)")
    session.click_link_or_button("Remove")
  end
end