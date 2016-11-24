local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function adsBannerEvent1( event )
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


local function gotolevel()
  composer.removeScene( "levels")
 composer.gotoScene( "levels")

end
local play

-- -----------------------------------------------------------------------------------
-- Scene event functions 
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local bggreen=display.newImage("images/bg/bgwhite.png")
    bggreen.x = centerX
    bggreen.y = centerY
    bggreen.width = screenWidth
    bggreen.height = screenHeight
    sceneGroup:insert(bggreen)

    local title=display.newImage("images/bg/title1.png")
    title.x=centerX
    title.y=centerY-30
    sceneGroup:insert(title)

    play=display.newImage("images/bg/play.png")
    play.x=centerX
    play.y=centerY+115
    play.alpha=0
    play.xScale=2
    play.yScale=2
    sceneGroup:insert(play)

end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        adsBannerEvent1()
        play:addEventListener('tap',gotolevel)
        transition.to( play, {time=2000,xScale=1,yScale=1,alpha=1} )

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
