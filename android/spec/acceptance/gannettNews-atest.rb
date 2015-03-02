# filename: android/spec/acceptance/gannettNews-atest.rb

describe 'Gannett News app' do

    # describe 'on the device' do
    #   it 'install app' do
    #     install '~/work/github/gannett-android-apps/gannettNews/build/outputs/apk/gannettNews-rochester-debug.apk'
    #   end
    #
    #   it 'remove app' do
    #     remove 'com.gannett.local.library.news.democratandchronicle'
    #   end
    # end

    describe 'from home section' do

      it 'should see home icon ' do
        wait do
          firstTime.notification_dismiss
          firstTime.got_it
          home.brand_icon
        end
      end

      it 'should see refresh icon' do
        find_element(:name, 'Refresh')
      end

    end

    describe 'go to weather section' do

        it 'should see local weather icon from home section' do
          wait do
            find_element(:id, 'com.gannett.local.library.news.democratandchronicle:id/imageViewCurrentConditionsIcon')
          end

        end

        it 'should see manage locations and view map icons from weather section' do
          wait do
            find_element(:id, 'com.gannett.local.library.news.democratandchronicle:id/imageViewCurrentConditionsIcon').click
            # got_it
            find_element(:name, 'Manage Location')
            find_element(:name, 'View Map')
            back
          end
        end

        it 'should see view map and zoom/pinch' do
          wait do
            # is_installed? "com.gannett.local.library.news.democratandchronicle"
            find_element(:id, 'com.gannett.local.library.news.democratandchronicle:id/imageViewCurrentConditionsIcon').click
            # firstTime.got_it
            find_element(:name, 'View Map').click
            # firstTime.got_it
            find_element(:id, 'com.gannett.local.library.news.democratandchronicle:id/mapKey')


            # need to investigate zoom and pitch is possible with a 3rd party integration with accuweather
            # Zoom 200 on the 3rd party integration with Accweather
            action = zoom 200
            puts(action)
            action.perform

            # pinch 100

            # find_id('com.gannett.local.library.news.democratandchronicle:id/mapKey')
            # find_id('com.gannett.local.library.news.democratandchronicle:id/buttonAccuweatherAppLink')
            # text('More Map Details')
            3.times { back }
          end
        end

    end

    describe 'go to photos section' do

      it 'swipe' do
        wait do
          # require "debug"
          # firstTime.notification_dismiss
          home.brand_icon
          home.navPhotos
          find_element(:id, 'com.gannett.local.library.news.democratandchronicle:id/imageViewGalleryThumb').click
          # Investigating Swipe
          # find_element(:xpath, "//android.view.View[1]/android.widget.FrameLayout[2]/android.view.View[1]/android.widget.FrameLayout[1]/android.widget.RelativeLayout[1]/android.widget.ListView[1]/android.widget.LinearLayout[2]/android.widget.RelativeLayout[1]/android.widget.RelativeLayout[1]/android.widget.ImageView[1]").click
          sleep 2
          swipe :start_x => 735, :start_y => 667, :end_x => 80, :end_y => 668, :touchCount => 1, :duration => 0.5
          sleep 5
          back
        end
      end

    end

end
