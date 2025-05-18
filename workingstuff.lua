function _init()
	init_player()

	
	--welcome()
	
	cx = 0
	cy = 0
	
	mx = 0
	my = 0
	
	walk = true
	
	pingpongminigame = false

    
-- paddle variables
paddle1_y = 60
paddle2_y = 60
paddle_h = 20

--scores
score1 = 0
score2 = 0
-- ball variables
ball_x = 64
ball_y = 64
ball_dx = 2
ball_dy = 1.5






mazegame = false

game_mode="maze"
maze = {
 -- 0 = ice, 1 = water, 2 = goal
  {0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,1,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,1},
  {1,1,0,1,0,1,1,1,0,1,0,1,1,1,0,1,0,1,0,1},
  {1,1,0,1,0,1,0,0,0,1,0,1,0,0,0,1,0,1,0,1},
  {1,1,0,1,0,1,0,1,1,1,0,1,0,1,1,1,0,1,0,1},
  {1,1,0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,1,0,1},
  {1,1,1,1,0,1,0,1,0,1,1,1,0,1,0,1,1,1,0,1},
  {1,1,1,1,0,0,0,1,0,1,0,0,0,1,0,1,0,0,0,1},
  {1,1,1,1,1,1,0,1,0,1,0,1,1,1,0,1,0,1,1,1},
  {1,1,1,1,1,1,0,1,0,0,0,1,0,0,0,1,0,0,0,1},
  {1,1,1,1,1,1,0,1,1,1,0,1,0,1,1,1,1,1,0,1},
  {1,1,1,1,1,1,0,0,0,1,0,1,0,1,0,0,0,1,0,1},
  {1,1,1,1,1,1,1,1,0,1,0,1,0,1,0,1,0,1,0,1},
  {1,1,1,1,1,1,1,1,0,0,0,0,0,1,0,1,0,0,0,0},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2}
}
timer=200
cell_size = 6
m_player = {x=1, y=1}








end







function _update()
	move_player()
	
	
	if walk == true then
	open_world()
	end
	
	
	--fox
	if t_x==160 and t_y==80 and t2_x==152 and t2_y==72 then
	mazegame = true
        walk = false
    cls()
    player.x=0
    player.y=0
    cx= 0
    cy=0
    end

	
	--test tube
	if t_x==136 and t_y==232 and t2_x==128 and t2_y==224 then
	walk = false
    cls()
    player.x=0
    player.y=0
    cx= 0
    cy=0
    underwater()
    --other gameee = true
	end
	
	--fish
	if t_x==40 and t_y==216 and t2_x==32 and t2_y==208 then
	walk = false
    cls()
    player.x=0
    player.y=0
    cx= 0
    cy=0
    underwater()
    --other gameee = true
	end
	
	--seal
	if t_x==48 and t_y==160 and t2_x==40 and t2_y==152 then
	walk = false
    cls()
    player.x=0
    player.y=0
    cx= 0
    cy=0
    pingpongminigame = true
    
	end

    if mazegame then
timer=timer-1
  
    if timer <=  0 then
    _update = function() end -- stop player movement
    _draw = function()
        cls(5)
        print("ヌう✽ outta time!", 50, 60, 11)
        walk = true
        mazegame = false
    end
    end
    
    local dx, dy = 0, 0
    if btn(⬅️) then dx = -1 end
    if btn(➡️) then dx = 1 end
    if btn(⬆️) then dy = -1 end
    if btn(⬇️) then dy = 1 end

    local nx = m_player.x + dx
    local ny = m_player.y + dy

  if nx >= 1 and nx <= 20 and ny >= 1 and ny <= 15 then
    local tile = maze[ny][nx]
    if tile == 0 then
      m_player.x = nx
      m_player.y = ny
    elseif tile == 2 then
      m_player.x = nx
      m_player.y = ny
      done()
    end
  end
end
end
    if pingpongminigame then
            -- for pingpong 
    --end
    if score1 == 10 then
        walk = true
    pingpongminigame=false
    
    
    cls(4)
    print("u won!seal lost. ")
    end 
    if score2 == 10 then
                walk = true
    pingpongminigame=false
    cls(4)
    print("seal won!you lost.")
    end ---chaange so thata back to open world 
    
    -- player paddle movement
    if btn(⬆️) then paddle1_y -= 2 end
    if btn(⬇️) then paddle1_y += 2 end
    paddle1_y = mid(0, paddle1_y, 128 - paddle_h)

    -- random dumb ai paddle movement
    if rnd(10) < 2.5  then
        paddle2_y += ball_y +  rnd(5)
   end
    if rnd(10) < 5  then
        paddle2_y += ball_y - rnd(5)
   end
    if rnd(10) > 6  then
        paddle2_y = ball_y + rnd(paddle_h)
    end
    -- ball movement
    ball_x += ball_dx
    ball_y += ball_dy

    -- bounce off top/bottom
    if ball_y < 0 or ball_y > 128 then
        ball_dy = -ball_dy
    end

    -- paddle hits
    if ball_x < 8 and ball_y > paddle1_y and ball_y < paddle1_y + paddle_h then
        ball_dx = abs(ball_dx)
    
    elseif ball_x > 120 and ball_y > paddle2_y and ball_y < paddle2_y + paddle_h then
        ball_dx = -abs(ball_dx)
    
    
    --sides hit
    elseif ball_x <=  0 then
      score2 += 1
      ball_x = 64
      ball_y = 64
      ball_dx = 2.5 * (rnd(2) > 1 and 1 or -1)
      ball_dy = 2* (rnd(2) > 1 and 1 or -1)
     
    elseif ball_x >=  120 then
     score1 += 1
     ball_x = 64
     ball_y = 64
     ball_dx = 2 * (rnd(2) > 1 and 1 or -1)
     ball_dy = 1.5 * (rnd(2) > 1 and 1 or -1)
      

    end
end
end

function _draw()
	camera(cx,cy)
	map(ax,ay,mx,my)
	spr(1,player.x,player.y)
	
	
	if false then
	rect(48,160,40,152,11)
	rect(t_x,t_y,t2_x,t2_y,11)
	end
	if mazegame then 
        cls()
    for y=1,15 do
        for x = 1,20 do
            local tile=maze[y][x]

            local color = tile == 0 and 7 or (tile==2 and 10 or 1)
            rectfill((x-1)*cell_size,(y-1)*cell_size,x*cell_size-1,y*cell_size-1,color)
        end
    end

    local px = (m_player.x-1)*cell_size + cell_size/2
    local py = (m_player.y-1)*cell_size + cell_size/2
    circfill(px,py,2,8)
end
end
	if pingpongminigame then
        cls()
    

    -- paddles
    rectfill(2, paddle1_y, 5, paddle1_y + paddle_h, 7)
    rectfill(122, paddle2_y, 125, paddle2_y + paddle_h, 7)

    -- ball
    circfill(ball_x, ball_y, 2, 8)
  print("you", 11, 6, 8)
  print(score1, 10, 12, 7)--top leftt sscore
  print("seal★", 111,6,8)
  print(score2, 110,12, 7)   -- right player score at top-right


    

	
end


