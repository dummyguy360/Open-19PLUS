sprite_index = spr_cheesedragon_idle;
image_index = 0;
image_speed = 0.35;
flamehitbox = instance_create_depth(x, y, depth, obj_dragonflamehitbox);
flamehitbox.image_xscale = image_xscale;

enum dragonattk
{
	stomp = 0,
	fireball = 1
}
attackcycle = [dragonattk.fireball, dragonattk.stomp, dragonattk.stomp];
currentattack = 0;
die = false;
timereward = 60;
attackrate = 300;
attacktimer = attackrate;
attacktime = 180;
fireballheatseektime = 30;
brickwaveamount = 5;
brickwavespeed = 2;
fireball = false;
firetimer = 0;
stomped = false;
vommited = false;
