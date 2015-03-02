# filename: pages/navApp.rb

module Pages
  module FirstTime
    class << self

      def notification_dismiss
        begin
          if find_element(:id, 'android:id/alertTitle')
            puts "alert is present"
            alert_dismiss
          end
        rescue
          puts "alert is not present"
        end
      end

      def notification_accept
        alert_accept
      end

      def got_it
        # require 'debug'
        begin
          if find_element(:id, 'com.gannett.local.library.news.democratandchronicle:id/buttonUserEdOk')
            puts "got it overlay is present"
            find_element(:id, 'com.gannett.local.library.news.democratandchronicle:id/buttonUserEdOk').click
          end
        rescue
          puts "got it overlay is not present"
        end
      end
    end
  end
end

module Kernel
  def firstTime
    Pages::FirstTime
  end
end