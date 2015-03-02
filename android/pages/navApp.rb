# filename: pages/navApp.rb

module Pages
  module Home
    class << self

      def brand_icon
        wait do
          find_element(:id,'android:id/home')
        end
      end

      def navPhotos
        brand_icon.click
        text('Photos').click
        text('Top Photos').click
      end

    end
  end
end

module Kernel
  def home
    Pages::Home
  end
end