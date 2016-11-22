--load.lua


local composer = require( "composer" )

local scene = composer.newScene()
--------------------------------------------------



centerX = display.contentCenterX
centerY = display.contentCenterY
screenLeft = display.screenOriginX
screenWidth = display.contentWidth - screenLeft * 2
screenRight = screenLeft + screenWidth
screenTop = display.screenOriginY
screenHeight = display.contentHeight - screenTop * 2
screenBottom = screenTop + screenHeight
display.contentWidth = screenWidth
display.contentHeight = screenHeight


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function gotomenu()
 composer.gotoScene( "menu")
end



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    local bgwhite= display.newImage("images/bg/bgwhite.png")
    bgwhite.x = centerX
    bgwhite.y = centerY
    bgwhite.width = screenWidth
    bgwhite.height = screenHeight
    sceneGroup:insert(bgwhite)

    local loadmoon=display.newImage("images/bg/loadmoon.png")
    loadmoon.y=centerY
    loadmoon.alpha=0
    loadmoon.x=-300
    sceneGroup:insert(loadmoon)

    local loadlogo=display.newImage("images/bg/loadlogo.png")
    loadlogo.x=centerX
    loadlogo.y=centerY+100
    sceneGroup:insert(loadlogo)

    transition.to( loadmoon,{time=4000, x=centerX-82,alpha=1,rotation=360,onComplete=gotomenu} )
    transition.to(loadlogo,{time=3000,y=centerY})



end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen

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
