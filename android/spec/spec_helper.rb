require 'rubygems'
require 'rspec'
require 'appium_lib'
require 'selenium-webdriver'
require 'pry'

require_relative '../pages/navApp.rb'
require_relative '../../android/pages/first_time.rb'

caps = Appium.load_appium_txt file: File.join(Dir.pwd, 'appium.txt')

RSpec.configure do |config|

  config.before(:each) do

    Appium::Driver.new(caps).start_driver
    Appium.promote_appium_methods RSpec::Core::ExampleGroup
    Appium.promote_singleton_appium_methods Pages
  end

  config.after(:each) do
    driver_quit
  end

end
