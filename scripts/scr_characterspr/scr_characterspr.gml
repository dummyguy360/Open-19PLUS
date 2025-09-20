function scr_characterspr()
{
    switch (character)
    {
		#region Peppino
        case "P":
            player_mask = spr_player_mask;
            player_crouchmask = spr_crouchmask;
            spr_idle = spr_player_idle;
            spr_move = spr_player_move;
            spr_tiptoe = spr_player_tiptoe;
            spr_moveturn = spr_player_moveturn;
            spr_crouch = spr_player_crouch;
            spr_crouchstart = spr_player_crouchstart;
            spr_crawl = spr_player_crawl;
            spr_crouchjump = spr_player_crouchjump;
            spr_crouchfall = spr_player_crouchfall;
            spr_crouchslip = spr_player_crouchslip;
            spr_jump = spr_player_jump;
            spr_fall = spr_player_fall;
            spr_land = spr_player_land;
            spr_land2 = spr_player_land2;
            spr_idle1 = spr_player_idleanim6;
            spr_idle2 = spr_player_idleanim1;
            spr_idle3 = spr_player_idleanim2;
            spr_idle4 = spr_player_idleanim3;
            spr_idle5 = spr_player_idleanim4;
            spr_idle6 = spr_player_idleanim5;
            spr_deathstart = spr_player_deathstart;
            spr_deathend = spr_player_deathend;
            spr_hurtidle = spr_player_hurtidle;
            spr_hurtwalk = spr_player_hurtwalk;
            spr_machslidestart = spr_player_machslidestart;
            spr_machslide = spr_player_machslide;
            spr_machslideend = spr_player_machslideend;
            spr_mach1 = spr_player_mach1;
            spr_airdash1 = spr_player_airdash1;
            spr_airdash2 = spr_player_airdash2;
            spr_mach = spr_player_mach;
            spr_secondjump1 = spr_player_secondjump1;
            spr_secondjump2 = spr_player_secondjump2;
            spr_machpunch1 = spr_player_machpunch1;
            spr_machpunch2 = spr_player_machpunch2;
            spr_mach2jump = spr_player_mach2jump;
            spr_mach4 = spr_player_mach4;
            spr_mach3jump = spr_player_mach3jump;
            spr_machslideboost = spr_player_machslideboost;
            spr_machslideboostend = spr_player_machslideboostend;
            spr_machslideboost3 = spr_player_machslideboost3;
            spr_machslideboost3end = spr_player_machslideboost3end;
            spr_machroll = spr_player_machroll;
            spr_rollgetup = spr_player_rollgetup;
            spr_dive = spr_player_dive;
            spr_bump = spr_player_bump;
            spr_hitwall = spr_player_mach3hitwall;
            spr_mach3hit = spr_player_mach3hit;
            spr_walljumpstart = spr_player_walljumpstart;
            spr_walljumpend = spr_player_walljumpend;
            spr_climbwall = spr_player_climbwall;
            spr_superjumpland = spr_player_superjumpland;
            spr_superjumpprep = spr_player_superjumpprep;
            spr_superjump = spr_player_superjump;
            spr_superjumpleft = spr_player_superjumpleft;
            spr_superjumpright = spr_player_superjumpright;
            spr_superjumppreplight = spr_player_superjumppreplight;
            spr_machfreefall = spr_player_machfreefall;
            spr_machclimbwall = spr_player_climbwall;
            spr_crazyrun = spr_player_crazyrun;
            spr_bombpepintro = spr_bombpep_intro;
            spr_bombpepend = spr_bombpep_end;
            spr_bombpeprunabouttoexplode = spr_bombpep_runabouttoexplode;
            spr_bombpeprun = spr_bombpep_run;
            spr_knightpepstart = spr_knightpep_start;
            #region Knight
            switch (knightspr)
            {
                case 0:
                default:
                    spr_knightpepwalk = spr_knightpep_walk;
                    spr_knightpepjump = spr_knightpep_jump;
                    spr_knightpepfall = spr_knightpep_fall;
                    spr_knightpepidle = spr_knightpep_idle;
                    spr_knightpepjumpstart = spr_knightpep_jumpstart;
                    spr_knightpepthunder = spr_knightpep_thunder;
                    spr_knightpepdownslope = spr_knightpep_downslope;
                    spr_knightpepupslope = spr_knightpep_upslope;
                    spr_knightpepland = spr_knightpep_land;
                    spr_knightpepcharge = spr_knightpep_charge;
                    spr_knightpepdownthrust = spr_knightpep_downthrust;
                    spr_knightpepdoublejump = spr_knightpep_doublejump;
                    spr_knightpepdoublejumploop = spr_knightpep_doublejumploop;
                    spr_knightpepjumpslidestart = spr_knightpep_jumpslidestart;
                    spr_knightpepjumpslide = spr_knightpep_jumpslide;
                    spr_knightpepbump = spr_knightpep_bump;
                    break;
                
                case 1:
                    spr_knightpepwalk = spr_knightpep_walkshit;
                    spr_knightpepjump = spr_knightpep_jumpshit;
                    spr_knightpepfall = spr_knightpep_fallshit;
                    spr_knightpepidle = spr_knightpep_idleshit;
                    spr_knightpepjumpstart = spr_knightpep_jumpstart;
                    spr_knightpepthunder = spr_knightpep_thundershit;
                    spr_knightpepdownslope = spr_knightpep_downslopeshit;
                    spr_knightpepupslope = spr_knightpep_upslope;
                    spr_knightpepland = spr_knightpep_landshit;
                    spr_knightpepcharge = spr_knightpep_chargeshit;
                    spr_knightpepdownthrust = spr_knightpep_downthrustshit;
                    spr_knightpepdoublejump = spr_knightpep_doublejumpshit;
                    spr_knightpepdoublejumploop = spr_knightpep_doublejumploopshit;
                    spr_knightpepjumpslidestart = spr_knightpep_jumpslidestartshit;
                    spr_knightpepjumpslide = spr_knightpep_jumpslideshit;
                    spr_knightpepbump = spr_knightpep_bumpshit;
                    break;
                
                case 2:
                    spr_knightpepwalk = spr_knightpep_walkclown;
                    spr_knightpepjump = spr_knightpep_jumpclown;
                    spr_knightpepfall = spr_knightpep_fallclown;
                    spr_knightpepidle = spr_knightpep_idleclown;
                    spr_knightpepjumpstart = spr_knightpep_jumpstart;
                    spr_knightpepthunder = spr_knightpep_thunderclown;
                    spr_knightpepdownslope = spr_knightpep_downslopeclown;
                    spr_knightpepupslope = spr_knightpep_upslope;
                    spr_knightpepland = spr_knightpep_landclown;
                    spr_knightpepcharge = spr_knightpep_chargeclown;
                    spr_knightpepdownthrust = spr_knightpep_downthrustclown;
                    spr_knightpepdoublejump = spr_knightpep_doublejumpclown;
                    spr_knightpepdoublejumploop = spr_knightpep_doublejumploopclown;
                    spr_knightpepjumpslidestart = spr_knightpep_jumpslidestartclown;
                    spr_knightpepjumpslide = spr_knightpep_jumpslideclown;
                    spr_knightpepbump = spr_knightpep_bumpclown;
                    break;
            }
            #endregion
            spr_tumblestart = spr_player_tumblestart;
            spr_tumble = spr_player_tumble;
            spr_tumbleend = spr_player_tumbleend;
            spr_crouchslip = spr_player_crouchslip;
            spr_lookdoor = spr_player_lookdoor;
            spr_walkfront = spr_player_walkfront;
            spr_uppizzabox = spr_player_uppizzabox;
            spr_downpizzabox = spr_player_downpizzabox;
            spr_Ladder = spr_player_ladder;
            spr_laddermove = spr_player_laddermove;
            spr_ladderdown = spr_player_ladderdown;
            
            if (instance_exists(obj_pause))
            {
                if (global.throwitback == 0)
                    spr_taunt = spr_player_taunt;
                
                if (global.throwitback == 1)
                    spr_taunt = spr_player_throwitback;
            }
            else
                spr_taunt = spr_player_taunt;
            
            spr_throwitback = spr_player_throwitback;
            spr_bodyslamfall = spr_player_bodyslamfall;
            spr_bodyslamstart = spr_player_bodyslamstart;
            spr_bodyslamland = spr_player_bodyslamland;
            spr_hurt = spr_player_hurt;
            spr_hurtjump = spr_player_jumphurt;
            spr_hurtjumpstart = spr_player_jumphurtstart;
            spr_piledriver = spr_player_piledriver;
            spr_piledriverland = spr_player_piledriverland;
			
            spr_suplexmash1 = spr_player_suplexmash1;
            spr_suplexmash2 = spr_player_suplexmash2;
            spr_suplexmash3 = spr_player_suplexmash3;
            spr_suplexmash4 = spr_player_suplexmash4;
            spr_suplexmash5 = spr_player_suplexmash5;
            spr_suplexmash6 = spr_player_suplexmash6;
            spr_suplexmash7 = spr_player_suplexmash7;
			
            spr_grab = spr_player_grab;
            spr_stompprep = spr_player_stompprep;
            spr_stomp = spr_player_stomp;
            spr_entergate = spr_player_entergate;
            spr_victory = spr_player_victory;
            spr_slipnslide = spr_player_slipnslide;
            spr_Current = spr_player_current;
            spr_keyget = spr_player_keyget;
            spr_gottreasure = spr_player_gottreasure;
            spr_fireass = spr_player_fireass;
            spr_fireassend = spr_player_fireassend;
            spr_fireassground = spr_player_fireassground;
            spr_facehurt = spr_player_facehurt;
            spr_facehurtup = spr_player_facehurtup;
            spr_armhurt = spr_player_armhurt;
            spr_armhurtup = spr_player_armhurtup;
            spr_3hpidle = spr_player_madidle;
            spr_3hpwalk = spr_player_madwalk;
            spr_panic = spr_player_panic;
            spr_winding = spr_player_winding;
			
            spr_hurtwalk = spr_player_hurtwalk;
            spr_hurtidle = spr_player_hurtidle;
			
            spr_suplexdash = spr_player_suplexdash;
            spr_suplexgrabjumpstart = spr_player_suplexgrabjumpstart;
            spr_suplexgrabjump = spr_player_suplexgrabjump;
			
            spr_longjumpstart = spr_player_longjumpstart;
            spr_longjump = spr_player_longjump;
            spr_longjumpslide = spr_player_grabslide;
            spr_longjumpslidestart = spr_player_grabslidestart;
			
            spr_swingding = spr_player_swingding;
            spr_swingdingend = spr_player_swingdingend;
			
            spr_finishingblow1 = spr_player_finishingblow1;
            spr_finishingblow2 = spr_player_finishingblow2;
            spr_finishingblow3 = spr_player_finishingblow3;
            spr_finishingblow4 = spr_player_finishingblow4;
            spr_finishingblow5 = spr_player_finishingblow5;
			
            spr_haulingstart = spr_player_haulingstart;
            spr_haulingidle = spr_player_haulingidle;
            spr_haulingjump = spr_player_haulingjump;
            spr_haulingfall = spr_player_haulingfall;
            spr_haulingmove = spr_player_haulingwalk;
            spr_haulingland = spr_player_haulingland;
			
            spr_uppercutfinishingblow = spr_player_uppercutfinishingblow;
            spr_stunned = spr_player_stunned;
            spr_throw = spr_player_throw;
            spr_bossintro = spr_player_bossintro;
            spr_grind = spr_player_grind;
            spr_golfidle = spr_player_golfidle;
            spr_golfhit = spr_player_golfhit;
            spr_levelcomplete = spr_player_levelcomplete;
            spr_rageidle = spr_player_rageidle;
            spr_ragemove = spr_player_ragemove;
			
            spr_parry1 = spr_player_parry1;
            spr_parry2 = spr_player_parry2;
            spr_parry3 = spr_player_parry3;
			
            spr_charge = spr_player_charge;
            spr_punch = spr_player_punch;
            spr_Cheeseball = spr_player_cheeseball;
			
            spr_boxxedintro = spr_boxxedpep_intro;
            spr_boxxedidle = spr_boxxedpep_idle;
            spr_boxxedair = spr_boxxedpep_air;
            spr_boxxedjump = spr_boxxedpep_jump;
            spr_boxxedwalk = spr_boxxedpep_walk;
            spr_boxxeddash = spr_boxxedpep_dash;
            spr_boxxedslide = spr_boxxedpep_slide;
            spr_boxxedslidedown = spr_boxxedpep_slidedown;
            spr_boxxeddoublejump = spr_boxxedpep_doublejump;
            spr_boxxeddoublejumpfall = spr_boxxedpep_doublejumpfall;
			
            spr_cheeseintro = spr_cheesepep_intro;
            spr_cheeseidle = spr_cheesepep_idle;
            spr_cheesewalk = spr_cheesepep_walk;
            spr_cheesejumpstart = spr_cheesepep_jumpstart;
            spr_cheesejump = spr_cheesepep_jump;
            spr_cheesefall = spr_cheesepep_fall;
            spr_cheeseland = spr_cheesepep_land;
            spr_cheesestickceilling = spr_cheesepep_stickceilling;
            spr_cheesestickwall = spr_cheesepep_stickwall;
			
            spr_rocketdash = spr_player_rocketdash;
            spr_rocketdashstart = spr_player_rocketdashstart;
            spr_rocketstart = spr_player_rocketstart;
            spr_rockethitwall = spr_player_firemoveend;
            spr_rocketrun = spr_player_rocketrun;
			
            spr_facestomp = spr_player_facestomp;
            spr_freefall = spr_player_freefall;
            spr_freefallland = spr_player_freefallland;
            spr_Timesup = spr_player_timesup;
            spr_hang = spr_player_hang;
            spr_hangslide = spr_player_hangslide;
            spr_Dashpad = spr_player_dashpad;
			
            spr_supertaunt1 = spr_player_supertaunt1;
            spr_supertaunt2 = spr_player_supertaunt2;
            spr_supertaunt3 = spr_player_supertaunt3;
            spr_supertaunt4 = spr_player_supertaunt4;
			
            spr_shotgunpullout = spr_shotgun_pullout;
            spr_Shotgun = spr_player_shotgun;
            spr_shotgunidle = spr_shotgun_idle;
            spr_shotgunwalk = spr_shotgun_walk;
            spr_shotgunjump = spr_shotgun_jump;
            spr_shotgunfall = spr_shotgun_fall;
            spr_shotgunland = spr_shotgun_land;
            spr_shotgunsuplexdash = spr_shotgun_suplexdash;
            spr_shotgunjump1 = spr_player_shotgunjump1;
            spr_shotgunjump2 = spr_player_shotgunjump2;
            spr_shotgunjump3 = spr_player_shotgunjump3;
            spr_shotgunduck = spr_shotgun_duck;
            spr_shotguncrawl = spr_shotgun_crawl;
            spr_shotgungoduck = spr_shotgun_goduck;
            spr_shotguncrouchjump1 = spr_shotgun_crouchjump1;
            spr_shotguncrouchjump2 = spr_shotgun_crouchjump2;
			
            spr_slipbanan1 = spr_player_slipbanan1;
            spr_slipbanan2 = spr_player_slipbanan2;
            spr_slipbanan3 = spr_player_slipbanan3;
            spr_slipbananimpact = spr_player_firemoveend;
			
            spr_suplexgrabcancel = spr_player_grabcancel;
            spr_scaredjumpstart = spr_player_scaredjumpstart;
            spr_scaredjump = spr_player_scaredjump;
            spr_faceplant = spr_player_faceplant;
            spr_airjugglestart = spr_player_jugglestart;
            spr_airjuggle = spr_player_juggle;
            spr_bodyslamjump = spr_player_bodyslamjump;
			
            spr_firemouth = spr_player_firemouth;
            spr_firemouthintro = spr_player_firemouthintro;
            spr_firemouthend = spr_player_firemouthend;
            spr_firemouthidle = spr_player_firemouthidle;
            spr_firemouthjump = spr_player_firemouthjump;
            spr_firemouthdash = spr_player_firemouthdash;
            spr_firemouthwalljump = spr_player_firemouthwalljump;
			
            spr_wallbump = spr_player_wallbump;
            spr_presentjump = spr_player_presentjump;
            spr_shoryukenstart = spr_player_shoryukenstart;
            spr_shoryuken = spr_player_shoryuken;
            spr_fireworkride = spr_player_firework;
			
            spr_gnomecutscene1 = spr_player_gnomecutscene1;
            spr_gnomecutscene2 = spr_player_gnomecutscene2;
            spr_gnomecutscene3 = spr_player_gnomecutscene3;
            spr_gnomecutscene4 = spr_player_gnomecutscene4;
            spr_gnomecutscene5 = spr_player_gnomecutscene5;
			
            spr_sjumpcancelstart = spr_player_sjumpcancelstart;
            spr_sjumpcancel = spr_player_sjumpcancel;
            spr_shoulderbash = spr_player_shoulderbash;
			
            spr_airshoulderbashstart = spr_player_airshoulderbashstart;
            spr_airshoulderbash = spr_player_airshoulderbash;
			
            spr_kungfu1 = spr_player_kungfu1;
            spr_kungfu2 = spr_player_kungfu2;
            spr_kungfu3 = spr_player_kungfu3;
            spr_kungfuair1start = spr_player_kungfuair1start;
            spr_kungfuair2start = spr_player_kungfuair2start;
            spr_kungfuair3start = spr_player_kungfuair3start;
            spr_kungfuair1 = spr_player_kungfuair1;
            spr_kungfuair2 = spr_player_kungfuair2;
            spr_kungfuair3 = spr_player_kungfuair3;
            spr_kungfubump = spr_player_kungfubump;
			
            spr_noisewalljump = spr_player_kungfubump;
			
            spr_barrelidle = spr_player_barrelidle;
            spr_barrelmove = spr_player_barrelmove;
            spr_barreljump = spr_player_barreljump;
            spr_barrelfall = spr_player_barrelfall;
            spr_barrelland = spr_player_barrelland;
            spr_barrelslipnslide = spr_player_barrelslipnslide;
            spr_barrelroll = spr_player_barrelroll;
			
            spr_Weeniemount = spr_player_weeniemount;
            spr_Weeniemountturn = spr_player_weeniemountturn;
			
            spr_wallsplat = spr_player_wallsplat;
            spr_emo = spr_player_emo;
            spr_palette = spr_peppalette;
            spr_pause = spr_pausepeppino;
			
            spr_newhudidle1 = spr_peppinohud_idle1;
            spr_newhudidle2 = spr_peppinohud_idle2;
            spr_newhudidle3 = spr_peppinohud_idle3;
            spr_newhudidle4 = spr_peppinohud_idle4;
            spr_newhudknight = spr_peppinohud_knight;
            spr_newhudhurt = spr_peppinohud_hurt;
            spr_newhudball = spr_peppinohud_tumble;
            spr_newhudhappy = spr_peppinohud_happy;
            spr_newhudpanic = spr_peppinohud_panic;
            spr_newhudfireass = spr_peppinohud_fireass;
            spr_newhudmach3 = spr_peppinohud_mach3;
            spr_newhudmach4 = spr_peppinohud_mach4;
            spr_newhudgolf = spr_peppinohud_golf;
            spr_newhudbomb = spr_peppinohud_bomb;
            spr_newhudrage = spr_peppinohud_rage;
            spr_newhudevil = spr_peppinohud_evil;
            spr_newhudshotgun = spr_peppinohud_shotgun;
            spr_newhudcheeseball = spr_peppinohud_cheeseball;
            spr_newhudfiremove = spr_peppinohud_firemove;
            spr_newhudboxxed = spr_peppinohud_boxxed;
            spr_newhudfiremouth = spr_peppinohud_firemouth;
            spr_newhudbarrel = spr_peppinohud_barrel;
            spr_newhudscaredjump = spr_peppinohud_scaredjump;
            spr_newhudrocket = spr_peppinohud_rocket;
            spr_newhudweenie = spr_peppinohud_weenie;
            spr_newhudsecret = spr_peppinohud_secret;
            spr_bosshud = spr_playerbosshud;
            spr_bosshudhurt = spr_playerbosshudhurt;
			
            spr_smallidle = spr_smallpep_idle;
            spr_smallwalk = spr_smallpep_walk;
            spr_smalljump = spr_smallpep_jump;
            spr_smallfall = spr_smallpep_fall;
            spr_smallland1 = spr_smallpep_landidle;
            spr_smallland2 = spr_smallpep_landwalk;
            spr_smalldashstart = spr_smallpep_dashstart;
            spr_smalldash = spr_smallpep_dashloop;
            spr_smallhurt = spr_smallpep_hurt;
            spr_smallstompprep = spr_smallpep_stompprep;
            spr_smallstomp = spr_smallpep_stomp;
            spr_smalldead = spr_smallpep_dead;
			
            spr_prank = spr_rankP;
            spr_srank = spr_rankS;
            spr_arank = spr_rankA;
            spr_brank = spr_rankB;
            spr_crank = spr_rankC;
            spr_drank = spr_rankD;
            break;
		#endregion
        #region Noise
        case "N":
            player_mask = spr_player_mask;
            player_crouchmask = spr_crouchmask;
            spr_idle = spr_playerN_idle;
            spr_move = spr_playerN_move;
            spr_tiptoe = spr_playerN_move;
            spr_moveturn = spr_playerN_move;
            spr_crouch = spr_playerN_crouch;
            spr_crouchstart = spr_playerN_crouchstart;
            spr_crawl = spr_playerN_crawl;
            spr_crouchjump = spr_playerN_crouchjump;
            spr_crouchfall = spr_playerN_crouchfall;
            spr_crouchslip = spr_playerN_crouchslip;
            spr_jump = spr_playerN_jump;
            spr_fall = spr_playerN_fall;
            spr_land = spr_playerN_land;
            spr_land2 = spr_playerN_land2;
            spr_idle1 = spr_playerN_idleballoon;
            spr_idle2 = spr_playerN_idledance;
            spr_idle3 = spr_playerN_idleface;
            spr_idle4 = spr_playerN_idlegun;
            spr_idle5 = spr_playerN_idlemask;
            spr_idle6 = spr_playerN_idlesmoke;
            spr_deathstart = spr_playerN_deathstart;
            spr_deathend = spr_playerN_deathend;
            spr_hurtidle = spr_playerN_hurtidle;
            spr_hurtwalk = spr_playerN_hurtwalk;
            spr_machslidestart = spr_playerN_machslidestart;
            spr_machslide = spr_playerN_machslide;
            spr_machslideend = spr_playerN_machslideend;
            spr_mach1 = spr_playerN_mach1;
            spr_airdash1 = spr_playerN_airdash1;
            spr_airdash2 = spr_playerN_airdash2;
            spr_mach = spr_playerN_mach;
            spr_secondjump1 = spr_playerN_secondjump1;
            spr_secondjump2 = spr_playerN_secondjump2;
            spr_machpunch1 = spr_playerN_machpunch1;
            spr_machpunch2 = spr_playerN_machpunch2;
            spr_mach2jump = spr_playerN_mach2jump;
            spr_mach4 = spr_playerN_mach3;
            spr_mach3jump = spr_playerN_mach3jump;
            spr_machslideboost = spr_playerN_machslideboost;
            spr_machslideboostend = spr_playerN_machslideboostfall;
            spr_machslideboost3 = spr_playerN_mach3boost;
            spr_machslideboost3end = spr_playerN_mach3boostfall;
            spr_machroll = spr_playerN_machroll;
            spr_rollgetup = spr_playerN_rollgetup;
            spr_dive = spr_playerN_dive;
            spr_bump = spr_playerN_bump;
            spr_hitwall = spr_playerN_mach3hitwall;
            spr_mach3hit = spr_playerN_machpunch1;
            spr_walljumpstart = spr_playerN_walljumpstart;
            spr_walljumpend = spr_playerN_walljumpend;
            spr_climbwall = spr_playerN_climbwall;
            spr_superjumpland = spr_playerN_Sjumpland;
            spr_superjumpprep = spr_playerN_Sjumpstart;
            spr_superjump = spr_playerN_Sjump;
            spr_superjumpleft = spr_playerN_Sjumpmoveleft;
            spr_superjumpright = spr_playerN_Sjumpmoveright;
            spr_superjumppreplight = spr_playerN_Sjumpprep;
            spr_machfreefall = spr_playerN_fall;
            spr_machclimbwall = spr_playerN_climbwall;
            spr_crazyrun = spr_playerN_crazyrun;
            spr_bombpepintro = spr_playerN_bombstart;
            spr_bombpepend = spr_playerN_bombend;
            spr_bombpeprunabouttoexplode = spr_playerN_bombabouttoexplode;
            spr_bombpeprun = spr_playerN_bomb;
            spr_knightpepstart = spr_playerN_knightsword;
            #region Knight
            switch (knightspr)
            {
                case 0:
                default:
                    spr_knightpepwalk = spr_playerN_knightmove;
                    spr_knightpepjump = spr_playerN_knightjump;
                    spr_knightpepfall = spr_playerN_knightfall;
                    spr_knightpepidle = spr_playerN_knightidle;
                    spr_knightpepjumpstart = spr_playerN_knightjumpstart;
                    spr_knightpepthunder = spr_playerN_knightstart;
                    spr_knightpepdownslope = spr_playerN_knightdownslope;
                    spr_knightpepupslope = spr_playerN_knightslideup;
                    spr_knightpepland = spr_playerN_knightland;
                    spr_knightpepcharge = spr_playerN_knightslide;
                    spr_knightpepdownthrust = spr_playerN_knightdowntrust;
                    spr_knightpepdoublejump = spr_playerN_knightdoublejumpfall;
                    spr_knightpepdoublejumploop = spr_playerN_knightdoublejump;
                    spr_knightpepjumpslidestart = spr_playerN_knightfly;
                    spr_knightpepjumpslide = spr_playerN_knightflyend;
                    spr_knightpepbump = spr_playerN_knightbump;
                    break;
                
                case 1:
                    spr_knightpepwalk = spr_knightpep_walkshit;
                    spr_knightpepjump = spr_knightpep_jumpshit;
                    spr_knightpepfall = spr_knightpep_fallshit;
                    spr_knightpepidle = spr_knightpep_idleshit;
                    spr_knightpepjumpstart = spr_knightpep_jumpstart;
                    spr_knightpepthunder = spr_knightpep_thundershit;
                    spr_knightpepdownslope = spr_knightpep_downslopeshit;
                    spr_knightpepupslope = spr_knightpep_upslope;
                    spr_knightpepland = spr_knightpep_landshit;
                    spr_knightpepcharge = spr_knightpep_chargeshit;
                    spr_knightpepdownthrust = spr_knightpep_downthrustshit;
                    spr_knightpepdoublejump = spr_knightpep_doublejumpshit;
                    spr_knightpepdoublejumploop = spr_knightpep_doublejumploopshit;
                    spr_knightpepjumpslidestart = spr_knightpep_jumpslidestartshit;
                    spr_knightpepjumpslide = spr_knightpep_jumpslideshit;
                    spr_knightpepbump = spr_knightpep_bumpshit;
                    break;
                
                case 2:
                    spr_knightpepwalk = spr_knightpep_walkclown;
                    spr_knightpepjump = spr_knightpep_jumpclown;
                    spr_knightpepfall = spr_knightpep_fallclown;
                    spr_knightpepidle = spr_knightpep_idleclown;
                    spr_knightpepjumpstart = spr_knightpep_jumpstart;
                    spr_knightpepthunder = spr_knightpep_thunderclown;
                    spr_knightpepdownslope = spr_knightpep_downslopeclown;
                    spr_knightpepupslope = spr_knightpep_upslope;
                    spr_knightpepland = spr_knightpep_landclown;
                    spr_knightpepcharge = spr_knightpep_chargeclown;
                    spr_knightpepdownthrust = spr_knightpep_downthrustclown;
                    spr_knightpepdoublejump = spr_knightpep_doublejumpclown;
                    spr_knightpepdoublejumploop = spr_knightpep_doublejumploopclown;
                    spr_knightpepjumpslidestart = spr_knightpep_jumpslidestartclown;
                    spr_knightpepjumpslide = spr_knightpep_jumpslideclown;
                    spr_knightpepbump = spr_knightpep_bumpclown;
                    break;
            }
            #endregion
            spr_tumblestart = spr_playerN_tumblestart;
            spr_tumble = spr_playerN_tumble;
            spr_tumbleend = spr_playerN_tumbleend;
            spr_crouchslip = spr_playerN_crouchslip;
            spr_lookdoor = spr_playerN_lookdoor;
            spr_walkfront = spr_playerN_walkfront;
            spr_uppizzabox = spr_playerN_uppizzabox;
            spr_downpizzabox = spr_playerN_downpizzabox;
            spr_Ladder = spr_playerN_ladder;
            spr_laddermove = spr_playerN_laddermove;
            spr_ladderdown = spr_playerN_ladderdown;
            
            if (instance_exists(obj_pause))
            {
                if (global.throwitback == 0)
                    spr_taunt = spr_playerN_taunt;
                
                if (global.throwitback == 1)
                    spr_taunt = spr_player_throwitback;
            }
            else
            {
                spr_taunt = spr_playerN_taunt;
            }
            
            spr_throwitback = spr_player_throwitback;
            spr_bodyslamfall = spr_playerN_bodyslam;
            spr_bodyslamstart = spr_playerN_bodyslamstart;
            spr_bodyslamland = spr_playerN_bodyslamland;
            spr_hurt = spr_playerN_hurt;
            spr_hurtjump = spr_playerN_hurtjump;
            spr_hurtjumpstart = spr_playerN_hurtjump;
            spr_piledriver = spr_playerN_piledriver;
            spr_piledriverland = spr_playerN_piledriverland;
			
            spr_suplexmash1 = spr_playerN_suplexmash1;
            spr_suplexmash2 = spr_playerN_suplexmash2;
            spr_suplexmash3 = spr_playerN_suplexmash3;
            spr_suplexmash4 = spr_playerN_suplexmash4;
            spr_suplexmash5 = spr_playerN_suplexmash3;
            spr_suplexmash6 = spr_playerN_suplexmash2;
            spr_suplexmash7 = spr_playerN_suplexmash3;
			
            spr_grab = spr_playerN_grab;
            spr_stompprep = spr_playerN_stompprep;
            spr_stomp = spr_playerN_stomp;
            spr_entergate = spr_player_entergate;
            spr_victory = spr_playerN_victory;
            spr_slipnslide = spr_playerN_slipnslide;
            spr_Current = spr_playerN_current;
            spr_keyget = spr_playerN_keyget;
            spr_gottreasure = spr_playerN_gottreasure;
            spr_fireass = spr_playerN_fireass;
            spr_fireassend = spr_playerN_fireassend;
            spr_fireassground = spr_playerN_fireassground;
            spr_facehurt = spr_playerN_facehurt;
            spr_facehurtup = spr_playerN_facehurtup;
            spr_armhurt = spr_playerN_facehurt;
            spr_armhurtup = spr_playerN_facehurtup;
            spr_3hpidle = spr_playerN_angryidle;
            spr_3hpwalk = spr_playerN_angrymove;
            spr_panic = spr_playerN_panicidle;
            spr_winding = spr_playerN_winding;
            spr_hurtwalk = spr_playerN_hurtwalk;
            spr_hurtidle = spr_playerN_hurtidle;
			
            spr_suplexdash = spr_playerN_suplexgrab;
            spr_suplexgrabjumpstart = spr_playerN_suplexgrabjumpstart;
            spr_suplexgrabjump = spr_playerN_suplexgrabjump;
			
            spr_longjumpstart = spr_playerN_longjump;
            spr_longjump = spr_playerN_longjumpend;
            spr_longjumpslide = spr_playerN_fastroll;
            spr_longjumpslidestart = spr_playerN_fastroll;
			
            spr_swingding = spr_playerN_swingding;
            spr_swingdingend = spr_playerN_swingdingend;
			
            spr_finishingblow1 = spr_playerN_finishingblow1;
            spr_finishingblow2 = spr_playerN_finishingblow2;
            spr_finishingblow3 = spr_playerN_finishingblow3;
            spr_finishingblow4 = spr_playerN_finishingblow4;
            spr_finishingblow5 = spr_playerN_finishingblow5;
			
            spr_haulingstart = spr_playerN_haulingstart;
            spr_haulingidle = spr_playerN_haulingidle;
            spr_haulingjump = spr_playerN_haulingjump;
            spr_haulingfall = spr_playerN_haulingfall;
            spr_haulingmove = spr_playerN_haulingmove;
            spr_haulingland = spr_playerN_haulingland;
			
            spr_uppercutfinishingblow = spr_playerN_uppercut;
            spr_stunned = spr_playerN_stunned;
            spr_throw = spr_player_throw;
            spr_bossintro = spr_playerN_bossintro;
            spr_grind = spr_playerN_grind;
            spr_golfidle = spr_playerN_golfidle;
            spr_golfhit = spr_playerN_golfswing;
            spr_levelcomplete = spr_playerN_levelcomplete;
            spr_rageidle = spr_playerN_rageidle;
            spr_ragemove = spr_playerN_ragemove;
			
            spr_parry1 = spr_playerN_parry1;
            spr_parry2 = spr_playerN_parry2;
            spr_parry3 = spr_playerN_parry3;
			
            spr_charge = spr_playerN_charge;
            spr_punch = spr_playerN_punch;
            spr_Cheeseball = spr_playerN_cheeseball;
			
            spr_boxxedintro = spr_boxxedpep_intro;
            spr_boxxedidle = spr_boxxedpep_idle;
            spr_boxxedair = spr_boxxedpep_air;
            spr_boxxedjump = spr_boxxedpep_jump;
            spr_boxxedwalk = spr_boxxedpep_walk;
            spr_boxxeddash = spr_boxxedpep_dash;
            spr_boxxedslide = spr_boxxedpep_slide;
            spr_boxxedslidedown = spr_boxxedpep_slidedown;
            spr_boxxeddoublejump = spr_boxxedpep_doublejump;
            spr_boxxeddoublejumpfall = spr_boxxedpep_doublejumpfall;
			
            spr_cheeseintro = spr_cheesepep_intro;
            spr_cheeseidle = spr_cheesepep_idle;
            spr_cheesewalk = spr_cheesepep_walk;
            spr_cheesejumpstart = spr_cheesepep_jumpstart;
            spr_cheesejump = spr_cheesepep_jump;
            spr_cheesefall = spr_cheesepep_fall;
            spr_cheeseland = spr_cheesepep_land;
            spr_cheesestickceilling = spr_cheesepep_stickceilling;
            spr_cheesestickwall = spr_cheesepep_stickwall;
			
            spr_rocketdash = spr_player_rocketdash;
            spr_rocketdashstart = spr_player_rocketdashstart;
            spr_rocketstart = spr_player_rocketstart;
            spr_rockethitwall = spr_playerN_rockethitwall;
            spr_rocketrun = spr_player_rocketrun;
			
            spr_facestomp = spr_player_facestomp;
			
            spr_freefall = spr_playerN_machfreefall1;
            spr_freefallland = spr_playerN_bodyslamland;
			
            spr_Timesup = spr_playerN_timesup;
            spr_hang = spr_player_hang;
            spr_hangslide = spr_player_hangslide;
            spr_Dashpad = spr_playerN_dashpad;
			
            spr_supertaunt1 = spr_playerN_supertaunt1;
            spr_supertaunt2 = spr_playerN_supertaunt2;
            spr_supertaunt3 = spr_playerN_supertaunt3;
            spr_supertaunt4 = spr_playerN_supertaunt4;
			
            spr_shotgunpullout = spr_shotgun_pullout;
            spr_Shotgun = spr_player_shotgun;
            spr_shotgunidle = spr_shotgun_idle;
            spr_shotgunwalk = spr_shotgun_walk;
            spr_shotgunjump = spr_shotgun_jump;
            spr_shotgunfall = spr_shotgun_fall;
            spr_shotgunland = spr_shotgun_land;
            spr_shotgunsuplexdash = spr_shotgun_suplexdash;
            spr_shotgunjump1 = spr_player_shotgunjump1;
            spr_shotgunjump2 = spr_player_shotgunjump2;
            spr_shotgunjump3 = spr_player_shotgunjump3;
            spr_shotgunduck = spr_shotgun_duck;
            spr_shotguncrawl = spr_shotgun_crawl;
            spr_shotgungoduck = spr_shotgun_goduck;
            spr_shotguncrouchjump1 = spr_shotgun_crouchjump1;
            spr_shotguncrouchjump2 = spr_shotgun_crouchjump2;
			
            spr_slipbanan1 = spr_playerN_slipbanan1;
            spr_slipbanan2 = spr_playerN_slipbanan2;
            spr_slipbanan3 = spr_playerN_slipbanan3;
            spr_slipbananimpact = spr_playerN_rockethitwall;
			
            spr_suplexgrabcancel = spr_playerN_suplexcancel;
            spr_scaredjumpstart = spr_playerN_scaredjump1;
            spr_scaredjump = spr_playerN_scaredjump2;
            spr_faceplant = spr_playerN_spin;
            spr_airjugglestart = spr_player_jugglestart;
            spr_airjuggle = spr_player_juggle;
            spr_bodyslamjump = spr_player_bodyslamjump;
			
            spr_firemouth = spr_player_firemouth;
            spr_firemouthintro = spr_player_firemouthintro;
            spr_firemouthend = spr_player_firemouthend;
            spr_firemouthidle = spr_player_firemouthidle;
            spr_firemouthjump = spr_player_firemouthjump;
            spr_firemouthdash = spr_player_firemouthdash;
            spr_firemouthwalljump = spr_player_firemouthwalljump;
			
            spr_wallbump = spr_playerN_suplexbump;
            spr_presentjump = spr_playerN_superspring;
            spr_shoryukenstart = spr_playerN_breakdanceuppercut;
            spr_shoryuken = spr_playerN_breakdanceuppercutend;
            spr_fireworkride = spr_player_firework;
			
            spr_gnomecutscene1 = spr_player_gnomecutscene1;
            spr_gnomecutscene2 = spr_player_gnomecutscene2;
            spr_gnomecutscene3 = spr_player_gnomecutscene3;
            spr_gnomecutscene4 = spr_player_gnomecutscene4;
            spr_gnomecutscene5 = spr_player_gnomecutscene5;
			
            spr_sjumpcancelstart = spr_player_sjumpcancelstart;
            spr_sjumpcancel = spr_player_sjumpcancel;
            spr_shoulderbash = spr_playerN_spin;
			
            spr_airshoulderbashstart = spr_playerN_spinstart;
            spr_airshoulderbash = spr_playerN_spinloop;
			
            spr_kungfu1 = spr_player_kungfu1;
            spr_kungfu2 = spr_player_kungfu2;
            spr_kungfu3 = spr_player_kungfu3;
            spr_kungfuair1start = spr_player_kungfuair1start;
            spr_kungfuair2start = spr_player_kungfuair2start;
            spr_kungfuair3start = spr_player_kungfuair3start;
            spr_kungfuair1 = spr_player_kungfuair1;
            spr_kungfuair2 = spr_player_kungfuair2;
            spr_kungfuair3 = spr_player_kungfuair3;
            spr_kungfubump = spr_player_kungfubump;
			
            spr_noisewalljump = spr_player_kungfubump;
			
            spr_barrelidle = spr_player_barrelidle;
            spr_barrelmove = spr_player_barrelmove;
            spr_barreljump = spr_player_barreljump;
            spr_barrelfall = spr_player_barrelfall;
            spr_barrelland = spr_player_barrelland;
            spr_barrelslipnslide = spr_player_barrelslipnslide;
            spr_barrelroll = spr_player_barrelroll;
			
            spr_Weeniemount = spr_player_weeniemount;
            spr_Weeniemountturn = spr_player_weeniemountturn;
			
            spr_wallsplat = spr_playerN_wallsplat;
            spr_emo = spr_player_emo;
            spr_palette = spr_peppalette;
            spr_pause = spr_pausenoise;
			
            spr_newhudidle1 = spr_tv_idleN;
            spr_newhudidle2 = spr_tv_idleanim1N;
            spr_newhudidle3 = spr_tv_idleanim2N;
            spr_newhudidle4 = spr_tv_idleanim3N;
            spr_newhudknight = spr_tv_knightN;
            spr_newhudhurt = spr_tv_exprhurtN;
            spr_newhudball = spr_tv_tumbleN;
            spr_newhudhappy = spr_tv_exprcollectN;
            spr_newhudpanic = spr_tv_exprpanicN;
            spr_newhudfireass = spr_tv_fireassN;
            spr_newhudmach3 = spr_tv_exprmach3N;
            spr_newhudmach4 = spr_tv_exprmach4N;
            spr_newhudgolf = spr_tv_golfN;
            spr_newhudbomb = spr_tv_bombpepN;
            spr_newhudrage = spr_tv_exprcomboN;
            spr_newhudevil = spr_tv_exprcomboN;
            spr_newhudshotgun = spr_peppinohud_shotgun;
            spr_newhudcheeseball = spr_peppinohud_cheeseball;
            spr_newhudfiremove = spr_peppinohud_firemove;
            spr_newhudboxxed = spr_peppinohud_boxxed;
            spr_newhudfiremouth = spr_peppinohud_firemouth;
            spr_newhudbarrel = spr_peppinohud_barrel;
            spr_newhudscaredjump = spr_peppinohud_scaredjump;
            spr_newhudrocket = spr_peppinohud_rocket;
            spr_newhudweenie = spr_peppinohud_weenie;
            spr_newhudsecret = spr_tv_idleN;
            spr_bosshud = spr_playerbosshud;
            spr_bosshudhurt = spr_playerbosshudhurt;
			
            spr_smallidle = spr_smallpep_idle;
            spr_smallwalk = spr_smallpep_walk;
            spr_smalljump = spr_smallpep_jump;
            spr_smallfall = spr_smallpep_fall;
            spr_smallland1 = spr_smallpep_landidle;
            spr_smallland2 = spr_smallpep_landwalk;
            spr_smalldashstart = spr_smallpep_dashstart;
            spr_smalldash = spr_smallpep_dashloop;
            spr_smallhurt = spr_smallpep_hurt;
            spr_smallstompprep = spr_smallpep_stompprep;
            spr_smallstomp = spr_smallpep_stomp;
            spr_smalldead = spr_smallpep_dead;
			
            spr_prank = spr_rankP;
            spr_srank = spr_rankS;
            spr_arank = spr_rankA;
            spr_brank = spr_rankB;
            spr_crank = spr_rankC;
            spr_drank = spr_rankD;
            break;
		#endregion
    }
}
