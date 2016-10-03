interactKey = keyboard_check(ord("X"));

yOfset = 0;
xOfset = 0;
switch (dir){
    case 0:
        xOfset = -gridSize;
        break;
    case 1:
        xOfset = gridSize;
        break;
    case 3:
        yOfset = -gridSize;
        break;
    case 2:
        yOfset = gridSize;
        break;
}

// send signal for interaction to the object
if (interactKey and !instance_exists(obj_textbox)){
    // see if there are any interactable objects in front of you and get its insance id
    instance = instance_position(x+xOfset+gridSize/2,y+yOfset+gridSize/2, obj_interactable)
    if instance != noone {
        if (!skipInteraction){
            skipInteraction = true
            with (instance){
                startInteract = true
            }
        } else {
            skipInteractionTimer = 0
        }
    }
}

if(skipInteractionTimer >= 0){
    skipInteractionTimer += 1
}

if(skipInteractionTimer >= 10){
    skipInteraction = false
    skipInteractionTimer = -1
}
