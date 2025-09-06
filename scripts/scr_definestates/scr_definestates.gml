enum states 
{
	normal = 0,
	tumble = 1,
	finishingblow = 2,
	ejected = 3,
	fireass = 4,
	firemouth = 5,
	titlescreen = 6,
	tacklecharge = 7,
	cheeseball = 8,
	cheesepep = 9,
	cheesepepstick = 10,
	boxxedpep = 11,
	climbwall = 12,
	knightpepslopes = 13,
	portal = 14,
	chainsawbump = 15,
	suplexgrab = 16,
	gottreasure = 17,
	knightpep = 18,
	bombpep = 19,
	chainsawpogo = 20,
	stunned = 21,
	chainsaw = 22,
	machroll = 23,
	shotgun = 24,
	superslam = 25,
	skateboard = 26,
	grind = 27,
	grab = 28,
	punch = 29,
	shoulder = 30,
	backbreaker = 31,
	bossintro = 32,
	ejected2 = 33,
	keyget = 34,
	tackle = 35,
	jump = 36,
	ladder = 37,
	slipnslide = 38,
	comingoutdoor = 39,
	sjump = 40,
	victory = 41,
	sjumpprep = 42,
	crouch = 43,
	crouchjump = 44,
	crouchslide = 45,
	mach1 = 46,
	mach2 = 47,
	machslide = 48,
	bump = 49,
	hurt = 50,
	freefall = 51,
	hang = 52,
	freefallland = 53,
	door = 54,
	barrelbounce = 55,
	barrelcrouch = 56,
	barrelfloat = 57,
	barrelmach2 = 58,
	barrelmach1 = 59,
	barrelfall = 60,
	barrelnormal = 61,
	barrelslipnslide = 62,
	barrelroll = 63,
	current = 64,
	boulder = 65,
	mach3 = 66,
	freefallprep = 67,
	sjumpland = 68,
	slapdash = 69,
	parrying = 70,
	breakdance = 71,
	flustered = 72,
	shoulderbash = 73,
	gunshoot = 74,
	shoryuken = 75,
	pipe = 76,
	faceplant = 77,
	ghost = 78,
	golf = 79,
	thok = 80,
	pogo = 81,
	wait = 82,
	handstand = 83,
	sidejumpprep = 84,
	sidejump = 85,
	grow = 86,
	hitstun = 87,
	slipbanan = 88,
	taxi = 89,
	balllol = 90,
	kungfu = 91,
	tackleold = 92,
	gameover = 93,
	timesup = 94,
	ramp = 95,
	weeniemount = 96,
	firemove = 97,
	pitfall = 98,
	heropep = 99,
	homingattack = 100,
	pinch = 101,
	start = 102,
	swingdingfinish = 103,
	seat = 104,
	barrel = 105,
	smallpep = 106,
	smallpepdash = 107,
	retrodeath = 108,
	firework = 109,
	nothing = 110,
	levelselect = 111,
	cheeseslime = 112,
	cheeseslimeattack = 113,
	actor = 114,
	knightpepbump = 115,
	secretportal = 116,
	held = 117,
	lunge = 118,
	kungfugrab = 119,
	nwalljump = 120,
	kingbubble = 121,
	npclocked = 122,
	forcedfall = 123,
	bombknockback = 124,
	hubeject = 125,
	sagelevelentrance = 126,
	gatecutscene = 127,
	noclip = 128,
	noisecrusher = 129,
}

function State(_id, _name, _func, _flags = 0) constructor
{
    id = _id;
    name = _name;
    script = !is_undefined(_func) ? method(other, _func) : undefined;
    flags = _flags;
    other.statemachine[id] = self;
}

function scr_definestates()
{
    new State(states.normal, "Normal", scr_player_normal);
    new State(states.tumble, "Tumble", scr_player_tumble);
    new State(states.finishingblow, "FinishingBlow", scr_player_finishingblow);
    new State(states.ejected, "Ejected", scr_player_ejected);
    new State(states.fireass, "Fireass", scr_player_fireass);
    new State(states.firemouth, "Firemouth", scr_player_firemouth);
    new State(states.titlescreen, "Titlescreen", scr_player_titlescreen);
    new State(states.tacklecharge, "TackleCharge", scr_player_tacklecharge);
    new State(states.cheeseball, "Cheeseball", scr_player_cheeseball);
    new State(states.cheesepep, "CheesePep", scr_player_cheesepep);
    new State(states.cheesepepstick, "CheesePepStick", scr_player_cheesepepstick);
    new State(states.boxxedpep, "BoxxedPep", scr_player_boxxedpep);
    new State(states.climbwall, "ClimbWall", scr_player_climbwall);
    new State(states.knightpepslopes, "KnightPepSlopes", scr_player_knightpepslopes);
    new State(states.portal, "Portal", scr_player_portal);
    new State(states.chainsawbump, "ChainsawBump", scr_player_chainsawbump);
    new State(states.suplexgrab, "SuplexGrab", scr_player_suplexgrab);
    new State(states.gottreasure, "GotTreasure", scr_player_gottreasure);
    new State(states.knightpep, "KnightPep", scr_player_knightpep);
    new State(states.bombpep, "BombPep", scr_player_bombpep);
    new State(states.chainsawpogo, "ChainsawPogo", scr_player_chainsawpogo);
    new State(states.stunned, "Stunned", scr_player_stunned);
    new State(states.chainsaw, "Chainsaw", scr_player_chainsaw);
    new State(states.machroll, "MachRoll", scr_player_machroll);
    new State(states.shotgun, "Shotgun", scr_player_shotgun);
    new State(states.superslam, "SuperSlam", scr_player_superslam);
    new State(states.skateboard, "Skateboard", scr_player_skateboard);
    new State(states.grind, "Grind", scr_player_grind);
    new State(states.grab, "Grab", scr_player_grab);
    new State(states.punch, "Punch", scr_player_punch);
    new State(states.shoulder, "Shoulder", scr_player_shoulder);
    new State(states.backbreaker, "Backbreaker", scr_player_backbreaker);
    new State(states.bossintro, "BossIntro", scr_player_bossintro);
    new State(states.ejected2, "Ejected2", scr_player_ejected);
    new State(states.keyget, "KeyGet", scr_player_keyget);
    new State(states.tackle, "Tackle", scr_player_tackle);
    new State(states.jump, "Jump", scr_player_jump);
    new State(states.ladder, "Ladder", scr_player_ladder);
    new State(states.slipnslide, "SlipNSlide", scr_player_slipnslide);
    new State(states.comingoutdoor, "ComingOutDoor", scr_player_comingoutdoor);
    new State(states.sjump, "SJump", scr_player_Sjump);
    new State(states.victory, "Victory", scr_player_victory);
    new State(states.sjumpprep, "SJumpPrep", scr_player_Sjumpprep);
    new State(states.crouch, "Crouch", scr_player_crouch);
    new State(states.crouchjump, "CrouchJump", scr_player_crouchjump);
    new State(states.crouchslide, "CrouchSlide", scr_player_crouchslide);
    new State(states.mach1, "Mach1", scr_player_mach1);
    new State(states.mach2, "Mach2", scr_player_mach2);
    new State(states.machslide, "MachSlide", scr_player_machslide);
    new State(states.bump, "Bump", scr_player_bump);
    new State(states.hurt, "Hurt", scr_player_hurt);
    new State(states.freefall, "FreeFall", scr_player_freefall);
    new State(states.hang, "Hang", scr_player_hang);
    new State(states.freefallland, "FreeFallLand", scr_player_freefallland);
    new State(states.door, "Door", scr_player_door);
    new State(states.barrelbounce, "BarrelBounce", scr_player_barrelbounce);
    new State(states.barrelcrouch, "BarrelCrouch", scr_player_barrelcrouch);
    new State(states.barrelfloat, "BarrelFloat", scr_player_barrelfloat);
    new State(states.barrelmach2, "BarrelMach2", scr_player_barrelmach2);
    new State(states.barrelmach1, "BarrelMach1", scr_player_barrelmach1);
    new State(states.barrelfall, "BarrelFall", scr_player_barrelfall);
    new State(states.barrelnormal, "BarrelNormal", scr_player_barrelnormal);
    new State(states.barrelslipnslide, "BarrelSlipNSlide", scr_player_barrelslipnslide);
    new State(states.barrelroll, "BarrelRoll", scr_player_barrelroll);
    new State(states.current, "Current", scr_player_current);
    new State(states.boulder, "Boulder", scr_player_boulder);
    new State(states.mach3, "Mach3", scr_player_mach3);
    new State(states.freefallprep, "FreeFallPrep", scr_player_freefallprep);
    new State(states.sjumpland, "SJumpLand", scr_player_Sjumpland);
    new State(states.slapdash, "SlapDash", scr_player_slapdash);
    new State(states.parrying, "Parry", scr_player_parry);
    new State(states.breakdance, "Breakdance", scr_player_breakdance);
    new State(states.flustered, "Flustered", scr_player_flustered);
    new State(states.shoulderbash, "Shoulderbash", scr_player_shoulderbash);
    new State(states.gunshoot, "GunShoot", scr_player_gunshoot);
    new State(states.shoryuken, "Shoryuken", scr_player_shoryuken);
    new State(states.pipe, "Pipe", scr_player_pipe);
    new State(states.faceplant, "Faceplant", scr_player_faceplant);
    new State(states.ghost, "Ghost", scr_player_ghost);
    new State(states.golf, "Golf", scr_player_golf);
    new State(states.thok, "Thok", scr_player_thok);
    new State(states.pogo, "Pogo", scr_player_pogo);
    new State(states.wait, "Wait", scr_player_wait);
    new State(states.handstand, "Handstand", scr_player_handstand);
    new State(states.sidejumpprep, "SideJumpPrep", scr_player_sidejumpprep);
    new State(states.sidejump, "SideJump", scr_player_sidejump);
    new State(states.grow, "Grow", scr_player_grow);
    new State(states.hitstun, "Hitstun", scr_player_hitstun, 1);
    new State(states.slipbanan, "SlipBanan", scr_player_slipbanan);
    new State(states.taxi, "Taxi", scr_player_taxi);
    new State(states.balllol, "BallLOL", scr_player_balllol);
    new State(states.kungfu, "KungFu", scr_player_kungfu);
    new State(states.tackleold, "TackleOLD", scr_player_tackleold);
    new State(states.gameover, "GameOver", scr_player_gameover);
    new State(states.timesup, "TimesUp!", scr_player_timesup);
    new State(states.ramp, "Ramp", scr_player_ramp);
    new State(states.weeniemount, "WeenieMount", scr_player_weeniemount);
    new State(states.firemove, "FireMove", scr_player_firemove);
    new State(states.pitfall, "PitFall", scr_player_pitfall);
    new State(states.heropep, "HeroPep", scr_player_heropep);
    new State(states.homingattack, "HomingAttack", scr_playerS_homingattack);
    new State(states.pinch, "Pinch", scr_player_pinch);
    new State(states.start, "Start", scr_player_start);
    new State(states.swingdingfinish, "SwingDingFinish", scr_player_swingdingfinish);
    new State(states.seat, "Seat", scr_player_seat);
    new State(states.barrel, "Barrel", scr_player_barrel);
    new State(states.smallpep, "SmallPep", scr_player_smallpep);
    new State(states.smallpepdash, "SmallPepDash", scr_player_smallpepdash);
    new State(states.retrodeath, "#RETRODeath", scr_player_RETROdeath);
    new State(states.firework, "Firework", scr_player_firework);
    new State(states.nothing, "Nothing...", undefined);
    new State(states.levelselect, "LevelSelect", scr_player_levelselect);
    new State(states.cheeseslime, "Cheeseslime", scr_playerC_normal);
    new State(states.cheeseslimeattack, "CheeseslimeAttack", scr_playerC_attack);
    new State(states.actor, "Actor", scr_player_actor);
    new State(states.knightpepbump, "KnightPepBump", scr_player_knightpepbump);
    new State(states.secretportal, "SecretPortal", undefined);
    new State(states.held, "Held", scr_player_held);
    new State(states.lunge, "Lunge", scr_player_lunge);
    new State(states.kungfugrab, "KungFuGrab", scr_player_kungfugrab);
    new State(states.nwalljump, "NWallJump", scr_playerN_walljump);
    new State(states.kingbubble, "KingBubble", scr_player_kingbubble);
    new State(states.npclocked, "NPCLocked", scr_player_npclocked);
    new State(states.forcedfall, "ForcedFall", scr_player_forcedfall);
    new State(states.bombknockback, "BombKnockback", scr_player_bombknockback);
    new State(states.hubeject, "HubEject", scr_player_hubeject);
    new State(states.sagelevelentrance, "SageLevelEntrance", scr_player_sagelevelentrance);
    new State(states.gatecutscene, "GateCutscene", scr_player_gatecutscene);
    new State(states.noclip, "NoClip", scr_player_noclip);
    new State(states.noisecrusher, "NoiseCrusher", scr_player_noisecrusher);
}
