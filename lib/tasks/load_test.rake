require 'capybara/poltergeist'

desc "Simulate load against HubStub application"
task :load_test => :environment do
  [ Thread.new { LoadTest.new.guest_browse }, Thread.new { LoadTest.new.user_stuff }, Thread.new { LoadTest.new.admin_stuff } ].map(&:join)  
end
