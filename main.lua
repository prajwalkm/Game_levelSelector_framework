local composer= require "composer"

--HiddenStatusBar

display.setStatusBar( display.HiddenStatusBar )

composer.gotoScene( "load" )

uidBanner = "ca-app-pub-5644412795895538/5774374400"
uidInters = "ca-app-pub-5644412795895538/5634773601"
adsBanner = require( "ads" )
adsInterstitial = require( "ads" )
isBannerShow = false

local function adBannerListener( event )
    if ( event.isError ) then
        -- Failed to receive an ad
        print( "Error init Banner " + event.isError )
    --    txtDebug.text = "Error init Banner " + event.isError
    end
end

local function adInterstitialListener( event )
    if ( event.isError ) then
        -- Failed to receive an ad
        print( "Error init Interstitial " + event.isError )
    --    txtDebug.text = "Error init Interstitial " + event.isError
    end
end

adsBanner.init( "admob", uidBanner, adBannerListener )
adsInterstitial.init( "admob", uidInters, adInterstitialListener )

adsInterstitial.load( "interstitial" )
