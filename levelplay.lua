------level test

local composer = require( "composer" )

local scene = composer.newScene()

local widget = require( "widget" )
local physics=require ("physics")
physics:start()
--physics.setDrawMode( "hybrid" )


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

------------------------------set preffered function and variable---------------------------
---------------

local flymon
local flymonsprite
local flybackup
local flybackdown
local randomtime
local timer
local scoreTxt
local score=0
local scoreNum
local coin=nil
local groundrect
local toprect
local rightrect
local leftrect
local enemy1
local enemy2
local onCollision
local left
local right
local up
local down
local gameListeners
local jump
local replayfun
local isaudioOn=false
local jumpSndFun
local coinSndFun
--local stop=true
--local spike

---------------------------
-----group declare---------------------------------------------
local backgroup
local maingroup
local enemygroup
isBannerShow = true

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



-------------------------------


------audio effects comes here

local coinsnd=audio.loadSound(  "audio/grabcoin.wav"  )
local jumpsnd = audio.loadSound(  "audio/spin.mp3"  )
local gameoversnd=audio.loadSound( "audio/wrong-move.wav" )



local function createGameScreen()
    -- pretty background------------
    local bg = display.newImage(backgroup,"images/bg/bgvel.png")
    bg.x = centerX
    bg.y = centerY
    bg.width = screenWidth
    bg.height = screenHeight
    -----------------------------------------------------------------
    --sprite image sheets----- goes here---------------------
    options={width=39,height=43,numFrames=4}
    imageSheet=graphics.newImageSheet("fms40.png" ,  options )
    sequenceData={{name="rightfly",start=1,count=2,time=800,loopDirection="bounce"},
      {name="leftfly",start=3,count=2,time=600,loopDirection="bounce"}}
    flymonsprite=display.newSprite( imageSheet, sequenceData )
    flymonsprite.x=centerX-150
    flymonsprite.y=centerY
    flymonsprite.width=40
    flymonsprite.height=40
  --  physics.addBody(flymonsprite,{radious=25})
    flymonsprite:setSequence("rightfly")
    flymonsprite:play()
    --------------------------------------------------------------------------------------------------------------
    spike=display.newImage( enemygroup,"images/spikesfull2.png")
    spike.x=centerX
    spike.y=centerY
    spike.width=screenWidth
    spike.height=screenHeight
    spike:toFront()
  --  physics.addBody(spike,"static")
    ------------------------------------------------------------------------------------------------------------------------
    -------------------------spike

    spike1=display.newImage(enemygroup,"images/spik/1spike.png")
    spike2=display.newImage(enemygroup,"images/spik/2spike.png")
    spike11=display.newImage(enemygroup,"images/spik/1spike.png")
    spike22=display.newImage(enemygroup,"images/spik/2spike.png")

    spike21=spike2
    spike221=spike22

    spike1.x=screenLeft+26
    spike1.y=centerY
    spike1.xScale=2
    spike1.yScale=2
    spike1.rotation=180
  --  physics.addBody(spike,"static")


    spike2.x=screenLeft+26
    spike2.y=centerY+100
    spike2.xScale=2
    spike2.yScale=2
    ------------------------------------------------------

    spike11.x=screenRight-100
    spike11.y=centerY
    spike11.xScale=2
    spike11.yScale=2
    --  spike11.rotation=180


    spike22.x=screenRight-98
    spike22.y=centerY+100
    spike22.xScale=2
    spike22.yScale=2
    spike22.rotation=180



    -----------------------------------------------------------------------------------------------------

    groundblock = display.newRect(maingroup,screenLeft, screenBottom-31, screenWidth, 100)
    groundblock:setFillColor(124, 86, 0)
    groundblock.alpha=0
    groundblock1 = display.newRect(maingroup,screenLeft, screenBottom-20, screenWidth, 100)
    groundblock1:setFillColor(124, 86, 0)
    groundblock1.alpha=0
    physics.addBody (groundblock1, "static", { density=3.0, friction=0.5, bounce=0.3 } )
    -- --display.newRect( x, y, width, height )
    --
    topblock = display.newRect(maingroup,screenLeft, screenTop+18, screenWidth, 10)
    topblock:setFillColor(124, 86, 0)
    topblock.alpha=0
    -- physics.addBody (topblock, "static" )
    --topblock:addEventListener('collision', onCollision )
    -- --
    rightblock = display.newRect(maingroup,screenLeft+203, screenTop+50, screenWidth, 10)
    rightblock:setFillColor(124, 86, 0)
    rightblock.alpha=0
    rightblock.rotation=90
    -- physics.addBody (rightblock, "static", { density=3.0, friction=0.5, bounce=.5} )
    --
    leftblock = display.newRect(maingroup,screenLeft-274, screenTop+50, screenWidth, 10)
    leftblock:setFillColor(124, 86, 0)
    leftblock.alpha=0
    leftblock.rotation=90
    -- physics.addBody (leftblock, "static", { density=3.0, friction=0.5, bounce=.5} )
    ----------------------------------------------------------------------------------------
    ----move enemy1 up and down---------------------

      ---------------------------------------------------------------------------------------------------
      --------jump buttons-------------------------------------------------------------------------------------
      jrb = display.newImage(enemygroup,"images/buttons/right.png")
      jrb.width = 45
      jrb.height = 45
      jrb.id = "JRB"
      jrb.x = screenRight-19
      jrb.y = centerY+70
      --jrb:addEventListener("tap",jump)

    --left jump button ---------
      jlb = display.newImage(enemygroup,"images/buttons/left.png")
      jlb.width = 45
      jlb.height = 45
      jlb.id = "JLB"
      jlb.x = screenRight-68
      jlb.y = centerY+70
    --  jlb:addEventListener("tap",jump)
    -- --Up jump button ---------------

      jub = display.newImage(enemygroup,"images/buttons/up.png")
      jub.width = 45
      jub.height = 45
      jub.id = "JUB"
      jub.x = screenRight-44
      jub.y = centerY+20
  --    jub:addEventListener("tap",jump)
    --
    --   -- move down button ---------------------
    --
      jdb = display.newImage(enemygroup,"images/buttons/down.png")
      jdb.width = 45
      jdb.height = 45
      jdb.id = "JDB"
      jdb.x = screenRight-42
      jdb.y = centerY+118
      --jdb:addEventListener("tap",jump)
      ---------------------------------------------------------------------------------------------------------------------------------
      ------ score updating starts here-------------------------------------------------------
      local scoreTxt=display.newText( enemygroup,"Score:",0,0,"Helvetica",24 )
      scoreTxt.x=screenRight-40
      scoreTxt.y=screenTop+35
      scoreTxt:setFillColor( 144,72,156)

      scoreNum=display.newText( enemygroup,"0",0,0,"Helvetica",30 )
      scoreNum.x=screenRight-40
      scoreNum.y=screenTop+60
      scoreNum.alpha=.5

      -------------------------------------------------------------------------------------------------------
      ------------display instruction-------------------------------------------
      gameinstructions=display.newImage(backgroup,"images/bg/inst1.png")
      gameinstructions.x=centerX-70
      gameinstructions.y=screenTop+80
      gameinstructions.xScale=2
      gameinstructions.yScale=2
      gameinstructions.alpha=0
      transition.to( gameinstructions, {time=1000,alpha=1,xScale=1.2,yScale=1.2} )

      tapnplay=display.newImage(backgroup,"images/bg/inst2.png")
      tapnplay.x=centerX-40
      tapnplay.y=screenBottom-90
      tapnplay.xScale=2
      tapnplay.yScale=2
      tapnplay.alpha=0
      transition.to( tapnplay, {time=1000,alpha=1,xScale=1.2,yScale=1.2} )

      -- startflying=display.newImage("images/bg/startfly.png")
      -- startflying.x=centerX+240
      -- startflying.y= centerY

      -------------------------------------------------------------------------------------
      -----assign score value to zero--------------------------------------
      score=0

      Runtime:addEventListener( "tap", Startgame )


-----------------------------------------------------------------------------------------------------------
      --------------------audio functiom-----------------------------------------------------------------------
      function isaudioOnFun()
        isaudioOn=true
        display.remove( audiobtn )
        audiobtn1=display.newImage(enemygroup,"images/bg/audioOnBtn.png")
        audiobtn1.x=screenLeft+525
        audiobtn1.y=centerY-50

        return true
      end

      audiobtn=display.newImage(enemygroup,"images/bg/audioOffBtn.png")
      audiobtn.x=screenLeft+525
      audiobtn.y=centerY-50

      audiobtn:addEventListener('tap',isaudioOnFun)

      ---------------------------------------------------------------------------------------------------------
end
----------------------------------------------------------------------------------------------------------------------------
------------- other function starts here--------------------------------------------------------------------------------
function replayfun()
  composer.removeScene("replay1" )
  composer.gotoScene( "replay1")
end

---------------game listners--------------------------------------
function gameListeners(action)
  if(action=='add')then
    ---add game listeners----
    print("add")
    jrb:addEventListener("tap",jump)
    jlb:addEventListener("tap",jump)
    jub:addEventListener("tap",jump)
    jdb:addEventListener("tap",jump)
  elseif(action=='rmv')then
    --remove game listeners-----
    jrb:removeEventListener("tap",jump)
    jlb:removeEventListener("tap",jump)
    jub:removeEventListener("tap",jump)
    jdb:removeEventListener("tap",jump)
    print("no add")
  end
  return true
end
----------------------------------------------------------------------------------------------------------------------------------------
---------------audio listners--------------------------------------
function audioListeners(action)
  if(action=='add')then
    ---add audio listeners----
  else
    --remove audio listeners-----
  end
end
---------------------------------------------------------------------------------------------------------------------------------------

-- Rectangle-based collision detection------------------------------------------------
local function hasCollided( obj1, obj2 )
    if ( obj1 == nil ) then  -- Make sure the first object exists
        return false
    end
    if ( obj2 == nil ) then  -- Make sure the other object exists
        return false
    end
  --  if(stop)then
      left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
      right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
      up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
      down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax


    return (left or right) and (up or down)
end
----------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

function removeMon()
  -- flymonsprite.x=math.random(-30,300)
  -- flymonsprite.y=math.random(35, 250)
  flymonsprite.alpha=0
  local gameovertxt=display.newText(enemygroup, "gameover",0,0,"Helvetica",24 )
  gameovertxt.x=centerX
  gameovertxt.y=centerY
  gameListeners('rmv')
  Runtime:removeEventListener( "enterFrame", die )
  Runtime:removeEventListener( "enterFrame", coinLoop )
  display.remove( flymonsprite )
  replayfun()
  --timer.performWithDelay(500, replayfun ,0)

  return true

end
-------------------------------------------------------------------------------------------



local function die( event )

      if(hasCollided( flymonsprite,enemy1))then
      --  display.remove(flymonsprite)
        removeMon()

      elseif(hasCollided(flymonsprite,enemy2))then
        removeMon()

      elseif(hasCollided(flymonsprite,topblock))then
        removeMon()

      elseif(hasCollided(flymonsprite,rightblock))then
        removeMon()

      elseif(hasCollided(flymonsprite,leftblock))then
        removeMon()

      elseif(hasCollided(flymonsprite,groundblock))then
        removeMon()
      elseif(hasCollided(flymonsprite,spike1))then
        removeMon()
      elseif(hasCollided(flymonsprite,spike2))then
        removeMon()
      elseif(hasCollided(flymonsprite,spike11))then
        removeMon()
      elseif(hasCollided(flymonsprite,spike22))then
        removeMon()



      end

  return true
end

-- Runtime:addEventListener( "enterFrame", die )
--------------------------------------------------------------------------------------------------------



----------coin generatecoin loop-------------------------------------------------------------
function generatecoin()
  coin=display.newImage(maingroup,"images/coin.png")
  coin.width=22
  coin.height=22
  coin.x= math.random(screenLeft+58,screenRight-130)
  coin.y=math.random(screenTop+40, screenTop+278)
  coin.name="coin"
end
function spikerand()
  -----single spikes-------------------------------------------------------------------------------------
  -- display.remove(spike1)
  -- display.remove(spike2)
  -- display.remove(spike11)
  -- display.remove(spike22)
  randnumber=math.random(3)
      if(randnumber==1)then

        spike1.y=centerY-(math.random(100, 1000)/10)
        spike2.y=centerY+(math.random(100, 1000)/10)
        spike11.y=centerY+(math.random(100, 1000)/10)
        spike22.y=centerY-(math.random(100, 1000)/10)
      elseif(randnumber==2)then
        spike1.y=centerY+(math.random(100, 1000)/10)
        spike2.y=centerY-(math.random(100, 1000)/10)
        spike11.y=centerY-(math.random(100, 1000)/10)
        spike22.y=centerY+(math.random(100, 1000)/10)
      -- elseif(randnumber==3)then
      --   spike21.y=centerY-math.random(1, 100)
      --   spike2.y=centerY+math.random(1, 100)
      --   spike221.y=centerY+math.random(1, 100)
      --   spike22.y=centerY-math.random(1, 100)
      end

end

function jumpSndFun()
  if (isaudioOn==true)then
      audio.play( jumpsnd )
  end
end

function coinSndFun()
  if (isaudioOn==true)then
      audio.play( coinsnd )
  end
end

local function coinLoop( event )
--    for i = 1,table.maxn( coins ) do

        if ( hasCollided( flymonsprite, coin) ) then
            display.remove(coin)
            generatecoin()
          --  audio.play( coinsnd )
            coinSndFun()
            score=score+1
            scoreNum.text =tostring( score )
            spikerand()
        end
    return true
end

-- Runtime:addEventListener( "enterFrame", coinLoop )

-------------------------------------------------------------------------------------------------------
---------jump function starts here-------------------------------------------------------------
function jump(event)
  		local tid = event.target.id
  --    print(event.target.id)
      if(tid=="JRB")then
        flymonsprite:setSequence("rightfly")
        flymonsprite:play()
        --audio.play( jumpsnd )
        jumpSndFun()
			  flymonsprite:setLinearVelocity(40,-180)
      -- print(tid)

		  elseif(tid=="JLB")then
        flymonsprite:setSequence("leftfly")
        flymonsprite:play()
      --    audio.play( jumpsnd )
       jumpSndFun()
			 flymonsprite:setLinearVelocity(-40,-180)
        -- print(tid)

      elseif(tid=="JUB")then
        flymonsprite:setSequence("leftfly")
        flymonsprite:play()
      --  audio.play( jumpsnd )
       jumpSndFun()
			  flymonsprite:setLinearVelocity(0,-180)
          -- print(tid)
      elseif(tid=="JDB")then
        flymonsprite:setSequence("rightfly")
        flymonsprite:play()
    --    audio.play( jumpsnd )
           jumpSndFun()
        flymonsprite:setLinearVelocity(0,100)
		  end
    return true
end


-------------------------------------------------------------------------------------------------
-----------enemy2------------------------------------------------------------------------------------------
function randomtime()
 randnum=math.random(3)
    if(randnum==1)then
      timer=2000
    elseif(randnum==2)then
      timer=4500
    elseif(randnum==3)then
      timer=3000
    end

end

function flybackdown(obj)
  transition.to( obj, {time=timer  ,y=screenBottom-52,rotation=720, onComplete=flybackup } )
--  transition.to( obj, {time=4000  ,rotation=720} )
randomtime()
--print("down")
end
function flybackup(obj)
--  print("flyback up there")
--  transition.to( obj, {time=4000,y=60} )
  transition.to( obj, {time=timer,y=60  ,rotation=720,onComplete=flybackdown} )
  randomtime()
end

-- enemy1=display.newImage("images/enemy/enemy1.png")
-- enemy1.x=screenLeft+150
-- enemy1.y=60
-- enemy1.width=40
-- enemy1.height=40
--  physics.addBody( enemy1, "static", { friction=0.3, isSensor=true } )

-- enemy2=display.newImage("images/enemy/enemy1.png")
-- enemy2.x=screenRight-220
-- enemy2.y=screenBottom-52
-- enemy2.width=40
-- enemy2.height=40

transition.to( enemy2, {delay=3000,time=4000  ,y=screenBottom-52, onComplete=flybackup } )
transition.to( enemy1, {time=4000  ,y=screenBottom-52, onComplete=flybackup } )


------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------
function Startgame()
  print("tapped")
  -----------remove items from create screen----------------------audiobtn:addEventListener('tap',isaudioOnFun)

--  audiobtn:removeEventListener('tap',isaudioOnFun)
  Runtime:removeEventListener( "tap", Startgame )
  display.remove(audiobtn)
  display.remove(audiobtn1)
  display.remove( gameinstructions )
  display.remove( tapnplay )
  ----------------------------------------------------------------
  -----add physics to game--------------------------------------------
  physics.addBody(flymonsprite,{radious=25})
  -- physics.addBody (topblock, {"static"} )
  physics.addBody (rightblock, "static", { density=3.0, friction=0.5, bounce=.5} )
  physics.addBody (leftblock, "static", { density=3.0, friction=0.5, bounce=.5} )
  ----------------------------------------------------------------------------
  gameListeners('add')
  generatecoin()
  -- enemy1=display.newImage("images/enemy/enemy1.png")
  -- enemy1.x=screenLeft+150
  -- enemy1.y=60
  -- enemy1.width=40
  -- enemy1.height=40

  -- enemy2=display.newImage("images/enemy/enemy1.png")
  -- enemy2.x=screenRight-220
  -- enemy2.y=screenBottom-52
  -- enemy2.width=40
  -- enemy2.height=40

  -- transition.to( enemy2, {delay=3000,time=4000  ,y=screenBottom-52, onComplete=flybackup } )
  -- transition.to( enemy1, {time=4000  ,y=screenBottom-52, onComplete=flybackup } )
  ----------------------------------------------------------------------------

end
-------------------------------------------------------------------

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    backgroup=display.newGroup()
    sceneGroup:insert(backgroup)

    maingroup=display.newGroup()
    sceneGroup:insert(maingroup)

    enemygroup=display.newGroup()
    sceneGroup:insert(enemygroup)



end


-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        createGameScreen()
        adsBanner.hide()
        Runtime:addEventListener( "enterFrame", die )
        Runtime:addEventListener( "enterFrame", coinLoop )

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
        Runtime:removeEventListener( "enterFrame", die )
        Runtime:removeEventListener( "enterFrame", coinLoop )
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
