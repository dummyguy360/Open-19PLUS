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
	parry = 70,
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

function State(arg0, arg1, arg2, arg3 = 0) constructor
{
    id = arg0;
    name = arg1;
    script = !is_undefined(arg2) ? method(other, arg2) : undefined;
    flags = arg3;
    other.statemachine[id] = self;
}

function scr_definestates()
{
    new State(0, "Normal", scr_player_normal);
    new State(1, "Tumble", scr_player_tumble);
    new State(2, "FinishingBlow", scr_player_finishingblow);
    new State(3, "Ejected", scr_player_ejected);
    new State(4, "Fireass", scr_player_fireass);
    new State(5, "Firemouth", scr_player_firemouth);
    new State(6, "Titlescreen", scr_player_titlescreen);
    new State(7, "TackleCharge", scr_player_tacklecharge);
    new State(8, "Cheeseball", scr_player_cheeseball);
    new State(9, "CheesePep", scr_player_cheesepep);
    new State(10, "CheesePepStick", scr_player_cheesepepstick);
    new State(11, "BoxxedPep", scr_player_boxxedpep);
    new State(12, "ClimbWall", scr_player_climbwall);
    new State(13, "KnightPepSlopes", scr_player_knightpepslopes);
    new State(14, "Portal", scr_player_portal);
    new State(15, "ChainsawBump", scr_player_chainsawbump);
    new State(16, "SuplexGrab", scr_player_suplexgrab);
    new State(17, "GotTreasure", scr_player_gottreasure);
    new State(18, "KnightPep", scr_player_knightpep);
    new State(19, "BombPep", scr_player_bombpep);
    new State(20, "ChainsawPogo", scr_player_chainsawpogo);
    new State(21, "Stunned", scr_player_stunned);
    new State(22, "Chainsaw", scr_player_chainsaw);
    new State(23, "MachRoll", scr_player_machroll);
    new State(24, "Shotgun", scr_player_shotgun);
    new State(25, "SuperSlam", scr_player_superslam);
    new State(26, "Skateboard", scr_player_skateboard);
    new State(27, "Grind", scr_player_grind);
    new State(28, "Grab", scr_player_grab);
    new State(29, "Punch", scr_player_punch);
    new State(30, "Shoulder", scr_player_shoulder);
    new State(31, "Backbreaker", scr_player_backbreaker);
    new State(32, "BossIntro", scr_player_bossintro);
    new State(33, "Ejected2", scr_player_ejected);
    new State(34, "KeyGet", scr_player_keyget);
    new State(35, "Tackle", scr_player_tackle);
    new State(36, "Jump", scr_player_jump);
    new State(37, "Ladder", scr_player_ladder);
    new State(38, "SlipNSlide", scr_player_slipnslide);
    new State(39, "ComingOutDoor", scr_player_comingoutdoor);
    new State(40, "SJump", scr_player_Sjump);
    new State(41, "Victory", scr_player_victory);
    new State(42, "SJumpPrep", scr_player_Sjumpprep);
    new State(43, "Crouch", scr_player_crouch);
    new State(44, "CrouchJump", scr_player_crouchjump);
    new State(45, "CrouchSlide", scr_player_crouchslide);
    new State(46, "Mach1", scr_player_mach1);
    new State(47, "Mach2", scr_player_mach2);
    new State(48, "MachSlide", scr_player_machslide);
    new State(49, "Bump", scr_player_bump);
    new State(50, "Hurt", scr_player_hurt);
    new State(51, "FreeFall", scr_player_freefall);
    new State(52, "Hang", scr_player_hang);
    new State(53, "FreeFallLand", scr_player_freefallland);
    new State(54, "Door", scr_player_door);
    new State(55, "BarrelBounce", scr_player_barrelbounce);
    new State(56, "BarrelCrouch", scr_player_barrelcrouch);
    new State(57, "BarrelFloat", scr_player_barrelfloat);
    new State(58, "BarrelMach2", scr_player_barrelmach2);
    new State(59, "BarrelMach1", scr_player_barrelmach1);
    new State(60, "BarrelFall", scr_player_barrelfall);
    new State(61, "BarrelNormal", scr_player_barrelnormal);
    new State(62, "BarrelSlipNSlide", scr_player_barrelslipnslide);
    new State(63, "BarrelRoll", scr_player_barrelroll);
    new State(64, "Current", scr_player_current);
    new State(65, "Boulder", scr_player_boulder);
    new State(66, "Mach3", scr_player_mach3);
    new State(67, "FreeFallPrep", scr_player_freefallprep);
    new State(68, "SJumpLand", scr_player_Sjumpland);
    new State(69, "SlapDash", scr_player_slapdash);
    new State(70, "Parry", scr_player_parry);
    new State(71, "Breakdance", scr_player_breakdance);
    new State(72, "Flustered", scr_player_flustered);
    new State(73, "Shoulderbash", scr_player_shoulderbash);
    new State(74, "GunShoot", scr_player_gunshoot);
    new State(75, "Shoryuken", scr_player_shoryuken);
    new State(76, "Pipe", scr_player_pipe);
    new State(77, "Faceplant", scr_player_faceplant);
    new State(78, "Ghost", scr_player_ghost);
    new State(79, "Golf", scr_player_golf);
    new State(80, "Thok", scr_player_thok);
    new State(81, "Pogo", scr_player_pogo);
    new State(82, "Wait", scr_player_wait);
    new State(83, "Handstand", scr_player_handstand);
    new State(84, "SideJumpPrep", scr_player_sidejumpprep);
    new State(85, "SideJump", scr_player_sidejump);
    new State(86, "Grow", scr_player_grow);
    new State(87, "Hitstun", scr_player_hitstun, 1);
    new State(88, "SlipBanan", scr_player_slipbanan);
    new State(89, "Taxi", scr_player_taxi);
    new State(90, "BallLOL", scr_player_balllol);
    new State(91, "KungFu", scr_player_kungfu);
    new State(92, "TackleOLD", scr_player_tackleold);
    new State(93, "GameOver", scr_player_gameover);
    new State(94, "TimesUp!", scr_player_timesup);
    new State(95, "Ramp", scr_player_ramp);
    new State(96, "WeenieMount", scr_player_weeniemount);
    new State(97, "FireMove", scr_player_firemove);
    new State(98, "PitFall", scr_player_pitfall);
    new State(99, "HeroPep", scr_player_heropep);
    new State(100, "HomingAttack", scr_playerS_homingattack);
    new State(101, "Pinch", scr_player_pinch);
    new State(102, "Start", scr_player_start);
    new State(103, "SwingDingFinish", scr_player_swingdingfinish);
    new State(104, "Seat", scr_player_seat);
    new State(105, "Barrel", scr_player_barrel);
    new State(106, "SmallPep", scr_player_smallpep);
    new State(107, "SmallPepDash", scr_player_smallpepdash);
    new State(108, "#RETRODeath", scr_player_RETROdeath);
    new State(109, "Firework", scr_player_firework);
    new State(110, "Nothing...", undefined);
    new State(111, "LevelSelect", scr_player_levelselect);
    new State(112, "Cheeseslime", scr_playerC_normal);
    new State(113, "CheeseslimeAttack", scr_playerC_attack);
    new State(114, "Actor", scr_player_actor);
    new State(115, "KnightPepBump", scr_player_knightpepbump);
    new State(116, "SecretPortal", undefined);
    new State(117, "Held", scr_player_held);
    new State(118, "Lunge", scr_player_lunge);
    new State(119, "KungFuGrab", scr_player_kungfugrab);
    new State(120, "NWallJump", scr_playerN_walljump);
    new State(121, "KingBubble", scr_player_kingbubble);
    new State(122, "NPCLocked", scr_player_npclocked);
    new State(123, "ForcedFall", scr_player_forcedfall);
    new State(124, "BombKnockback", scr_player_bombknockback);
    new State(125, "HubEject", scr_player_hubeject);
    new State(126, "SageLevelEntrance", scr_player_sagelevelentrance);
    new State(127, "GateCutscene", scr_player_gatecutscene);
    new State(128, "NoClip", scr_player_noclip);
    new State(129, "NoiseCrusher", scr_player_noisecrusher);
}
