desc "Simulate load against HubStub application"
task :load_test => :environment do
  session = Capybara::Session.new(:selenium)
  loop do
    session.visit("http://scale-up.herokuapp.com")
    #user logs in and lists a ticket
    session.click_link("Login")
    session.fill_in "session[email]", with: "sample@sample.com"
    session.fill_in "session[password]", with: "password"
    session.click_link_or_button("Log in")
    puts "Login"
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
    session.click_link("Logout")
    puts "Logout"
    
    #guest adds something to cart and signs up
    session.click_link("Buy")
    session.click_link("All Tickets")
    puts "all tickets clicked"
    session.click_link("All")
    puts "sports searched"
    session.all("p.event-name a").sample.click
    session.all("tr").sample.find(:css, "input.btn").click
    puts "one thing added to cart"
    session.click_link("Cart(1)")
    session.click_link("Checkout")
    session.click_link("here")
    session.fill_in "user[full_name]", with: "Kristina B"
    session.fill_in "user[display_name]", with: "kb"
    session.fill_in "user[email]", with: (1..20).to_a.shuffle.join + "@sample.com"
    session.fill_in "user[street_1]", with: "main st"
    session.fill_in "user[city]", with: "Portland"
    session.select  "Oregon", from: "user[state]"
    session.fill_in "user[zipcode]", with: "97215"
    session.fill_in "user[password]", with: "password"
    session.fill_in "user[password_confirmation]", with: "password"
    session.click_button("Create my account!")
    puts "create account"
  end
end