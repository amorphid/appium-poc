require 'rubygems'
require 'rspec'
require 'appium_lib'
require 'net/http'

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

APP_PATH = '/Users/gsypolt/work/github/appium-demo/ios/indianapolis-in.app'

def desired_caps
  {
    caps: {
      platformName: 'iOS',
      deviceName:  'iPhone Simulator',
      versionNumber:  '7.1',
      app: APP_PATH
    },
    appium_lib: {
      sauce_username: nil, # don't run on sauce
      sauce_access_key: nil,
      wait: 10,
    }
  }
end

describe 'USCP Demo App' do
  before(:all) do
    Appium::Driver.new(desired_caps).start_driver
    Appium.promote_appium_methods RSpec::Core::ExampleGroup
  end

  def back_click(opts={})
    opts        ||= {}
    search_wait = opts.fetch(:wait, 10) # seconds
    wait(search_wait) { button_exact('Back').click }
  end

  after(:all) do
    driver_quit
  end

  	describe 'Menu' do
  		it 'Section Menu' do
        wait {find_element(:name, "Section Menu").click }
        # find_exact("News")
  			wait {find_element(:name, "Section Menu").click }
  		end
  	end 

	describe 'Settings' do
		it 'Close' do
			find_element(:name, "Section Menu").click
			find_element(:name, "articleSettings").click
			find_element(:name, "Close").click
			find_element(:name, "Section Menu").click
		end

		it 'Log in' do
			find_element(:name, "Section Menu").click
			find_element(:name, "articleSettings").click
			find_element(:name, "Log In").click
			# find_element(:name, "x").click
			find_element(:xpath, "//UIAApplication[1]/UIAWindow[2]/UIAScrollView[1]/UIAWebView[1]/UIATextField[1]").send_keys "gsypolt"
		end
	end
end