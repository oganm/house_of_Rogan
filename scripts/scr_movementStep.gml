leftKey = keyboard_check(vk_left);
rightKey = keyboard_check(vk_right);
downKey = keyboard_check(vk_down);
upKey = keyboard_check(vk_up);


keys[3] = upKey
keys[2] = downKey
keys[1] = rightKey
keys[0] = leftKey


// this increments the timers if they are running and resets them
// when they run for enough time
for (i = 0; i<4; i+=1){
    if(pauseTimers[i] >= 0){
        pauseTimers[i] += 1
    }
    if(pauseTimers[i] >= gridSize/walkerSpeed){
        pauseTimers[i] = -1
    }
    
    if(keys[i]){
        if(pauseTimers[i]>=0){
            // if pause timers are running don't do jack shit
        } else {
            //if not send the order to move and run the timer
            pauseTimers[i] = 0
            ds_list_insert(orders,0,i);
        }
    }
}


// this starts movement if not already moving and keys are pressed
if(ds_list_size(orders)!=0 and !moving){
    //show_message("starting to move");
    moving = true;
    dir = orders[| 0];
    ds_list_delete(orders,0);
    location = 0;
}

// move according to the ordered direction
if (moving){
    sprite_index = sprites[dir]
    switch (dir){
        case 0:
            phy_position_x -= walkerSpeed;
            sprite_index = leftSprite;
            break;
        case 1:
            phy_position_x += walkerSpeed;
            sprite_index = rightSprite;
            break;
        case 3:
            phy_position_y -= walkerSpeed;
            sprite_index = upSprite
            break;
        case 2:
            phy_position_y += walkerSpeed;
            sprite_index = downSprite
            break;
    }
    
    image_speed= animationSpeed;
    location += walkerSpeed;
    if (location >= gridSize){
        //show_message("stopping movement");
        moving = false
    }
}
// stop if not pressing a key
if(!leftKey and !rightKey and !downKey and !upKey and !moving){
    //sprite_index = stopSprites[dir]
    image_speed=0;
    image_index = 0;
}
