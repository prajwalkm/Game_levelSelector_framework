local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
uidBanner = "ca-app-pub-5644412795895538/5774374400"
uidInters = "ca-app-pub-5644412795895538/5634773601"
adsBanner = require( "ads" )
adsInterstitial = require( "ads" )
isBannerShow = false

local function adsBannerEvent( event )
  --  if ( "ended" == event.phase ) then
        if ( isBannerShow == false ) then
            print( "Banner was pressed and released" )
        --    txtDebug.text = "show banner"
            adsBanner.show( "banner", { x=0, y=10000, targetingOptions=targetingParams} )
            isBannerShow = true;
        else
        --    txtDebug.text = "hide banner"
            adsBanner.hide()
            isBannerShow = false
        end

  --  end
end

local function adsIntersEvent( event )

  --  if ( "ended" == event.phase ) then
        if ( adsInterstitial.isLoaded( "interstitial" ) ) then
          --  txtDebug.text = "show Interstitial"
            print( "Interstitial was pressed and released" )
            adsInterstitial.show( "interstitial" ,{ appId=uidInters })
        else
          --  txtDebug.text = "Inters Not Ready Try Load"
            adsInterstitial.load( "interstitial" )
        end
    --end
end

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

----------------------------------------------------------------------------------------------------------------------------------------------------------
local function gotolevel1()
  composer.removeScene( "levelplay")
  composer.gotoScene( "levelplay")
end

local function gotolevel2()
  composer.removeScene(  "level02")
  composer.gotoScene( "level02")
end

local function gotolevel3()
  composer.removeScene(  "level03")
  composer.gotoScene( "level03")
end

local function gotolevel4()
  composer.removeScene(  "level04")
  composer.gotoScene( "level04")
end

local function gotolevel5()
  composer.removeScene(  "level05")
  composer.gotoScene( "level05")
end

local function gotolevel6()
  composer.removeScene(  "level06")
  composer.gotoScene( "level06")
end

local function gotolevel7()
  composer.removeScene(  "level07")
  composer.gotoScene( "level07")
end

local function gotolevel8()
  composer.removeScene(  "level08")
  composer.gotoScene( "level08")
end

local function gotolevel9()
  composer.removeScene(  "level09")
  composer.gotoScene( "level09")
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    bglevel=display.newImage("images/bg/bgwhite.png")
    bglevel.x = centerX
    bglevel.y = centerY
    bglevel.width = screenWidth
    bglevel.height = screenHeight
    sceneGroup:insert(bglevel)

    levelbtn1=display.newImage("images/bg/levelbtn.png")
    levelbtn1.x=screenLeft+100
    levelbtn1.y=60
    sceneGroup:insert(levelbtn1)

    levelbtn2=display.newImage("images/bg/levelbtn.png")
    levelbtn2.x=screenLeft+200
    levelbtn2.y=60
    sceneGroup:insert(levelbtn2)

    levelbtn3=display.newImage("images/bg/levelbtn.png")
    levelbtn3.x=screenLeft+300
    levelbtn3.y=60
    sceneGroup:insert(levelbtn3)

    levelbtn4=display.newImage("images/bg/levelbtn.png")
    levelbtn4.x=screenLeft+400
    levelbtn4.y=60
    sceneGroup:insert(levelbtn4)

    levelbtn5=display.newImage("images/bg/levelbtn.png")
    levelbtn5.x=screenLeft+500
    levelbtn5.y=60
    sceneGroup:insert(levelbtn5)

    levelbtn6=display.newImage("images/bg/levelbtn.png")
    levelbtn6.x=screenLeft+100
    levelbtn6.y=150
    sceneGroup:insert(levelbtn6)

    levelbtn7=display.newImage("images/bg/levelbtn.png")
    levelbtn7.x=screenLeft+200
    levelbtn7.y=150
    sceneGroup:insert(levelbtn7)

    levelbtn8=display.newImage("images/bg/levelbtn.png")
    levelbtn8.x=screenLeft+300
    levelbtn8.y=150
    sceneGroup:insert(levelbtn8)

    levelbtn9=display.newImage("images/bg/levelbtn.png")
    levelbtn9.x=screenLeft+400
    levelbtn9.y=150
    sceneGroup:insert(levelbtn9)





----------------------------------------------------------------------------------------------------------------

    leveltxt1=display.newText( "1",0,0,"Helvetica",50 )
    leveltxt1.x=screenLeft+97
    leveltxt1.y=55
    leveltxt1:setFillColor( 144,72,156)
    sceneGroup:insert(leveltxt1)

    leveltxt2=display.newText( "2",0,0,"Helvetica",50 )
    leveltxt2.x=screenLeft+197
    leveltxt2.y=55
    leveltxt2:setFillColor( 144,72,156)
    sceneGroup:insert(leveltxt2)

    leveltxt3=display.newText( "3",0,0,"Helvetica",50 )
    leveltxt3.x=screenLeft+297
    leveltxt3.y=55
    leveltxt3:setFillColor( 144,72,156)
    sceneGroup:insert(leveltxt3)

    leveltxt4=display.newText( "4",0,0,"Helvetica",50 )
    leveltxt4.x=screenLeft+397
    leveltxt4.y=55
    leveltxt4:setFillColor( 144,72,156)
    sceneGroup:insert(leveltxt4)

    leveltxt5=display.newText( "5",0,0,"Helvetica",50 )
    leveltxt5.x=screenLeft+497
    leveltxt5.y=55
    leveltxt5:setFillColor( 144,72,156)
    sceneGroup:insert(leveltxt5)


    leveltxt6=display.newText( "6",0,0,"Helvetica",50 )
    leveltxt6.x=screenLeft+97
    leveltxt6.y=145
    leveltxt6:setFillColor( 144,72,156)
    sceneGroup:insert(leveltxt6)

    leveltxt7=display.newText( "7",0,0,"Helvetica",50 )
    leveltxt7.x=screenLeft+197
    leveltxt7.y=145
    leveltxt7:setFillColor( 144,72,156)
    sceneGroup:insert(leveltxt7)

    leveltxt8=display.newText( "8",0,0,"Helvetica",50 )
    leveltxt8.x=screenLeft+297
    leveltxt8.y=145
    leveltxt8:setFillColor( 144,72,156)
    sceneGroup:insert(leveltxt8)

    leveltxt9=display.newText( "9",0,0,"Helvetica",50 )
    leveltxt9.x=screenLeft+397
    leveltxt9.y=145
    leveltxt9:setFillColor( 144,72,156)
    sceneGroup:insert(leveltxt9)




end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

      --  adsIntersEvent()
        adsBannerEvent()
        adsIntersEvent()
        levelbtn1:addEventListener('tap',gotolevel1)
        levelbtn2:addEventListener('tap',gotolevel2)
        levelbtn3:addEventListener('tap',gotolevel3)
        levelbtn4:addEventListener('tap',gotolevel4)
        levelbtn5:addEventListener('tap',gotolevel5)
        levelbtn6:addEventListener('tap',gotolevel6)
        levelbtn7:addEventListener('tap',gotolevel7)
        levelbtn8:addEventListener('tap',gotolevel8)
        levelbtn9:addEventListener('tap',gotolevel9)

    end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
