local tick = require 'tick'
--love._openConsole()
window_w=1280
window_h=720
score=0
health=3
invincible=false
ralph=false
Ennemy={}
Packages={}
Packages2={}
Bombs={}
Bombs2={}
Bullets={}
explosions={}
NBullet=10
startPosX=window_h/2
startPosY=720-(10+45)
function explosion1(x,y)
    explosions[#explosions+1] =
    {
        xe=x,
        ye=y
    }
end
Package2=
{
    file="Sprites/PackageGUN.png",
    zindex=2,
    speed,
    width=50,
    height=50
}
Package=
{
    file="Sprites/Package.png",
    zindex=2,
    speed,
    width=50,
    height=50
}
Bomb=
{
    file="Sprites/Bomb.png",
    zindex=2,
    speed,
    width=50,
    height=50
}
Plane=
{
    file="Sprites/Plane.png",
    zindex=2,
    x=0,
    y=0,
    speed,
    width=50,
    height=50
}
Plane2=
{
    file="Sprites/Plane.png",
    zindex=2,
    x=1280,
    y=0,
    speed,
    width=50,
    height=50
}
ButtonBack=
{
    file="UI/Back_Button.png",
    zindex=1,
    x=10,
    y=10,
    width=70,
    height=50
}
ButtonExit=
{
    file="UI/Exit_Button.png",
    zindex=1,
    x=(window_w/2)-200/2,
    y=(window_h/2)-100,
    width=200,
    height=50
}
ButtonRestart=
{
    file="UI/Restart.png",
    zindex=1,
    x=(window_w/2)-200/2,
    y=(window_h/2)-100,
    width=200,
    height=50
}
ButtonRalph=
{
    file="UI/Ralph_Button.png",
    zindex=1,
    x=(400)-200/2,
    y=(window_h/2)-100,
    width=200,
    height=50
}
ButtonOptions=
{
    file="UI/Option_Button.png",
    zindex=1,
    x=(window_w/2)-200/2,
    y=(window_h/2)-160,
    width=200,
    height=50
}
ButtonPlay=
{
    file="UI/Play_Button.png",
    zindex=1,
    x=(window_w/2)-200/2,
    y=(window_h/2)-220,
    width=200,
    height=50
}
MenuBackground=
{
    file="BackGrounds/Menu_background.png",
    zindex=1,
    x=0,
    y=0
}
background=
{
    file="BackGrounds/Gaza_Background.png",
    zindex=1,
    x=0,
    y=0
}
player=
{
    G1="Sprites/Gauche1.png",
    G2="Sprites/Gauche2.png",
    D1="Sprites/Droite1.png",
    D2="Sprites/Droite2.png",
    x=startPosX,
    y=startPosY,
    width=35,
    height=45,
    zindex=3,
    speed,
    direction=0,
    jumping=false,
    jumpingspeed=15,
}
function love.load()

    if menu=="loose" then
        love.audio.pause()
    end
    local img = love.graphics.newImage("Sprites/index.png")
    pSystem = love.graphics.newParticleSystem(img, 16)
    pSystem:setParticleLifetime(1,1)
    pSystem:setLinearAcceleration(-50, -50, 50, 50)
    pSystem:setSpeed(50)
    pSystem:setSpin(20, 40)

    menumusic =love.audio.newSource("Music/menu.mp3", "stream")
    ralphmusic=love.audio.newSource("Music/ralph.mp3", "stream")
    gamemusic=love.audio.newSource("Music/game.mp3", "stream")

    ralphS=love.graphics.newImage("Sprites/Ralph.png")
    FelixS=love.graphics.newImage("Sprites/Felix.png")
    RalphBackground=love.graphics.newImage("BackGrounds/Raplh_Background.png")
    Brick=love.graphics.newImage("Sprites/Ralph_Bomb.png")

    explosion = love.audio.newSource("SFX/explosion.wav","static")
    Hurt = love.audio.newSource("SFX/hitHurt.wav","static")
    jump = love.audio.newSource("SFX/jump.wav","static")
    lasershoot = love.audio.newSource("SFX/laserShoot.wav","static")

    tick.framerate = 60
    playerG1=love.graphics.newImage(player.G1)
    playerG2=love.graphics.newImage(player.G2)
    playerD1=love.graphics.newImage(player.D1)
    playerD2=love.graphics.newImage(player.D2)

    EG1=love.graphics.newImage("Sprites/Gauche1_E.png")
    EG2=love.graphics.newImage("Sprites/Gauche2_E.png")
    ED1=love.graphics.newImage("Sprites/Droite1_E.png")
    ED2=love.graphics.newImage("Sprites/Droite2_E.png")

    DPlane=love.graphics.newImage(Plane.file)
    DPlane2=love.graphics.newImage(Plane2.file)
    DBomb=love.graphics.newImage(Bomb.file)
    DPackage=love.graphics.newImage(Package.file)
    DPackage2=love.graphics.newImage(Package2.file)

    DbackgroundOption=love.graphics.newImage("BackGrounds/Gaza_Menu_1.png")
    Dbackground=love.graphics.newImage(background.file)
    DbackgroundMenu=love.graphics.newImage(MenuBackground.file)
    DGameOve=love.graphics.newImage("BackGrounds/GameOve.png")

    DButtonPlay=love.graphics.newImage(ButtonPlay.file)
    DButtonOption=love.graphics.newImage(ButtonOptions.file)
    DButtonExit=love.graphics.newImage(ButtonExit.file)
    DButtonBack=love.graphics.newImage(ButtonBack.file)
    DButtonRalph=love.graphics.newImage(ButtonRalph.file)
    DButtonRestart=love.graphics.newImage(ButtonRestart.file)

    love.window.setTitle("GAZA WAR SIMULATOR!")
    love.window.setMode(window_w,window_h,
    {
        resizable=false,
        vsync=0,
        fullscreentype="exclusive",
        fullscreen="true"
        
    }
    )
    menu="menu"
end
full=true
function love.keypressed(key, scancode, isrepeat)
	if key == "f" then
		if full==true then
            love.window.setFullscreen(false, "exclusive")
            full=false
        else
            love.window.setFullscreen(false, "exclusive")
            full=true
        end
		love.window.setFullscreen(fullscreen, "exclusive")
	end
end

timeBomb=0
lastBomb=nil
lastBomb2=nil
lastPackage=nil
alreadyPackage=false
lastPackage2=nil
alreadyPackage2=false
random=nil
random2=nil
lastEnnemy=nil
ESide=1
debounce=true
debounceReady=false
function MakeRandom(time)
    intervallePackage=math.random(1200,4000)
    return intervallePackage
end
function MakeRandom2(time)
    intervallePackage=math.random(700,2000)
    return intervallePackage
end
intervalleBomb=120
function love.keypressed(key)
    if debounce==true then
        debounce=true
        if key=="space" then
            if NBullet > 0 then
                if player.direction==2 then
                    Bullets[#Bullets+1] = {
                        y= player.y+25,
                        x = (player.x + player.width/2),
                        d=14
                        }
                        NBullet=NBullet-1
                        love.audio.play(lasershoot)
                else
                    love.audio.play(lasershoot)
                    Bullets[#Bullets+1] = {
                        y= player.y+25,
                        x = (player.x + player.width/2),
                        d=-14
                        }
                        NBullet=NBullet-1
                end
            end
        end
        if debounceReady==true then
            debounceReady=false
            debounce=true
        end
    end
    if key=="up" then
        if player.jumping==false then
            love.audio.play(jump)
            player.jumping=true
        end        
    end
    if key=="g" then
        print(#Ennemy.." Ennemy")
        print(#Bullets.." Bullets")
        print(#Bombs.." Bombs")
        print(intervalleBomb.." IntervalleBomb")
        print(timeBomb.." TimeBombs")
    end
end
Jumptime=0
ReachedTop=false
function love.update(dt)
    pSystem:update(dt)

    player.speed=10
    Plane2.speed=5
    Plane.speed=5
    Bomb.speed=5
    Package.speed=2
    Package2.speed=2

    if player.jumping==true then
        
        if ReachedTop==false then
            if Jumptime>
            10 then
                ReachedTop=true
                Jumptime=Jumptime-1
            else
                player.y=player.y-(player.jumpingspeed-Jumptime)
                Jumptime=Jumptime+1
            end
        else
            if Jumptime <0 then
                Jumptime=0
                ReachedTop=false
                player.jumping=false
            else
                player.y=player.y+(player.jumpingspeed-Jumptime)
                Jumptime=Jumptime-1
            end    
        end
    end
    local mx=love.mouse.getX()
    local my=love.mouse.getY()
    if score<=1000 then
        intervalleBomb=85
    elseif score>=1000 and score<=2000 then
        intervalleBomb=75
    elseif score>=2000 and score<=4000 then
        intervalleBomb=70
    elseif score>=4000 and score<=8000 then
        intervalleBomb=60
    elseif score>=8000 and score<=16000 then
        intervalleBomb=50
    elseif score>=16000 and score<=24000 then
        intervalleBomb=45
    elseif score>=24000 and score<=28000 then
        intervalleBomb=40
    elseif score>=28000 and score<=30000 then
        intervalleBomb=30
    elseif score>=30000 then
        intervalleBomb=20
    end
    if menu=="game" then   
        love.audio.pause()
        if ralph==false then
            love.audio.play(gamemusic)
        else
            love.audio.play(ralphmusic)
        end     
        if Plane.x+(Plane.speed)>=window_w then
            Plane.x=-50
        else
            Plane.x=Plane.x+(Plane.speed)
        end
        if score>=5000 then
            if Plane2.x-(Plane2.speed)<=-50 then
                Plane2.x=1280
            else
                Plane2.x=Plane2.x-(Plane2.speed)
            end
        end
          if #Bombs ~= 0 then
            for i,v in ipairs(Bombs) do
                v.y=v.y+Bomb.speed
                if (v.y >= player.y and v.y <= player.y+50) then
                    if(v.x+50>=player.x or v.x>=player.x)and(v.x <= player.x+50) then
                      if invincible==false then
                        if health-1<=0 then
                            menu="loose"
                        else
                            invincible=true
                            health=health-1
                            love.audio.play(Hurt)
                            explosion1(v.x,v.y)
                            pSystem:emit(32)
                        end          
                        table.remove(Bombs,1)
                      end
                    end
                end
                if v.y+Bomb.speed>= 710 then
                    love.audio.play(explosion)
                    pSystem:emit(32)
                    explosion1(v.x,v.y)
                    table.remove(Bombs,1)
                end
            end
            if #Bombs2 ~= 0 then
                for i,v in ipairs(Bombs2) do
                    v.y=v.y+Bomb.speed
                    if (v.y >= player.y and v.y <= player.y+50) then
                        if(v.x+50>=player.x or v.x>=player.x)and(v.x <= player.x+50) then
                          if invincible==false then
                            if health-1<=0 then
                                menu="loose"
                            else
                                invincible=true
                                health=health-1
                                love.audio.play(Hurt)
                                explosion1(v.x,v.y)
                                pSystem:emit(32)
                            end          
                            table.remove(Bombs2,1)
                          end
                        end
                    end
                    if v.y+Bomb.speed>= 710 then
                        love.audio.play(explosion)
                        pSystem:emit(32)
                        explosion1(v.x,v.y)
                        table.remove(Bombs2,1)
                    end
                end
            end
            if #Bullets ~= 0 then
                for i,v in ipairs(Bullets) do
                    v.x=v.x+v.d
                    for iE,vE in ipairs(Ennemy) do
                        if v.x>=vE.x and v.x <=vE.x+50 then
                            table.remove(Ennemy,iE)
                            table.remove(Bullets,i)
                            score=score+100
                        end
                    end
                    if v.x>=1280 or v.x <=0 then
                        table.remove(Bullets,1)
                    end
                end
            end
            if #Packages ~= 0 then
                for i,v in ipairs(Packages) do
                    if v.y+Package.speed>= 710 then
                        table.remove(Packages,1)
                    else
                        v.y=v.y+Package.speed
                    end
                    if (v.y >= player.y and v.y <= player.y+50) then
                        if(v.x+50>=player.x or v.x>=player.x)and(v.x <= player.x+50) then
                            if health+1<=6 then
                                health=health+1
                            end
                            table.remove(Packages,1)
                          end
                        end
                    end
                end
            end
            if #Packages2 ~= 0 then
                for i,v in ipairs(Packages2) do
                    if v.y+Package2.speed>= 710 then
                        table.remove(Packages2,1)
                    else
                        v.y=v.y+Package2.speed
                    end
                    if (v.y >= player.y and v.y <= player.y+50) then
                        if(v.x+50>=player.x or v.x>=player.x)and(v.x <= player.x+50) then
                            NBullet=NBullet+15
                            table.remove(Packages2,1)
                        end
                    end
                end
            end
            if #Ennemy ~= 0 then
                for i,v in ipairs(Ennemy) do
                    if v.x>=1280 or v.x<=-50 then
                        table.remove(Ennemy,1)
                    else
                        v.x=v.x+v.d
                    end
                    if (v.y >= player.y and v.y <= player.y+50) then
                        if(v.x+50>=player.x or v.x>=player.x)and(v.x <= player.x+50) then
                            if invincible==false then
                                if health-1<=0 then
                                    menu="loose"
                                else
                                    invincible=true
                                    health=health-1
                                    love.audio.play(Hurt)
                                end      
                                table.remove(Bombs2,1)
                            end
                        end
                    end
                end
            end
        if lastEnnemy==nil then
            if timeBomb==intervalleBomb*2 then
                lastEnnemy=timeBomb
                Eside=2
                Ennemy[#Ennemy+1] = {
                    y= startPosY,
                    x = -49,
                    d=8
                    }
            end
        elseif timeBomb>=lastEnnemy+intervalleBomb*2 then
            lastEnnemy=timeBomb
            print("Ennemy")
            if Eside==1 then
                Eside=2
                Ennemy[#Ennemy+1] = {
                    y= startPosY,
                    x = -49,
                    d=8
                    }
            elseif Eside==2 then
                Eside=1
                Ennemy[#Ennemy+1] = {
                    y= startPosY,
                    x = 1279,
                    d=-8
                    }
            end
        end
        if lastBomb==nil then     
            if timeBomb==intervalleBomb then
                lastBomb=timeBomb
                Bombs[#Bombs+1] = {
                    y= Plane.y,
                    x = (Plane.x + Plane.width/2),
                    e=false
                    }
            end
        else
            if timeBomb>=lastBomb+intervalleBomb then
                print("Bomb1")
                lastBomb=timeBomb
                Bombs[#Bombs+1] = {
                    y= Plane.y,
                    x = (Plane.x + Plane.width/2),
                    e=false
                    }
            end
        end
        if score>=5000 then
            if lastBomb2==nil then   
                 lastBomb2=timeBomb
                 Bombs2[#Bombs2+1] = {
                     y= Plane2.y,
                     x = (Plane2.x + Plane2.width/2),
                     e=false
                     }
            else
                if timeBomb>=lastBomb2+intervalleBomb then
                    print("Bomb2")
                    lastBomb2=timeBomb
                    Bombs2[#Bombs2+1] = {
                        y= Plane2.y,
                        x = (Plane2.x + Plane2.width/2),
                        e=false
                        }
                end
            end
        end      
        if alreadyPackage==false then
            alreadyPackage=true
            if lastPackage==nil then
                alreadyPackage=false
                lastPackage=timeBomb
                random=MakeRandom(time)
            else
                if timeBomb==lastPackage+random then
                    alreadyPackage=false
                    lastPackage=timeBomb
                    random=MakeRandom(time)
                    Packages[#Packages+1] = {
                        y= Plane.y,
                        x = math.random(80,1200)
                        }
                else
                    alreadyPackage=false
                end
            end
        end
        if alreadyPackage2==false then
            alreadyPackage2=true
            if lastPackage2==nil then
                alreadyPackage2=false
                lastPackage2=timeBomb
                random2=MakeRandom2(time)
                print(random2)
            else
                if timeBomb==lastPackage2+random2 then
                    alreadyPackage2=false
                    lastPackage2=timeBomb
                    random2=MakeRandom2(time)
                    Packages2[#Packages2+1] = {
                        y= Plane.y,
                        x = math.random(80,1200)
                        }
                else
                    alreadyPackage2=false
                end
            end
        end
        if love.keyboard.isDown("right") then
            if player.x>=1280-50 then
                player.x=player.x-player.speed
            else
                player.x=player.x+player.speed
            end
            player.direction=2
        elseif love.keyboard.isDown("left") then
            if player.x<=0 then
                player.x=player.x+player.speed
            else
                player.x=player.x-player.speed
            end
            player.direction=1
        end
        timeBomb=timeBomb+1 
    else 
        click=true
        if menu=="menu" then
            love.audio.play(menumusic)
        end
        
        if love.mouse.isDown(1) then
            if click==true then
                click=falsex
                if (mx>=ButtonPlay.x and mx<=(ButtonPlay.x+ButtonPlay.width))and (my>=ButtonPlay.y and my<=(ButtonPlay.y+ButtonPlay.height)) and menu=="menu"then
                    menu="game"
                elseif (mx>=ButtonOptions.x and mx<=(ButtonOptions.x+ButtonOptions.width))and (my>=ButtonOptions.y and my<=(ButtonOptions.y+ButtonOptions.height)) and menu=="menu"then
                    menu="option"
                elseif (mx>=ButtonExit.x and mx<=(ButtonExit.x+ButtonExit.width))and (my>=ButtonExit.y and my<=(ButtonExit.y+ButtonExit.height)) and menu=="menu" then
                    love.window.close()
                elseif (mx>=ButtonBack.x and mx<=(ButtonBack.x+ButtonBack.width))and (my>=ButtonBack.y and my<=(ButtonBack.y+ButtonBack.height)) and menu=="option" then
                    menu="menu"
                elseif (mx>=ButtonRalph.x and mx<=(ButtonRalph.x+ButtonRalph.width))and (my>=ButtonRalph.y and my<=(ButtonRalph.y+ButtonRalph.height)) and menu=="option" then
                    if ralph==false then
                        ralph=true
                    else
                        ralph=false
                    end      
                    menu="menu" 
                elseif (mx>=ButtonRestart.x and mx<=(ButtonRestart.x+ButtonRestart.width))and (my>=ButtonRestart.y and my<=(ButtonRestart.y+ButtonRestart.height)) and menu=="loose" then
                    love.event.quit( "restart" )   

                end
                click=true
            end
        end
    end
end

frame=0
numberofsec=0
framesince=0
Invsince=0
since=0
since2=0
already=false
lastx=player.x
moved=false
function love.draw()
     if menu=="game" then


        Invsince=Invsince+1
        frame=frame+1
        if ralph==true then
            love.graphics.draw(RalphBackground,background.x,background.y)
            love.graphics.draw(ralphS,Plane.x,Plane.y)
            love.graphics.draw(ralphS,Plane2.x,Plane2.y)
            love.graphics.print("Score: "..score.." | Vie: "..health.." | Balles: "..NBullet,0,0)
            if moved~=true then
                love.graphics.draw(FelixS,startPosX,startPosY)
            end         
        else
            love.graphics.draw(Dbackground,background.x,background.y)
            love.graphics.draw(DPlane,Plane.x,Plane.y)
            love.graphics.draw(DPlane2,Plane2.x,Plane2.y)
            love.graphics.print("Score: "..score.." | Vie: "..health.." | Balles: "..NBullet,0,0)
            if moved~=true then
                love.graphics.draw(playerD1,startPosX,startPosY)   
            end        
        end
        if Invsince>=30 then
            for i,v in ipairs(Ennemy) do 
                if v.d==8 then
                    love.graphics.draw(ED1,v.x,v.y)
                elseif v.d==-8 then
                    love.graphics.draw(EG1,v.x,v.y)
                end
            end
        elseif Invsince<=30 then
            for i,v in ipairs(Ennemy) do 
                if v.d==8 then
                    love.graphics.draw(ED2,v.x,v.y)
                elseif v.d==-8 then
                    love.graphics.draw(EG2,v.x,v.y)
                end
            end
        end
        for i,v in ipairs(Bullets) do 
            love.graphics.rectangle("fill",v.x,v.y,2,2)
        end
        for i,v in ipairs(Packages) do 
            love.graphics.draw(DPackage,v.x,v.y)
        end
        for i,v in ipairs(Packages2) do 
            love.graphics.draw(DPackage2,v.x,v.y)
        end
        for i,v in ipairs(Bombs) do 
            if ralph==true then
                love.graphics.draw(Brick,v.x,v.y)
            else
                love.graphics.draw(DBomb,v.x,v.y)
            end
        end
        for i,v in ipairs(Bombs2) do 
            if ralph==true then
                love.graphics.draw(Brick,v.x,v.y)
            else
                love.graphics.draw(DBomb,v.x,v.y)
            end
        end
        if invincible==true then
            if already==false then
                already=true
                since=numberofsec
            end    
            if numberofsec-since==5 then
                already=false
                invincible=false
            end
            if not (Invsince >=0 and Invsince <=20)and(Invsince>=40 and Invsince <=60) then
                if ralph==true then
                    love.graphics.draw(FelixS,player.x,player.y)
                else
                    love.graphics.draw(playerG1,player.x,player.y)
                end
            end
        else
            if ralph==true then
                if player.x-lastx~=0 then
                    moved=true
                    if Invsince>=30 then
                        lastx=player.x
                        if player.direction==1 then
                            love.graphics.draw(FelixS,player.x,player.y)
                        elseif player.direction==2 then
                            love.graphics.draw(FelixS,player.x,player.y)
                        end
                    elseif Invsince<=30 then
                        if player.direction==1 then
                            love.graphics.draw(FelixS,player.x,player.y)
                        elseif player.direction==2 then
                            love.graphics.draw(FelixS,player.x,player.y)
                        end
                    end
                else
                    if player.direction==1 then
                        love.graphics.draw(FelixS,player.x,player.y)
                    elseif player.direction==2 then
                        love.graphics.draw(FelixS,player.x,player.y)
                    end 
                end
            else
                if player.x-lastx~=0 then
                    moved=true
                    if Invsince>=30 then
                        lastx=player.x
                        if player.direction==1 then
                            love.graphics.draw(playerG1,player.x,player.y)
                        elseif player.direction==2 then
                            love.graphics.draw(playerD1,player.x,player.y)
                        end
                    elseif Invsince<=30 then
                        if player.direction==1 then
                            love.graphics.draw(playerG2,player.x,player.y)
                        elseif player.direction==2 then
                            love.graphics.draw(playerD2,player.x,player.y)
                        end
                    end
                else
                    if player.direction==1 then
                        love.graphics.draw(playerG2,player.x,player.y)
                    elseif player.direction==2 then
                        love.graphics.draw(playerD2,player.x,player.y)
                    end 
                end
            end
        end
        for i,v in ipairs(explosions) do
            if not ralph then
                love.graphics.draw(pSystem,v.xe,v.ye)
                if frame-framesince==60 then
                    table.remove(explosions,i)
                end
            end
        end
    elseif menu=="menu" then
        love.graphics.draw(DbackgroundMenu,MenuBackground.x,MenuBackground.y)
        love.graphics.draw(DButtonExit,ButtonExit.x,ButtonExit.y)
        love.graphics.draw(DButtonOption,ButtonOptions.x,ButtonOptions.y)
        love.graphics.draw(DButtonPlay,ButtonPlay.x,ButtonPlay.y)
        love.graphics.print("UTILISER FLECHE GAUCHE ET DROITE POUR BOUGER, FLECHE DU HAUTE POUR SAUTE ET ESPACE POUR TIRER.",220,340,0,1,1)
    elseif menu=="option" then
        local bool
        if ralph==true then
            bool="true"
        else
            bool="false"
        end
        love.graphics.draw(DbackgroundOption,0,0)
        love.graphics.draw(DButtonBack,ButtonBack.x,ButtonBack.y)
        love.graphics.draw(DButtonRalph,ButtonRalph.x,ButtonRalph.y)
        love.graphics.print("Ralph Mode: "..bool,ButtonRalph.x+50,ButtonRalph.y+25,0,1.2,1.2)
    elseif menu=="loose" then
        love.graphics.draw(DGameOve,0,0)
        love.graphics.print("Final Score: "..score,window_h/2+50,600,0,2,2)
        love.graphics.draw(DButtonRestart,ButtonRestart.x,ButtonRestart.y)
    end
    if menu=="game" then
        if frame==60 then
            Invsince=0
            framesince=frame
            score=score+100
            numberofsec=numberofsec+1
        elseif frame-framesince==60 then
            Invsince=0
            framesince=frame
            score=score+100
            numberofsec=numberofsec+1
        end
    end
end