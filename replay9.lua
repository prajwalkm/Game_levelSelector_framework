local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
isBannerShow = false

local function adsBannerEvent( event )
--  if ( "ended" == event.phase ) then
      if ( isBannerShow == false ) then
          print( "Banner was pressed and released" )
      --    txtDebug.text = "show banner"
          adsBanner.show( "banner", { x=0, y=0, targetingOptions=targetingParams} )
          isBannerShow = true;
      else
      --    txtDebug.text = "hide banner"
          adsBanner.hide()
          isBannerShow = false
      end

--  end
end

local function gotolevels()
  composer.removeScene("levels")
  composer.gotoScene( "levels")
  return true
end

local function gotolevel9()
  composer.removeScene("level09")
  composer.gotoScene( "level09")
end


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    bglevel1=display.newImage("images/bg/bgwhite.png")
    bglevel1.x = centerX
    bglevel1.y = centerY
    bglevel1.width = screenWidth
    bglevel1.height = screenHeight
    sceneGroup:insert(bglevel1)

    replay=display.newImage("images/bg/replay.png")
    replay.x=centerX
    replay.y=centerY
    replay.alpha=0
    replay.xScale=2
    replay.yScale=2
    sceneGroup:insert(replay)

    levelstxt=display.newText( "Levels",0,0,"Helvetica",50 )
    levelstxt.x=centerX
    levelstxt.y=centerY-80
    levelstxt:setFillColor( 144,72,156)
    sceneGroup:insert(levelstxt)


end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        adsBannerEvent()
        transition.to( replay, {time=2000,xScale=1,yScale=1,alpha=1} )
        replay:addEventListener('tap',gotolevel9)
          levelstxt:addEventListener('tap',gotolevels)

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
