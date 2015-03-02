require 'rubygems'
require 'rspec'
require 'appium_lib'
require 'net/http'
require 'sauce_whisk'



RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end


def desired_caps
  {
      caps: {
          platformName: 'android',
          deviceName:  'Nexus',
          platformVersion:  '4.4',
          appPackage: 'com.gannett.local.library.news.indystar',
          appActivity: 'com.gannett.local.library.news.indystar.LocalActivity'
      },
      appium_lib: {
          sauce_username: nil, # don't run on sauce
          sauce_access_key: nil,
          wait: 10,
      }
  }
end

describe 'USAT Android Suite' do

  before(:all) do
    Appium::Driver.new(desired_caps).start_driver
    Appium.promote_appium_methods RSpec::Core::ExampleGroup
    if find_element(:id, 'android:id/alertTitle')
      wait do
        text('Cancel').click
      end
    end
    if find_element(:id, 'com.gannett.local.library.news.democratandchronicle:id/buttonUserEdOk')
      wait do
        find_element(:id, 'com.gannett.local.library.news.democratandchronicle:id/buttonUserEdOk')
      end
    end
  end

  after(:all) do
    driver_quit
  end

  describe 'top navigation' do

    it 'navigation icon exists' do
      wait { find_element(:name, 'Navigate up') }
    end

    it 'account icon exists' do
      wait { find_element(:name, 'Account')}
    end

    it 'refresh icon exists' do
      wait { find_element(:name, 'Refresh')}
    end

    it 'settings icon exists' do
      wait { find_element(:name, 'More options')}
    end

  end

describe 'account screen' do
  it 'log-out and log-in' do
    wait do
      find_element(:name, 'Account').click
      text('ACCOUNT MANAGEMENT')
      text('Log out').click
      text('Log in').click
      find_element(:name, 'Email address').send_keys "us\\gsypolt"
      find_element(:name, 'Password').click
      find_element(:name, 'Password').send_keys "yourpassword"
      find_element(:name, 'Log in').send_keys
      if text('ACCOUNT MANAGEMENT')
        back
      end
      find_element(:name, 'Navigate up')
    end

  end

  it 'change temperature unit to ºC' do
    wait { find_element(:name, 'Account').click }
    wait { find_element(:id, 'com.gannett.local.library.news.indystar:id/celsiusButton').click }
    wait { find_element(:id, 'com.gannett.local.library.news.indystar:id/fahrenheitButton').click }
    back
    wait { find_element(:name, 'Navigate up') }
  end

end

describe 'weather' do

  it 'current temp' do
    wait { find_element(:name, 'Navigate up').click }
    wait { text('Weather').click }
    wait { find_element(:id, 'com.gannett.local.library.news.indystar:id/textViewCurrentTemp') }
    back
  end

  it 'nav bar icon exits' do
    wait { find_element(:name, 'Navigate up').click }
    wait { text('Weather').click }
    wait { find_element(:id, 'View Map') }
    wait { find_element(:id, 'Manage Locations') }
    wait { find_element(:id, 'Account') }
    wait { find_element(:id, 'More options')}
    back
  end

  it 'view map' do
    wait { find_element(:name, 'Navigate up').click }
    wait { text('Weather').click }
    wait { find_element(:id, 'View Map').click }
    wait do
      zoom 200
      pinch 75
    end
    wait { find_element(:id, 'com.gannett.local.library.news.indystar:id/mapKey') }
    wait { find_element(:id, 'com.gannett.local.library.news.indystar:id/buttonAccuweatherAppLink') }
    wait { find_element(:id, 'com.gannett.local.library.news.indystar:id/buttonMoreMapDetails') }
    2.times { back }
  end

  it 'current temp' do
    wait { find_element(:name, 'Navigate up').click }
    wait { text('Weather').click }
    wait { find_element(:id, 'com.gannett.local.library.news.indystar:id/textViewCurrentTemp') }
    back
  end

end

  describe 'sports' do

    it 'stickness by close and launch app' do
      wait { find_element(:name, 'Navigate up').click }
      wait { text('Sports').click }
      wait { text('Pacers').click }
      wait { text_exact('Pacers') }
      # Need to research how to close and launch app for stickness
      # close_app
      # launch_app
      # wait { text_exact('Pacers') }
    end
  end

end
