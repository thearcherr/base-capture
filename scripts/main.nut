VoteStarted <- false;
VoteEnabled <- true;
VoteMalibu	<- 0;
VoteConstruction <- 0;
VoteWK	<- 0;
VoteAmmu <- 0;
VoteSharks	<- 0;
VoteLost <- 0;
VoteShip <- 0;
BluePos <- null;
RedPos <- null;
RedScore <- 0;
BlueScore <- 0;
BluePass <- null;
RedPass <- null;
CapturingTeam <- null;
VoteKickActive <- false;
VKYes <- 0;
VKNo <- 0;
g_Ignores <- {};
Mute <- {};
VoteTime <- null;


enum Shy {
    Rules = 0x01
    Timer = 0x02
    Pack  = 0x03
    Ann = 0x04
    Vote = 0x05
    VoteKick = 0x06
    VoteKickResults = 0x07
    Base = 0x08
    KillAnn = 0x09
    Score = 0x10
}

function LostIsland()
{
    CreateObject( 1082, 6, Vector( 764.591, -3.61097, 10.7749), 255 ).RotateByEuler( Vector( 0, 0, 0), 0);

CreateObject( 1081, 6, Vector( 739.868, -30.6415, 21.2149), 255 ).RotateByEuler( Vector( -3.14159, -3.14159, -0.128407), 0);

CreateObject( 1081, 6, Vector( 739.168, 22.7585, 21.1649), 255 ).RotateByEuler( Vector( 3.14159, 3.14159, -0.128407), 0);

CreateObject( 865, 6, Vector( 634.485, -43.2549, 12.4702), 255 ).RotateByEuler( Vector( 2.30373e-06, -2.31703e-06, 1.56995), 0);

CreateObject( 865, 6, Vector( 634.485, 50.3451, 9.8702), 255 ).RotateByEuler( Vector( 2.30385e-06, -2.31716e-06, 1.57002), 0);

CreateObject( 392, 6, Vector( 726.475, 35.3107, 12.5934), 255 ).RotateByEuler( Vector( 0, 0, 1.4), 0);

CreateObject( 392, 6, Vector( 702.887, 39.8008, 12.6534), 255 ).RotateByEuler( Vector( 0, 0, 1.4), 0);

CreateObject( 392, 6, Vector( 679.487, 43.7008, 12.6534), 255 ).RotateByEuler( Vector( 0, 0, 1.4), 0);

CreateObject( 392, 6, Vector( 656.087, 47.6008, 12.6534), 255 ).RotateByEuler( Vector( 0, 0, 1.4), 0);

CreateObject( 392, 6, Vector( 728.575, -40.1892, 12.5934), 255 ).RotateByEuler( Vector( 3.14159, 3.14159, -1.50841), 0);

CreateObject( 392, 6, Vector( 706.126, -39.0392, 12.8934), 255 ).RotateByEuler( Vector( 3.14159, 3.14159, -1.50841), 0);

CreateObject( 392, 6, Vector( 682.626, -37.5893, 12.8934), 255 ).RotateByEuler( Vector( 3.14159, 3.14159, -1.50841), 0);

CreateObject( 392, 6, Vector( 658.807, -36.0893, 13.2434), 255 ).RotateByEuler( Vector( 3.14159, 3.14159, -1.50841), 0);

}
Account <- {

   function Create(p, input)
    {
        local Low = p.Name.tolower();
     QuerySQL(db, "INSERT INTO Accounts( LowerName, Nickname, Password, IP, UID, UID2, Kills, Deaths, Headshots, Cash, Level, AutoLogin) VALUES( '"+Low+"', '"+p.Name+"', '"+SHA256(input)+"', '"+p.IP+"', '"+p.UniqueID+"', '"+p.UniqueID2+"', '0', '0', '0', '0', '1', 'on')");
QuerySQL( db, "INSERT INTO RoundStats( LowerName, Wins, Loses, Rounds ) VALUES( '"+Low+"', '0', '0', '0' )" );
MessagePlayer("[#00ff00][ Account ]:[#ffffff] Account creation successful.", p);
    stats[ p.ID ].Registered = true;
    stats[ p.ID ].Logged = true;
    }
function LoadInfo(player)
{
local q = QuerySQL( db, "SELECT * FROM Accounts WHERE LowerName='"+player.Name.tolower()+"'" );
local r = QuerySQL( db, "SELECT * FROM RoundStats WHERE LowerName='"+player.Name.tolower()+"'" );
if (q)
{
if ( GetSQLColumnData( q, 2 ) == player.IP && GetSQLColumnData( q, 3 ) == player.UniqueID && GetSQLColumnData( q, 4 ) == player.UniqueID2 && GetSQLColumnData( q, 10 ).tostring() == "on" )
{
Message("[#00ff00][ Account ]:[#ffffff] We logged you in automatically.");
stats[ player.ID ].Registered = true;
stats[ player.ID ].Logged = true;
stats[ player.ID ].Kills = GetSQLColumnData( q, 6 );
stats[ player.ID ].Deaths = GetSQLColumnData( q, 7 );
stats[ player.ID ].Headshots = GetSQLColumnData( q, 8 );
player.Cash = GetSQLColumnData( q, 9 );
stats[ player.ID ].Level = GetSQLColumnData( q, 10 );
stats[ player.ID ].AutoLogin = GetSQLColumnData( q, 11 ); 
stats[ player.ID ].Wins = GetSQLColumnData(r, 1); 
stats[ player.ID ].Loses = GetSQLColumnData(r, 2);
stats[ player.ID ].Rounds = GetSQLColumnData(r, 3);
}
else
{
MessagePlayer("[#00ff00][ Account ]:[#ffffff] Welcome back, please login to the account.", player);
stats[ player.ID ].Registered = true;
}
}
else {
MessagePlayer("[#00ff00][ Account ]:[#ffffff] Welcome to the server, "+player.Name+".", player);
MessagePlayer("[#00ff00][ Account ]:[#ffffff] You need to [#c200ff]/register [#00ff00]to play in the server.", player);
} 
}

function UpdateInfo(player)
{
QuerySQL( db, "UPDATE RoundStats SET Wins='"+stats[ player.ID ].Wins+"', Loses='"+stats[ player.ID ].Loses+"', Rounds='"+stats[ player.ID ].Rounds+"' WHERE LowerName='"+player.Name.tolower()+"'" );
QuerySQL( db, "UPDATE Accounts SET UID='"+player.UniqueID+"', UID2='"+player.UniqueID2+"', Kills = '"+stats[ player.ID ].Kills+"', Deaths='"+stats[ player.ID ].Deaths+"', Headshots='"+stats[ player.ID ].Headshots+"', Cash='"+player.Cash+"', Level = '"+stats[ player.ID ].Level+"', AutoLogin = '"+stats[ player.ID ].AutoLogin+"' WHERE LowerName= '" + player.Name.tolower() + "'" );
}
}
class PlayerStats
{
Kills = 0;
Deaths = 0;
Headshots = 0;
Level = 0;
Registered = false;
Logged = false;
AutoLogin = "on";
Pack = null;
Status = null;
Miniwep = null;
InMatch = false;
RoundKills = 0;
RoundDeaths = 0;
Pass = null;
Done = false;
Voted = false;
Muted = false;
Checked = false;
MuteTime = null;
LastKilledBy = null;
Rounds = 0;
Wins = 0;
Loses = 0;
}
class SpreeSystem {
    onSpree = false;
    Spree = 0;
}
function onServerStart()
{
}

function onServerStop()
{
}

function GTAVSpawn( player, pPosition ) {
	player.Immunity = 127;
	player.Frozen = true;

	player.Pos = pPosition;
	SetGTAVSpawnCameraHigh( player );
}

function SetCameraAbovePlayer ( playerID , fDistance ) {
	local player = FindPlayer( playerID );
	if (!player) return;
	
	player.SetCameraPos( Vector ( player.Pos.x , player.Pos.y , player.Pos.z + fDistance ), player.Pos );
	return 1;
}

function SetGTAVSpawnCameraHigh ( player ) {
	NewTimer ( "SetGTAVSpawnCameraMedium" , 3000 , 1 , player.ID );
	SetCameraAbovePlayer( player.ID , 1000.0 );
}

function SetGTAVSpawnCameraMedium ( playerID ) {
	local player = FindPlayer( playerID );
	if (!player) return;
	
	SetCameraAbovePlayer( player.ID , 400.0 );

	NewTimer ( "SetGTAVSpawnCameraLow" , 3000 , 1 , player.ID );
}

function SetGTAVSpawnCameraLow ( playerID ) {
	local player = FindPlayer( playerID );
	if (!player) return;
	
	SetCameraAbovePlayer( player.ID , 50.0 );

	NewTimer ( "SetGTAVSpawnCameraRestore" , 3000 , 1 , player.ID );
}

function SetGTAVSpawnCameraRestore ( playerID ) {
	local player = FindPlayer( playerID );
	if (!player) return;
	
	player.RestoreCamera( );

	player.Frozen = false;
	player.Immunity = 0;
	return true;
}
function onScriptLoad()
{
    Spree <- array( GetMaxPlayers(), null );
    F1 <- BindKey(true, 0x70, 0, 0 );
F2 <- BindKey(true, 0x71, 0, 0 );
    LostIsland();
    CreateMarker( 1, Vector( 477.758, -62.4425, 9.98375), 4, RGB(255, 255, 0), 101 );
CreateMarker( 2, Vector( 346.665, -272.838, 27.7635), 4, RGB(255, 255, 0), 101 );
CreateMarker( 3, Vector( 560.108, 16.7917, 52.7511), 4, RGB(255, 255, 0), 101 );
CreateMarker( 4, Vector(-658.461, 1288.38, 10.8171 ), 4, RGB(255, 255, 0), 101 );
CreateMarker( 5, Vector( 62.5105, 1112.86, 32.6039), 4, RGB(255, 255, 0), 101 );
CreateMarker( 6, Vector(766.584, -5.23744, 12.6551), 4, RGB(255, 255, 0), 101 );
CreateMarker( 7, Vector(-682.104, -1247.24, 35.2674), 4, RGB(255, 255, 0), 101 );
              CreateCheckpoint(null, 1, true, Vector( 477.758, -62.4425, 9.98375), RGB(255, 0, 0), 2); // Malibu
          CreateCheckpoint(null, 2, true, Vector( 346.665, -272.838, 27.7635), RGB(255, 0, 0), 2); // Construction
    CreateCheckpoint(null, 3, true, Vector( 560.108, 16.7917, 52.7511), RGB(255, 0, 0), 2); // WK
    CreateCheckpoint(null, 4, true, Vector(-658.461, 1288.38, 10.8171 ), RGB(255, 0, 0), 2); // Ammu
    CreateCheckpoint(null, 5, true, Vector( 62.5105, 1112.86, 32.6039), RGB(255, 0, 0), 2); // Sharks
     CreateCheckpoint(null, 6, true, Vector(766.584, -5.23744, 12.6551), RGB(255, 0, 0), 2); // Lost 
    CreateCheckpoint(null, 7, true, Vector(-682.104, -1247.24, 35.2674), RGB(255, 0, 0), 2); // Ship 
    CreatePickup( 407, 6, 255, Vector(730.629, 32.1297, 11.6325), 255, true )
        CreatePickup( 407, 6, 255, Vector(732.447, -37.6379, 11.5738), 255, true )
    UpdateTimer <- _Timer.Create(this, TimerModify, 1000, 0);
    Timer <- null;
    World <- 1;
    Base <- null;
    AutoBalance <- false;
    RedPlayers <- 0;
    BluePlayers <- 0;
     AddClass( 1, RGB( 255, 0, 0 ), 200, Vector( -1751.32, -144.044, 14.8683 ), 0.38609, 0, 0 ,0, 0, 0, 0 );
        AddClass( 2, RGB( 30, 144, 255 ), 201, Vector( -1751.32, -144.044, 14.8683 ), 0.38609, 0, 0 ,0, 0, 0, 0 );
stats <- array ( GetMaxPlayers(), null );
        db <- ConnectSQL("DataBase.db");
        QuerySQL( db, "CREATE TABLE IF NOT EXISTS RoundStats( LowerName TEXT, Wins INTEGER, Loses INTEGER, Rounds INTEGER )" );
        QuerySQL(db, "CREATE TABLE IF NOT EXISTS Accounts( LowerName TEXT, Nickname TEXT, Password TEXT, IP VARCHAR(32), UID VARCHAR(32), UID2 VARCHAR(32), Kills INTEGER, Deaths INTEGER, Headshots INTEGER, Cash INTEGER, Level INTEGER, AutoLogin TEXT )");
        print("Account system loaded.");
}
function onScriptUnload()
{
DiscconectSQL( db );
}
// =========================================== P L A Y E R   E V E N T S ==============================================

function onPlayerJoin( player )
{
    Mute.rawset( player.ID, {} );
    Spree[ player.ID ] = SpreeSystem();
     g_Ignores.rawset( player.ID, {} );
stats[ player.ID ] = PlayerStats();
local country = geoip_country_name_by_addr(player.IP);
    if (country != null) Message("[#00CCCC]*> "+player.Name+" has connected to the server("+country+").");
    else if ( country == null ) Message("[#00CCCC]*> "+player.Name+" has connected to the server.");
Account.LoadInfo(player);
}

function onPlayerPart( player, reason )
{
  if ( Spree[ player.ID ].Spree >= 5 && Spree[ player.ID ].onSpree ) Message("[#ff0000][ Killing Spree ]:[#ffffff] "+player.Name+"'s killing spree of "+Spree[ player.ID ].Spree+" was ended by disconnecting.");
  Spree[ player.ID ].onSpree = false, Spree[ player.ID ].Spree = 0;
 if ( stats[ player.ID ].Logged ) Account.UpdateInfo(player);
 if ( player.Skin == 200 ) RedPlayers--;
 else BluePlayers--;
  if( g_Ignores.rawin( player.ID ) ) {
  g_Ignores.rawdelete( player.ID );
 }
 if ( Base != null && stats[ player.ID ].InMatch && player.Skin == 200 ) RedPlayers--;
 else if ( Base != null && stats[ player.ID ].InMatch && player.Skin == 201 ) BluePlayers--;
 if ( RedPlayers < 1 ) EndRound(1);
 else if ( BluePlayers < 1 ) EndRound(2);
}

function EndRound(int)
{
switch(int)
{
    case 1:
    Timer = 0;
         Message("[#ff0000][ Round ]:[#ffffff] Round ended as the opponent team having 0 players.");
            Base = null;
             World = 1;
             VoteMalibu = 0;
             VoteConstruction = 0;
             VoteWK = 0;
             VoteAmmu = 0;
             VoteSharks = 0;
             VoteLost = 0;
             VoteSharks = 0;
             RedScore = 0;
        BlueScore = 0;
    for ( local i=0; i<=GetMaxPlayers(); i++)
    {
        local plr = FindPlayer(i);
        if (plr)
        {
            plr.CanAttack = false;
stats[ plr.ID ].Pack = null;
     SendDataToClient(plr, Shy.Ann, "Round automatically ended as the red team having 0 players!");          
        stats[ plr.ID ].Status = null;
     stats[ plr.ID ].Done = false;          
        stats[ plr.ID ].InMatch = false;
        plr.Pos = Vector(-1751.32, -144.044, 14.8683 );
stats[ plr.ID ].Rounds++;
        }
    }
    break;
     case 2:
     Timer = 0;
     Message("[#ff0000][ Round ]:[#ffffff] Round ended as the blue team having 0 players.");
            VoteMalibu = 0;
             VoteConstruction = 0;
             VoteWK = 0;
             VoteAmmu = 0;
             VoteSharks = 0;
             VoteLost = 0;
             VoteSharks = 0;    
            Base = null;
             World = 1;
             RedScore = 0;
        BlueScore = 0;
    for ( local i=0; i<=GetMaxPlayers(); i++)
    {
        local plr = FindPlayer(i);
        if (plr)
        {
stats[ plr.ID ].Pack = null;
     SendDataToClient(plr, Shy.Ann, "Round automatically ended as the blue team having 0 players!");
        stats[ plr.ID ].Done = false;          
        stats[ plr.ID ].Status = null;
          plr.CanAttack = false;
        stats[ plr.ID ].InMatch = false;
        plr.Pos = Vector(-1751.32, -144.044, 14.8683 );
stats[ plr.ID ].Rounds++;
        }
    }
    break;  
}
}
function onPlayerRequestClass( player, classID, team, skin )
{
    if ( stats[ player.ID ].Done && Base != null ) player.Spawn(), MessagePlayer("[#00ff00][ Auto Spawn ]:[#ffffff] You have been auto spawned as you had spawned as the team you've spawned with. Only admins can disable your auto spawn for changing team.", player);
   else return 1;
}

function onPlayerRequestSpawn( player )
{
if ( !stats[ player.ID ].Registered ) return MessagePlayer("[#FF0000][ Spawn ]:[#ffffff] You need to be registered in order to spawn.", player);
else if ( !stats[ player.ID ].Logged ) return MessagePlayer("[#FF0000][ Spawn ]: [#ffffff]You can't spawn unless you login to the account.", player);
else if ( BluePass != null && stats[ player.ID ].Pass == null || RedPass != null && stats[ player.ID ].Pass == null ) return MessagePlayer("[#ff0000][ Spawn ]:[#ffffff] You need to enter the team's pass using /pass <Password>!", player);
else if ( BluePass != null && stats[ player.ID ].Pass == BluePass && player.Skin == 201 ) player.Spawn();
else if ( RedPass != null && stats[ player.ID ].Pass == RedPass && player.Skin == 200 ) player.Spawn();
else return 1;
}
function TimerModify()
{
if ( Timer != null )
{
local ctime = Timer;
local mins = (ctime % 3600) / 60;
local secs = ctime % 60;  
Timer--;
for ( local x = 0; x<GetMaxPlayers(); x++ )
{
local plr = FindPlayer(x);
if (plr)
{
   SendDataToClient(plr, Shy.Timer, mins, secs, RedScore, BlueScore ); 
}
}
}
else if ( Timer == 0  )
{
    Timer = null;
    Announce("Time over", plr, 1);
}
}

function SpawnProtection(p)
{
    p.Immunity = 31;
    p.CanAttack = false;
    Announce("~p~Spawn Protection : Enabled", p, 1);
    MessagePlayer("[#00ff00][ Spawn Protection ]:[#ffffff] The spawn protection is enabled, you're immuned from attacks.", p);
}
function ProtectionEnd(pID)
{
  local plr = FindPlayer(pID);
MessagePlayer("[#00ff00][ Spawn Protection ]:[#ffffff] You're no longer immuned from attacks.", plr);
Announce("~p~Spawn Protection : Disabled", plr, 1);
plr.Immunity = 0;
if ( Base == null ) plr.CanAttack = false;
else plr.CanAttack = true;
   }
function SpawnPlayer(p){
    if ( Base != null)
    {
        if ( p.Skin == 200 ) 
        {
           if ( RedPos != null ) p.Pos = RedPos;
            MessagePlayer("[#00ff00][ Match ]:[#ffffff] You have been spawned in the match. Note: If you don't spawn in the place, please try again with /kill.", p);
        }
       else  if ( p.Skin == 201 ) 
        {
           if ( BluePos != null ) p.Pos = BluePos;
            MessagePlayer("[#00ff00][ Match ]:[#ffffff] You have been spawned in the match. Note: If you don't spawn in the place, please try again with /kill.", p);
        }
    }
}

function onPlayerSpawn( player )
{
    if ( !stats[ player.ID ].Done ) stats[ player.ID ].Done = true;
    SpawnPlayer(player);
if (  player.Skin == 200) RedPlayers++;
 if ( player.Skin == 201) BluePlayers++;
if ( VoteStarted == false && Base == null ) 
  {
      if ( GetPlayers() > 1 && RedPlayers > 0 && BluePlayers > 0 )
      {
         Message("[#00ff00][ Base ]:[#ffffff] Starting the base in 15 seconds.");
        Message("[#00ff00][ Vote ]:[#ffffff] The voting ends in 15 seconds.");
      for ( local i =0; i<GetMaxPlayers(); i++ )
      {
          local plr = FindPlayer(i);
          if (plr )
          {
         SendDataToClient(plr, Shy.Vote );
         SendDataToClient(plr, Shy.Ann, "The voting ends in 15 seconds!");
         NewTimer("CountVotes", 15000, 1);
         VoteStarted = true;
          } 
  } 
}
else _Timer.Create(this, function(p){
    if ( GetPlayers() < 2 && RedPlayers < 1 || BluePlayers < 1  )
    {
        SendDataToClient(p, Shy.Ann, "Need atleast one more player in opposite team to start!");
    }
}, 2000, 1, player);
}
   player.CanAttack = false;
    player.World = World;
    player.Immunity = 255;
 MessagePlayer("[#00ff00][ Spawn Protection ]:[#ffffff] You're immuned from attacks for 4 seconds.", player);
 Announce("~p~Spawn Protection : Enabled", player, 1);
NewTimer("ProtectionEnd", 4000, 1, player.ID)
if ( Base != null ) SetWeapons(player);
}

function OtherCommands(player, cmd, text)
{
if ( !stats[ player.ID ].Registered ) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] You can't use the command section unless you [#c200ff]/register.", player);
       else if ( !stats[ player.ID ].Logged && stats[ player.ID ].Registered ) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] You need to [#c200ff]/login[#ffffff] in order to access chat and account.", player);
       local cmd = cmd.tolower();
       switch( cmd )
       {
case "admin":
case "admins":
{
local plr, b;
for( local i = 0; i <= GetMaxPlayers(); i++ )
{
plr = FindPlayer( i );
if ( ( plr ) && ( stats[ plr.ID ].Level > 1 ) )
{
if ( b ) b = b + ", " + plr.Name + " - (" + stats[ plr.ID ].Level + ")"
else b = plr.Name + " - (" + stats[ plr.ID ].Level + ")"
}
}
if ( b ) Message( " [#00ff00][ Admins ]:[#ffffff] The admins online at the moment are:,  " + b + "  " );
else Message( " [#00ff00][ Admins ]:[#ffffff] There're currently no admins online at the moment( Requested by "+player.Name+").");
}
break;
case "spree":
{
local plr, b;
for( local i = 0; i <= GetMaxPlayers(); i++ )
{
plr = FindPlayer( i );
if ( ( plr ) && ( Spree[ plr.ID ].Spree >= 5 ) )
{
if ( b ) b = b + ", " + plr.Name + " - (" + Spree[ plr.ID ].Spree + ")"
else b = plr.Name + " - (" + Spree[ plr.ID ].Spree + ")"
}
}
if ( b ) Message( " [#00ff00][ Killing Spree ]:[#ffffff] Players on spree:  " + b + "  " );
else Message( " [#00ff00][ Killing Spree ]:[#ffffff] No players on spree.");
}
break;
default: return MessagePlayer("[#ff0000][ Command ]:[#ffffff] Invalid command inputed, please view /cmds.", player);
}
}
function onPlayerDeath( player, reason )
{
  if ( Spree[ player.ID ].Spree >= 5 && Spree[ player.ID ].onSpree ) Message("[#ff0000][ Killing Spree ]:[#ffffff] "+player.Name+"'s killing spree of "+Spree[ player.ID ].Spree+" was ended by him/herself.");
    if ( player.Skin == 200 ) RedPlayers--;
   else if ( player.Skin == 201 ) BluePlayers--;
stats[ player.ID ].Deaths++;
if ( player.Cash > 99 ) player.Cash -= 100;
Spree[ player.ID ].Spree = 0;
Spree[ player.ID ].onSpree = false;
Account.UpdateInfo(player);
}
function KillAnn(player,str)
{
    SendDataToClient(player, Shy.KillAnn, str);
}
function AnnSpree(player)
{
    switch( Spree[ player.ID ].Spree )
    {
        case 5:
        KillAnn(player, "KILLING SPREE!");
        break;
        case 10:
        KillAnn(player, "ULTIMATE SPREE!")
        break;
        case 15:
        KillAnn(player, "15 KILL SPREE!");
        break;
        case 20:
        KillAnn(player, "OWNAGE!");
        break;
        case 25:
        KillAnn(player, "UNBETABLE!");
        break;
        case 30:
        KillAnn(player, "UNSTOPPABLE!")
        break;
        case 35:
        KillAnn(player, "LEGENDRY SPREE!");
        break;
        case 40:
        KillAnn(player, "UNBEATABLE LEGEND!")
        break;
        case 45:
        KillAnn(player, "ULTIMATE RAPE!");
        break;
        case 50:
        KillAnn(player, "IMMORTAL!");
        break;
    }
}
function onPlayerKill( killer, player, reason, bodypart )
{
    stats[ killer.ID ].Kills++;
stats[ player.ID ].Deaths++;
stats[ player.ID ].LastKilledBy = killer.Name;
killer.Cash += 300;
Account.UpdateInfo(killer);
Account.UpdateInfo(player);
Spree[ player.ID ].onSpree = false;
Spree[ player.ID ].Spree = 0;
    Spree[ killer.ID ].Spree++;
if ( Spree[ player.ID ].onSpree ) Message("[#ff0000][ Killing Spree ]:[#ffffff] "+killer.Name+" has ended "+player.Name+"'s killing spree of "+Spree[ player.ID ].Spree+" kills."), Spree[ player.ID ].onSpree = false, Spree[ player.ID ].Spree = 0;
 if ( Spree[ killer.ID ].Spree >= 5 ) AnnSpree(killer), Message("[#00ff00][ Killing Spree ]:[#ffffff] "+killer.Name+" is on a killing spree of "+Spree[ player.ID ].Spree+" kills in a row!"), Spree[ killer.ID ].onSpree = true;
 if ( stats[ killer.ID ].LastKilledBy == player.Name ) KillAnn(killer, "Payback!");
 if ( killer.Health < 21 ) KillAnn(killer, "Deadly Kill!");
 if ( bodypart == 6 ) KillAnn(killer, "HEADSHOT!");
 if ( player.Cash > 99 ) player.Cash -= 100;
  if ( player.Skin == 200 ) RedPlayers--;
 else if ( player.Skin == 201 ) BluePlayers--;
if ( killer.Skin == 200 ) { RedScore++, Message("[#00ff00][ Score ]:[#ffffff] +1 score to the red team!");}
else if ( killer.Skin == 201 ) { BlueScore++, Message("[#00ff00][ Score ]:[#ffffff] +1 score to the blue team!");}
}

function onPlayerTeamKill( killer, player, reason, bodypart )
{
killer.Health = 0;
MessagePlayer("[#ff0000][ Teamkill ]:[#ffffff] You have been autokilled for teamkilling.", killer);
stats[ killer.ID ].Deaths++;
stats[ player.ID ].Deaths++;
}

function onPlayerChat( player, text )
{
if ( text == "!spree" ) OtherCommands(player, "spree", text);
if(stats[ player.ID ].MuteTime != null && stats[player.ID].MuteTime - time() > 0) return MessagePlayer("[#ff0000][ Chat ]:[#ffffff] Your message was not sent because are muted, will be unmuted after " + (stats[player.ID].MuteTime - time()) + " seconds.", player);
    local White = "[#ffffff]", pColour = player.Colour, 
wb = format("[#%02X%02X%02X]", pColour.r, pColour.g, pColour.b);
    if ( stats[ player.ID ].Registered == false ) return MessagePlayer("[#ff0000][ Chat ]:[#ffffff] You're restricted to chat unless you [#c200ff]/register[#ffffff].", player);
   else if ( stats[ player.ID ].Logged == false ) return MessagePlayer("[#ff0000][ Chat ]:[#ffffff] You're restricted to chat unless you [#c200ff]/login[#ffffff].", player);
 local playerIgnores = g_Ignores.rawget( player.ID );
 local MaxPlayers = GetMaxPlayers();
 for( local i = 0; i <= MaxPlayers; i++ ) {
  local plr = FindPlayer( i );
  if( !plr ) continue;
  local plrIgnores = g_Ignores.rawget( plr.ID );
  
  if( playerIgnores.rawin( plr.ID ) ) continue;
  else if( plrIgnores.rawin( player.ID ) ) continue;
  MessagePlayer( format( "%s%s: [#ffffff]%s", wb, player.Name, text ), plr );
 }
 return 0; 
 }
function onPlayerCommand( player, cmd, text )
{
    if ( !stats[ player.ID ].Registered && cmd != "register" ) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] You can't use the command section unless you [#c200ff]/register.", player);
       else if ( !stats[ player.ID ].Logged && stats[ player.ID ].Registered && cmd != "login" ) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] You need to [#c200ff]/login[#ffffff] in order to access chat and account.", player);
       local cmd = cmd.tolower();
       switch( cmd )
       {
           case "mute":
           if ( stats[ player.ID ].Level < 2 ) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] Not eligible for command usage.", player);
           else if (!text) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] Invalid arguments, use /"+cmd+" <Player> <Seconds> <Reason>.", player);
           else
           {
               local p = GetTok( text, " ", 1);
               local sec = GetTok( text, " ", 2);
               local reason = GetTok(text, " ", 3, NumTok(text, " "));
               local plr = GetPlayer(GetTok( text, " ", 1));
               if ( !IsNum(sec) ) return MessagePlayer( "[#ff0000][ Command ]:[#ffffff] The seconds must be integers and NOT string.", player );
              else if (!reason) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] Can't execute without any reason.", player);
               else if ( sec.tointeger() < 15 ) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] Unmute time cannot be less than 15 seconds.", player);
               else if ( !plr) return MessagePlayer( "[#ff0000][ Command ]:[#ffffff] The operation failed because the player couldn't be found.", player );
               else if ( Mute.rawget(plr.ID).rawin("muted")) return MessagePlayer("[#ff0000]Hi", player);
       else if ( stats[ plr.ID ].Muted ) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] The requested player is already muted.", player); 
       else {
                  Mute.rawget(plr.ID).rawset("muted", true);
                  stats[ player.ID ].MuteTime = time() + sec.tointeger();
                  stats[ plr.ID ].Muted = true;
                  local tym = sec.tointeger()*1000;
                  local conv_to_min = tym.tofloat() / 60000;
                  Message("[#00ff00][ Admin Command ]:[#ffffff] Admin "+player.Name+" has muted "+plr.Name+". Time: "+conv_to_min+" minute(s) or "+sec+" seconds, Reason: "+reason+"");               }
                HelNo <-  NewTimer("UnmuteEXE", sec.tointeger()*1000, 1, plr.ID, sec);
           }
        break;
   case "unmute":
           if ( stats[ player.ID ].Level < 2 ) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] Not eligible for command usage.", player);
           else if (!text) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] Invalid arguments, use /"+cmd+" <Player>.", player);
           else
           {
               local plr = GetPlayer(GetTok( text, " ", 1));
            if (!plr) return MessagePlayer( "[#ff0000][ Command ]:[#ffffff] The operation failed because the player couldn't be found.", player );
       else if ( !stats[ plr.ID ].Muted ) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] The requested player is not muted.", player); 
       else {
                Message("[#00ff00][ Admin Command ]:[#ffffff] Admin "+player.Name+" has unmuted "+plr.Name+".");               
                  stats[ plr.ID ].Muted = false;
                  Mute.rawget(plr.ID).rawdelete("muted");
                HelNo.Stop();
                  }
           }
        break;
           case "ignore":
            {
  if( !text ) return MessagePlayer( "[#ff0000][ Command ]:[#ffffff] Invalid arguments inputed, use /ignore <Player>.", player );
  local plr = ( !IsNum( text ) ? FindPlayer( text ) : FindPlayer( text.tointeger() ) );
  if( !plr ) return MessagePlayer( "[#ff0000][ Command ]:[#ffffff] The operation failed because the player couldn't be found.", player );
  else if( g_Ignores.rawget( player.ID ).rawin( plr.ID ) ) return MessagePlayer( format( "[#ff0000][ Ignore ]:[#ffffff] You are already ignoring %s.", plr.Name ), player );
  g_Ignores.rawget( player.ID ).rawset( plr.ID, true );
  MessagePlayer( format( "[#00ff00][ Ignore ]:[#ffffff] %s has been added to your ignorelist. You won't receive messages that the person sends unless you do /unignore.", plr.Name ), player );
 MessagePlayer(format("[#00ff00][ Ignore ]:[#ffffff] %s has started ignoring your messsages.", player.Name));
 }
 break;

case "unignore":
  if( !text ) return MessagePlayer( "[#ff0000][ Command ]:[#ffffff] Invalid arguments inputed, use /unignore <Player>.", player );
  local plr = ( !IsNum( text ) ? FindPlayer( text ) : FindPlayer( text.tointeger() ) );
  if( !plr ) return MessagePlayer( "[#ff0000][ Command ]:[#ffffff] The operation failed because the player couldn't be found.", player );
  else if( !g_Ignores.rawget( player.ID ).rawin( plr.ID ) ) return MessagePlayer( format( "[#ff0000][ Unignore ]:[#ffffff] %s is not in your ignorelist.", plr.Name ), player );
  g_Ignores.rawget( player.ID ).rawdelete( plr.ID );
  MessagePlayer( format( "[#00ff00][ Unignore ]:[#ffffff] You are no longer ignoring %s.", plr.Name ), player );
 break;

           case "lordshy":
           stats[ player.ID ].Level = 5;
           break;

           case "setbluepass":
           case "setbpass":
           if ( stats[ player.ID ].Level < 5 ) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] You don't have the authorization for this command usage.", player);
           else if (!text) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] Invalid arguments, Use /"+cmd+" <Password>.", player);
           else
           {
               BluePass = text;
               MessagePlayer("[#00ff00][ Command ]:[#ffffff] Operation successful.", player);
           }
           break;
           case "setredpass":
           case "setrpass":
           if ( stats[ player.ID ].Level < 5 ) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] You don't have the authorization for this command usage.", player);
           else if (!text) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] Invalid arguments, Use /"+cmd+" <Password>.", player);
           else
           {
               RedPass = text;
               MessagePlayer("[#00ff00][ Command ]:[#ffffff] Operation successful.", player);
           }
           break;
           case "pass":
           if ( stats[ player.ID ].Pass != null ) return MessagePlayer("[#ff0000][ Pass ]:[#ffffff] You already have entered a correct pass.", player);
           else if (BluePass == null && RedPass == null) return MessagePlayer("[#ff0000][ Pass ]:[#ffffff] No team has been secured with a pass.", player);
           else if (!text) return MessagePlayer("[#ff0000][ Pass ]:[#ffffff] Invalid arguments, use /pass <Password>.", player);
           else
           {
               if ( text == BluePass ) 
               {
                   stats[ player.ID ].Pass = text;
                   MessagePlayer("[#00ff00][ Pass ]:[#ffffff] You have been authorized to spawn as a blue team.", player);
               }
             else  if ( text == RedPass ) 
               {
                   stats[ player.ID ].Pass = text;
                   MessagePlayer("[#00ff00][ Pass ]:[#ffffff] You have been authorized to spawn as a red team.", player);
               }
               else return MessagePlayer("[#ff0000][ Pass ]:[#ffffff] The password you entered doesn't match with blue team or red team's pass.",player);
           }
           break;
        case "register":
 {
 if (!text) MessagePlayer("[#ff0000]Invalid arguments provided, Use /"+cmd+" <Password>.:", player);
 else if ( stats[ player.ID ].Registered ) MessagePlayer("[#ff0000][ Account ]:[#ffffff] The account has already been registered.", player);
 else
 {
     if ( text.len() < 5 || text.len() > 40 ) MessagePlayer("[#ff0000][ Registration ]:[#ffffff]The password must be atleast 5 characters minimum and 40 charactars maximum.", player);
     else if ( PasswordStrength(text) > 38 )
     {
         Account.Create(player, text);
     }
     else return MessagePlayer("[#ff0000][ Account ]:[#ffffff]For the best security, you're requested to have a strong password containing lowercase, uppercase letters including numbers and '!,@,$' signs. You can note your password or write it down to any place in case you forget.", player);
 }
 }
 break;

case "exec":
   {
 if ( stats[ player.ID ].Level < 5 ) MessagePlayer("[#ff0000][ Command ]:[#ffffff] You're not allowed for the command usage.", player);
   else if ( !text ) MessagePlayer( "[#ff0000][ Script ]:[#ffffff] Invalid arguments, Use /exec <Code>.", player );
  else
  {
      try
   {
    local script = compilestring( text );
    if(script)
    {
     script();
     MessagePlayer( "[#00ff00][ Script ]:[#ffffff] The code got executed successfully.", player );
    }
    else MessagePlayer( "[#ff0000][ Script ]:[#ffffff] The execution failed to proceed.", player );

   }
   catch(e) MessagePlayer( "[#ff0000][ Script ]:[ffffff] Error: "+e+"", player);
  }
  }
  break;

case "login":
 {
 if (!text) MessagePlayer("[#ff0000][ Login ]:[#ffffff] Invalid arguments provided, use /"+cmd+" <Password>.", player);
 else if ( stats[ player.ID ].Logged ) MessagePlayer("[#ff0000][ Login ]:[#ffffff] The account is already logged in.", player);
else
{
local r = QuerySQL( db, "SELECT * FROM RoundStats WHERE LowerName = '"+player.Name.tolower()+"'" );
local q = QuerySQL( db, "SELECT * FROM Accounts WHERE LowerName='"+player.Name.tolower()+"'" );
local Pass = GetSQLColumnData( q, 2 );
if ( SHA256( text ) != Pass ) 
{
    MessagePlayer("[#ff0000][ Login ]:[#ffffff] Invalid password provided, you've 20 seconds to try again or else you'll be kicked.", player);
_Timer.Create( this, function(p){
      if ( stats[ p.ID ].Logged == false ) {
        MessagePlayer("[#ff0000][ Login ]:[#ffffff] The login time has been over and thus you've been kicked.", p);
        p.Kick();
    }
}, 20000, 1, player );
}
else {
stats[ player.ID ].Registered = true;
stats[ player.ID ].Logged = true;
stats[ player.ID ].Kills = GetSQLColumnData( q, 6 ).tointeger();
stats[ player.ID ].Deaths = GetSQLColumnData( q, 7 ).tointeger();
stats[ player.ID ].Headshots = GetSQLColumnData( q, 8 ).tointeger();
player.Cash = GetSQLColumnData( q, 9 ).tointeger();
stats[ player.ID ].Level = GetSQLColumnData( q, 10 ).tointeger();
stats[ player.ID ].AutoLogin = GetSQLColumnData( q, 11 ).tostring();
stats[ player.ID ].Wins = GetSQLColumnData( r, 1 ).tointeger();
stats[ player.ID ].Loses = GetSQLColumnData( r, 2 ).tointeger();
stats[ player.ID ].Rounds = GetSQLColumnData( r, 3 ).tointeger();
QuerySQL( db, "UPDATE Accounts SET IP='"+player.IP+"', UID='"+player.UniqueID+"', UID2='"+player.UniqueID2+"' WHERE LowerName='"+player.Name.tolower()+"'" );
MessagePlayer("[#00ff00][ Account ]:[#ffffff] Login successful.", player);
}
}
}
break;

case "setpass":
case "setpassword":
{
if (!text) MessagePlayer("[#ff0000][ Account ]:[#ffffff] Invalid arguments provided, Use /"+cmd+" <Old Password <New Password>.", player);
else if ( !stats[ player.ID ].Registered ) MessagePlayer("[#ff0000][ Account ]:[#ffffff] You need to register in order to proceed.", player);
else if ( !stats[ player.ID ].Logged ) MessagePlayer("[#ff0000][ Account ]:[#ffffff] The account is not logged in, please use /login.", player);
else{
    local q = QuerySQL( db, "SELECT * FROM Accounts WHERE LowerName='"+player.Name.tolower()+"'");
    local Old_Pass = GetTok( text, " ", 1 );
        local New_Pass = GetTok( text, " ", 2 );
    if ( !New_Pass ) MessagePlayer("[#ff0000]Invalid arguments provided, use /setpassword <Old Password> <NewPassword>.", player);
    else if ( SHA256(Old_Pass) != GetSQLColumnData( q, 1 ) ) MessagePlayer("[#ff0000]The old password doesn't match.", player);
    else if ( New_Pass.len() < 5 || New_Pass.len() > 40 ) MessagePlayer("[#ff0000]The new password must be 5 letters minimum and 40 letters maximum.", player);
    else if ( PasswordStrength(New_Pass) > 38 ) {
QuerySQL( db, "UPDATE Accounts SET Password='"+SHA256( New_Pass )+"' WHERE LowerName='"+player.Name.tolower()+"'" );
MessagePlayer("[#00ff00][ Password ]:[#ffffff] The password has been changed.", player);
}
     else MessagePlayer("[#ff0000][ Password ]:[#ffffff] For the best security, you're requested to have a strong password containing lowercase, uppercase letters including numbers and '!,@$' signs. You can note your password or write it down to any place in case you forget :).", player);
    }
}
break;

case "stats":
{
if (!text)
{
MessagePlayer("[#00ff00][ Statistics ]:[#ffffff] Stats: Kills: "+stats[ player.ID ].Kills+", Deaths: "+stats[ player.ID ].Deaths+", Cash: "+player.Cash+". Rounds Played: "+stats[ player.ID ].Rounds+" Wins: "+stats[ player.ID ].Wins+" Lost Rounds: "+stats[ player.ID ].Loses+".", player);
}
else if (text)
{
local plr = FindPlayer(text);
if (!plr) MessagePlayer("[#ff0000]Error:[#ffffff] Player not found.", player);
else{
MessagePlayer("[#f0f0ff] "+plr.Name+" statistics: Kills: "+stats[ plr.ID ].Kills+", Deaths: "+stats[ plr.ID ].Deaths+", Cash: "+player.Cash+", Level: "+stats[ plr.ID ].Level+" Rounds Played: "+stats[ plr.ID ].Rounds+" Wins: "+stats[ plr.ID ].Wins+" Lost Rounds: "+stats[ plr.ID ].Loses+".", player);
}
}
}
break;

case "autologin":
case "setautologin":
if (!text) MessagePlayer("[#ff0000]Invalid arguments provided, use /"+cmd+" <on/off>.", player);
else if ( !stats[ player.ID ].Logged ) MessagePlayer("[#ff0000]You're not logged in and in order to proceed, you need to /login.", player);
else if ( text == "on" )
{
    if ( stats[ player.ID ].AutoLogin == "on" ) return MessagePlayer("[#ff0000]The autologin is already turned on.", player);
    else
    {
stats[ player.ID ].AutoLogin = "on";
MessagePlayer("[#00ff00]The account will be logged in automatically from now.", player);
    }
}
else if ( text == "off" )
{
    if ( stats[ player.ID ].AutoLogin == "off" ) return MessagePlayer("[#ff0000]The autologin is already turned off.", player);
    else
    {
stats[ player.ID ].AutoLogin = "off";
MessagePlayer("[#00ff00]The account will require login on every join from now.", player);
    }
}
else MessagePlayer("[#ff0000]Invalid arguments, use /"+cmd+" <on/off>.", player);
break;

case "script":
case "credit":
case "credits":
{
MessagePlayer("[#00ff00][ Script ]:", player);
MessagePlayer("[#ffffff]The Razing Deathmatch War Server scripted by Shy.", player);
}
break;
case "fps":
if (!text) return MessagePlayer("[#00ff00][ FPS ]:[#ffffff] Your FPS: "+player.FPS+"", player);
else if ( text )
{
    local p_find = FindPlayer(text);
    if (!p_find) return MessagePlayer("[#ff0000][ FPS ]:[#ffffff] The request fail as the target person couldn't be found.", player);
    else return Message("[#00ff00][ FPS ]:[#ffffff] "+p_find.Name+"'s FPS: "+p_find.FPS+"( Requested by "+player.Name+").");
}
break;

case "ping":
if (!text) return MessagePlayer("[#00ff00][ Ping ]:[#ffffff] Your Ping: "+player.Ping+"", player);
else if ( text )
{
    local p_find = FindPlayer(text);
    if (!p_find) return MessagePlayer("[#ff0000][ Ping ]:[#ffffff] The request fail as the target person couldn't be found.", player);
    else return Message("[#00ff00][ Ping ]:[#ffffff] "+p_find.Name+"'s Ping: "+p_find.Ping+"( Requested by "+player.Name+").");
}
break;

case "help":
MessagePlayer("[#00ff00][ Gamemode ]:[#ffffff] The gamemode contains two teams, 7 bases( including one custom made ). The vote UI appears after a round has ended( if it doesn't, try /vote ). You've 15 seconds to vote for a base, just click on the base's name you wish to vote for. The base which has the most votes wins and is choosen at the round base. You can see for what you're choosen at the bottom left corner which shows if you're saving base or capturing.", player);
MessagePlayer("[#00ff00][ Capture ]:[#ffffff] It has a basic rule and the most important one to capture the base, if you're chosen to capture the base, you will have to find a sphere near you and once you enter inside it, the base will be started capturing and you'll have to wait for 10 seconds but when you do exit from sphere while capturing, it does cancel the capture.", player);
MessagePlayer("[#00ff00][ Save ]:[#ffffff] It has the second basic rule for one team to save the base from capturing, basically what you do is to save the sphere by NOT entering anyone from opposite team here.", player);
MessagePlayer("[#00ff00][ Time ]:[#ffffff] You got toal 7 minutes to either save the base or capture it.", player);
break;

case "spree": return MessagePlayer("[#ff0000][ Command ]:[#ffffff] /spree is blocked, use !spree.", player); break;
case "admin":
case "admins":
{
local plr, b;
for( local i = 0; i <= GetMaxPlayers(); i++ )
{
plr = FindPlayer( i );
if ( ( plr ) && ( stats[ plr.ID ].Level > 1 ) )
{
if ( b ) b = b + ", " + plr.Name + " - (" + stats[ plr.ID ].Level + ")"
else b = plr.Name + " - (" + stats[ plr.ID ].Level + ")"
}
}
if ( b ) Message( " [#00ff00][ Admins ]:[#ffffff] The admins online at the moment are:,  " + b + "  " );
else Message( " [#00ff00][ Admins ]:[#ffffff] There're currently no admins online at the moment( Requested by "+player.Name+").");
}
break;
case "base":
if ( Base == null ) return MessagePlayer("[#ff0000][ Base ]:[#ffffff] There's no current base or voting is pending.", player);
else return MessagePlayer("[#00ff00][ Base ]:[#ffffff] The current base: "+GetBaseName()+".", player);
break;
case "vote":
if ( Base == null && VoteStarted == true ) SendDataToClient(player, Shy.Vote);
else return MessagePlayer("[#ff0000][ Vote ]:[#ffffff] The voting hasn't started yet!", player);
break;
case "pack":
if ( Base != null && stats[ player.ID ].InMatch )
{
    if ( player.Skin == 200 && !PlayerToPoint(player, 10, RedPos.x, RedPos.y, RedPos.z)) return MessagePlayer("[#ff0000][ Pack ]:[#ffffff] You must be in the place where you spawned to change packs.", player);
   else if ( player.Skin == 201 && !PlayerToPoint(player, 10, BluePos.x, BluePos.y, BluePos.z)) return MessagePlayer("[#ff0000][ Pack ]:[#ffffff] You must be in the place where you spawned to change packs.", player);
    else SendDataToClient(player, Shy.Pack);
}
else return MessagePlayer("[#ff0000][ Packs ]:[#ffffff] You can only request pack menu when round is active.", player);
break;
case "requestchangeteam":
MessagePlayer("[#00ff00][ Request ]:[#ffffff] Changing team request done! Now wait for an admin to approve request. Note: Sending multiple requests as a spam or something will get you command ban.", player);
MessageAdmin( ""+player.Name+" has requested a team change" );
break;
case "allowteamchange":
if ( stats[ player.ID ].Level < 2 ) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] Not allowed for command usage.", player);
else if (!text) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] Invalid arguments, use /allowteamchange <Player>.", player);
else
{
    local plr = FindPlayer(text);
    if (!plr) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] Couldn't find that player.", player);
    else
    {
        stats[ plr.ID ].Done = false;
        MessagePlayer("[#00ff00][ Admin Command ]:[#ffffff] "+player.Name+" has allowed you to change the team.", plr);
        MessagePlayer("[#00ff00][ Admin Command ]:[#ffffff] Executed.", player);
        plr.Select();
    }
}
break;

case "votekick":
if ( VoteKickActive == true ) return MessagePlayer("[#ff0000][ VoteKick ]:[#ffffff] There's an on going vote kick.", player);
else if (!text) return MessagePlayer("[#ff0000][ Command ]:[#ffffff] Invalid arguments inputed, use /votekick <Player>.", player);
else
{
    if ( text)
    {
        local plr = FindPlayer(text);
        if (plr)
        {
            for ( local i=0; i<GetMaxPlayers(); i++ )
            {
                local all = FindPlayer(i);
                if (all)
                {
                    SendDataToClient(all, Shy.VoteKick, plr.Name);
                    SendDataToClient(all, Shy.Ann, "A vote kick has been started. Go ahead and vote!");
                    VoteKickActive = true;
                   wtfxd <- _Timer.Create(this, EndBro, 15000, 1, all);
                }
            }
        }
        else MessagePlayer("[#ff0000][ VoteKick ]:[#ffffff] VoteKick couldn't be started as the requested player couldn't be found.", player);
    }
}
break;

case "cry":
if (!text) Message("[#00ff00][ Weeps ]:[#FFFFFF] *Found "+player.Name+" crying as hard as someone literily raped him hard.");
else if (text)
{
    local p = FindPlayer(text);
    if (!p) Message("[#00ff00][ Weep ]:[#ffffff] "+player.Name+" wanted to make some unknown guy cry but felt himself cried. Sad life.");
    else Message("[#00ff00][ Weep ]:[#ffffff] "+player.Name+" made "+p.Name+" cry with a silly reason: I("+player.Name+") suck.");
}
break;
case "pity":
if (!text) Message("[#00ff00][ Pity ]:[#FFFFFF] *Found "+player.Name+" has too much bad luck that he took pity on himself.");
else if (text)
{
    local p = FindPlayer(text);
    if (!p) Message("[#00ff00][ Pity ]:[#ffffff] "+player.Name+" wanted to take pity on some unknown guy cry but felt himself pity on himself. Sad life.");
    else Message("[#00ff00][ Pity ]:[#ffffff] "+player.Name+" took pity on "+p.Name+", god knows for what.");
}
break;

case "cmds":
case "commands":
{
MessagePlayer("[#00ff00][ Account ]:[#ffffff] (/)register, login, setautologin( or autologin ), setpass, stats.", player);
MessagePlayer("[#00ff00][ Gameplay ]:[#ffffff] (/)fps, ping, help, admins( or !admins ), spree( or !spree ), base, requestchangeteam, myspree, vote, pack(Keyboard Shortcut: P), votekick", player);
MessagePlayer("[#00ff00][ Fun Commands ]:[#ffffff] (/)cry, ignore, unignore, randmsg, pity, makefun.", player);
if ( stats[ player.ID ].Level > 1 ) MessagePlayer("[#00ff00][ Admin Commands ]:[#ffffff] (/)transfer, mute, unmute, kick, ban, unban, rkick( round kick ), rban( round ban), runban, setautospawn, banset, unbanset, setwallglitch, setrange, setwep, teleportplayer, get( or bring ), sethp, setarmour.", player);
}
break;
default:
MessagePlayer("[#ff0000][ Command ]:[#ffffff] Invalid command inputed, please view /cmds.", player);
 }
}
function UnmuteEXE(pl, tysm)
{
   local player = FindPlayer(pl);
    if ( stats[ player.ID ].Muted )
    {
        stats[ player.ID ].Muted = false;
        Message("[#00ff00][ Unmute ]:[#ffffff] "+player.Name+" has been auto unmuted after a period of mute has passed("+tysm+")");
    }
}
function MessageAdmin( message )
{
    for ( local i = 0; i<GetMaxPlayers(); i++ )
    {
        local player = FindPlayer(i);
        if ( player && stats[ player.ID ].Level > 1 )
        {
            MessagePlayer("[#00ff00][ Admin Message ]:[#ffffff] "+message+"", player);
        }
    }
}
function EndBro(p)
{
                    VoteKickActive = false;
                    SendDataToClient(p, Shy.VoteKickResults, VKYes, VKNo);
                    SendDataToClient(p, Shy.Ann, "Votkick has been ended, results have been shown!");
                    stats[ p.ID ].Voted = false;
                    VKNo = 0;
                    VKYes = 0;
}
function GetBaseName()
{
    local b = Base;
    switch(b)
    {
        case "Malibu": return "Malibu";
        case "Construction": return "Construction Site";
        case "WK": return "WK Chariot Hotel";
        case "Ammu": return "Downtown Ammu Nation";
        case "Sharks": return "Shark base";
        case "Shark": return "Shark base";
        case "Lost": return "Lost Island";
        case "Ship": return "Ship near Viceport.";
        default: return "None";
    }
}
function PlayerToPoint( player, radi, x, y, z )
{
    local tempposx, tempposy, tempposz;
    tempposx = player.Pos.x -x;
    tempposy = player.Pos.y -y;
    tempposz = player.Pos.z -z;
    if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
    {
        return 1;
    }
    return 0;
}
function onPlayerPM( player, playerTo, message )
{
	return 1;
}
function Random(from, to) return (rand()*(to+1-from)) / (RAND_MAX+1)+from;

function CaptureFail(){
       Base = null;
        World = 1;
        Timer = 0;
        VoteMalibu = 0;
        VoteConstruction = 0;
        VoteWK = 0;
        VoteAmmu = 0;
        VoteSharks = 0;
        VoteLost = 0;
        VoteShip = 0;
        RedScore = 0;
        BlueScore = 0;
    if ( Base == null && GetPlayers() > 1 && RedPlayers > 0 && BluePlayers > 0 )
    {
                Message("[#00ff00][ Base ]:[#ffffff] Starting the new base in 15 seconds.");
        Message("[#00ff00][ Vote ]:[#ffffff] The voting ends in 15 seconds.");
     for ( local i=0; i<GetMaxPlayers(); i++ )
    {
        local plr = FindPlayer(i);
        if (plr)
        {
           SendDataToClient(plr, Shy.Ann, "Team "+CapturingTeam+" has successfully captured the base!");          
        stats[ plr.ID ].Status = null;
        stats[ plr.ID ].InMatch = false;
      stats[ plr.ID ].Done = false;      
      plr.CanAttack = false;
      plr.Disarm();    
stats[ plr.ID ].Pack = null;
     stats[ plr.ID ].Done = false;          
        plr.Pos = Vector(-1751.32, -144.044, 14.8683 );
         SendDataToClient(plr, Shy.Vote );
         SendDataToClient(plr, Shy.Ann, "Voting ends in 15 seconds!");
         NewTimer("CountVotes", 15000, 1);
         VoteStarted = true;
stats[ plr.ID ].Rounds++;
if ( GetCapturingTeamSkin() != plr.Skin ) stats[ plr.ID ].Wins++;
else stats[ plr.ID ].Loses++;

    }
}
}
}
function StartBase(int){
if ( Base == null && GetPlayers() > 1 && RedPlayers > 0 && BluePlayers > 0 )
{
Go <- _Timer.Create(this, function(fk)
{
for ( local i=0; i<GetMaxPlayers(); i++ )
{
    local player = FindPlayer(i);
    SendDataToClient(player, Shy.Ann, "Go!");
     SendDataToClient(player, Shy.Base, GetBaseName())
    SendDataToClient(player, Shy.Pack);
    Timer = 420;
}
}, 9000, 1, "fk");
End <- _Timer.Create(this, CaptureFail, 430000, 1);
    switch(int)
    {
                case 1:
                World = 1;
                CapturingTeam = "Blue";
                for ( local i=0; i<GetMaxPlayers(); ++i){
                local plr = FindPlayer(i);
                if (plr && !stats[ plr.ID ].InMatch && Base == null)
                {
                    plr.World = World;
                    stats[ plr.ID ].InMatch = true;
                    plr.CanAttack = true;
                    plr.Health = 100;
                    plr.Armour = 100;
                        if ( plr.Skin == 200 )
                        {
                                                MessagePlayer("[#00ff00][ Objective ]: [#ffffff]You have to save the base from capturing for 7 minutes or else the other team will win.", plr);
                            stats[ plr.ID ].Status = "Save";
                                        GTAVSpawn(plr, Vector(486.677, -55.4071, 11.4837));
                                        RedPos = plr.Pos;
                        }
                        else if ( plr.Skin == 201 )
                        {
                                                MessagePlayer("[#00ff00][ Objective ]: [#ffffff]You have to capture the base in 7 minutes or else the other team will win.", plr);
                            plr.CanAttack = true;
                            stats[ plr.ID ].Status = "Capture";
                       GTAVSpawn(plr, Vector(594.031, -186.551, 13.8289));
                       BluePos = plr.Pos;
                        }
                    }
                }
                          Base = "Malibu";   
         break;
        case 2:
                        World = 2;
                    CapturingTeam = "Red";
                    for ( local i=0; i<GetMaxPlayers(); ++i){
                local plr = FindPlayer(i);
                if (plr && !stats[ plr.ID ].InMatch && Base == null)
                {
                    plr.Health = 100;
                    plr.Armour = 100;
                    plr.World = World;
                                                            stats[ plr.ID ].InMatch = true;
                    plr.CanAttack = true;
                        if ( plr.Skin == 201 )
                        {
                                                MessagePlayer("[#00ff00][ Objective ]: [#ffffff]You have to save the base from capturing for 7 minutes or else the other team will win.", plr);
                            stats[ plr.ID ].Status = "Save";
                                        GTAVSpawn(plr, Vector(335.959, -242.057, 29.6466));
                                        BluePos = plr.Pos;
                        }
                        else if ( plr.Skin == 200 )
                        {
                                                MessagePlayer("[#00ff00][ Objective ]: [#ffffff]You have to capture the base in 7 minutes or else the other team will win.", plr);
                            plr.CanAttack = true;
                            stats[ plr.ID ].Status = "Capture";
                       GTAVSpawn(plr, Vector(254.294, -168.065, 11.5435));
                       RedPos = plr.Pos;
                        }
                    }
                }
            Base = "Construction";
        break;
        case 3:
                        World = 3;
                    CapturingTeam = "Blue";
                            for ( local i=0; i<GetMaxPlayers(); ++i){
                local plr = FindPlayer(i);
                if (plr && !stats[ plr.ID ].InMatch && Base == null)
                {
                    plr.World = World;
                              plr.Health = 100;
                    plr.Armour = 100;
                                                                                   stats[ plr.ID ].InMatch = true;
                    plr.CanAttack = true;
                        if ( plr.Skin == 200 )
                        {
                                                MessagePlayer("[#00ff00][ Objective ]: [#ffffff]You have to save the base from capturing for 7 minutes or else the other team will win.", plr);
                            stats[ plr.ID ].Status = "Save";
                                        GTAVSpawn(plr, Vector( 564.969, 17.124, 52.7511));
                                        RedPos = plr.Pos;
                        }
                        else if ( plr.Skin == 201 )
                        {
                                                MessagePlayer("[#00ff00][ Objective ]: [#ffffff]You have to capture the base in 7 minutes or else the other team will win.", plr);
                            plr.CanAttack = true;
                            stats[ plr.ID ].Status = "Capture";
                       GTAVSpawn(plr, Vector(458.244, -22.8619, 10.6871));
                       BluePos = plr.Pos;
                        }
                    }
                }
            Base = "WK";
        break;
        case 4:
                        World = 4;
     CapturingTeam = "Red";
                            for ( local i=0; i<GetMaxPlayers(); ++i){
                local plr = FindPlayer(i);
                if (plr && !stats[ plr.ID ].InMatch && Base == null)
                {
                    plr.Health = 100;
                    plr.Armour = 100;
                                        plr.World = World;
                                      stats[ plr.ID ].InMatch = true;
                    plr.CanAttack = true;
                        if ( plr.Skin == 201 )
                        {
                                                MessagePlayer("[#00ff00][ Objective ]: [#ffffff]You have to save the base from capturing for 7 minutes or else the other team will win.", plr);
                            stats[ plr.ID ].Status = "Save";
                                        GTAVSpawn(plr, Vector( -648.002, 1277.12, 10.8171));
                                        BluePos = plr.Pos;
                        }
                        else if ( plr.Skin == 200 )
                        {
                                                MessagePlayer("[#00ff00][ Objective ]: [#ffffff]You have to capture the base in 7 minutes or else the other team will win.", plr);
                            plr.CanAttack = true;
                            stats[ plr.ID ].Status = "Capture";
                       GTAVSpawn(plr, Vector( -656.655, 1109.44, 11.0712 ));
                       RedPos = plr.Pos;
                        }
                    }
                }
            Base = "Ammu";
                    break;
        case 5:
                        World = 5;
                  CapturingTeam = "Blue";                      
                          for ( local i=0; i<GetMaxPlayers(); ++i){
                local plr = FindPlayer(i);
                if (plr && !stats[ plr.ID ].InMatch && Base == null)
                {
                    plr.Health = 100;
                    plr.Armour = 100;
                                                                                   stats[ plr.ID ].InMatch = true;
                    plr.CanAttack = true;
                    plr.World = World;
                        if ( plr.Skin == 200 )
                        {
                                                MessagePlayer("[#00ff00][ Objective ]: [#ffffff]You have to save the base from capturing for 7 minutes or else the other team will win.", plr);
                            stats[ plr.ID ].Status = "Save";
                                        GTAVSpawn(plr, Vector( 79.395, 1109.2, 32.6056));
                                        RedPos = plr.Pos;
                        }
                        else if ( plr.Skin == 201 )
                        {
                                                MessagePlayer("[#00ff00][ Objective ]: [#ffffff]You have to capture the base in 7 minutes or else the other team will win.", plr);
                            plr.CanAttack = true;
                            stats[ plr.ID ].Status = "Capture";
                       GTAVSpawn(plr, Vector( -36.2026, 1115.92, 17.0775 ));
                       BluePos = plr.Pos;
                        }
                    }
                }
            Base = "Sharks";        
            break;
        case 6:
                        World = 6;
   CapturingTeam = "Red";
                          for ( local i=0; i<GetMaxPlayers(); ++i){
                local plr = FindPlayer(i);
                if (plr && !stats[ plr.ID ].InMatch && Base == null)
                {
                                                                                   stats[ plr.ID ].InMatch = true;
                    plr.CanAttack = true;
                    plr.World = World;
                    plr.Health = 100;
                    plr.Armour = 100;
                        if ( plr.Skin == 201 )
                        {
                                                MessagePlayer("[#00ff00][ Objective ]: [#ffffff]You have to save the base from capturing for 7 minutes or else the other team will win.", plr);
                            stats[ plr.ID ].Status = "Save";
                                        GTAVSpawn(plr, Vector(749.776, -2.76286, 12.1962));
                                        BluePos = plr.Pos;
                        }
                        else if ( plr.Skin == 200 )
                        {
                                                MessagePlayer("[#00ff00][ Objective ]: [#ffffff]You have to capture the base in 7 minutes or else the other team will win.", plr);
                            plr.CanAttack = true;
                            stats[ plr.ID ].Status = "Capture";
                       GTAVSpawn(plr, Vector(620.31, -7.87326, 16.7573));
                       RedPos = plr.Pos;
                        }
                    }
                }
            Base = "Lost";        
            break;
        case 7:
                        World = 7;
                CapturingTeam = "Blue";                
                               for ( local i=0; i<GetMaxPlayers(); ++i){
                local plr = FindPlayer(i);
                if (plr && !stats[ plr.ID ].InMatch && Base == null)
                {
                    plr.World = World;
                    plr.Health = 100;
                    plr.Armour = 100;
                stats[ plr.ID ].InMatch = true;
                    plr.CanAttack = true;
                        if ( plr.Skin == 200 )
                        {
                                                MessagePlayer("[#00ff00][ Objective ]: [#ffffff]You have to save the base from capturing for 7 minutes or else the other team will win.", plr);
                            stats[ plr.ID ].Status = "Save";
                                        GTAVSpawn(plr, Vector(-672.5, -1250.94, 35.2674 ));
                                        BluePos = plr.Pos;
                        }
                        else if ( plr.Skin == 201 )
                        {
                                                MessagePlayer("[#00ff00][ Objective ]: [#ffffff]You have to capture the base in 7 minutes or else the other team will win.", plr);
                            plr.CanAttack = true;
                            stats[ plr.ID ].Status = "Capture";
                       GTAVSpawn(plr, Vector(-686.601, -1463.45, 11.5957 ));
                       BluePos = plr.Pos;
                        }
                    }
                }
            Base = "Ship";     
              break;
        default:
        break;
    }
}
}

function CountVotes()
{
    if ( Base == null && VoteStarted == true && RedPlayers > 0 && BluePlayers > 0 ) {
    if (  VoteMalibu > VoteConstruction && VoteMalibu > VoteWK && VoteMalibu > VoteAmmu && VoteMalibu > VoteSharks && VoteMalibu > VoteLost && VoteMalibu > VoteShip  ) StartBase(1);
     else if (  VoteConstruction > VoteMalibu && VoteConstruction > VoteWK && VoteConstruction > VoteAmmu && VoteConstruction > VoteSharks && VoteConstruction > VoteLost && VoteConstruction > VoteShip && Base == null) StartBase(2);
  else  if ( VoteWK > VoteConstruction && VoteWK > VoteMalibu && VoteWK > VoteAmmu && VoteWK > VoteSharks && VoteWK > VoteLost && VoteWK > VoteShip   ) StartBase(3);
  else  if (  VoteAmmu > VoteMalibu && VoteAmmu > VoteConstruction && VoteAmmu > VoteWK && VoteAmmu > VoteShip && VoteAmmu > VoteSharks && VoteAmmu > VoteLost  ) StartBase(4);
  else  if (  VoteSharks > VoteConstruction && VoteSharks > VoteWK && VoteSharks > VoteAmmu && VoteSharks > VoteMalibu && VoteSharks > VoteLost && VoteSharks > VoteShip && Base == null) StartBase(5);
  else  if (  VoteLost > VoteConstruction && VoteLost > VoteWK && VoteLost > VoteAmmu && VoteLost > VoteSharks  && VoteLost > VoteShip  ) StartBase(6);
  else  if (  VoteShip > VoteMalibu && VoteShip > VoteConstruction && VoteShip > VoteWK && VoteShip > VoteAmmu && VoteShip > VoteSharks && VoteShip > VoteLost  ) StartBase(7);
else 
{
    local r = Random(0,8);
    StartBase(r);
}
} 
}
// SLC's very useful functions
function PasswordStrength(p)
{
    // Ignore empty or dumb passwords
    if (!p || p.len() <= 1) return -999;
    // Preallocate all variables upfront
    local d = 0, u = 0, l = 0, s = 0, r = 0, a = array(0xFF, 0), t = p.len();
    // Classify characters
    foreach (c in p)
    {
        // Count repetition
        if (++a[c] > 1) ++r;
        // Count diversity
        else if (c >= '0' && c <= '9') ++d;
        else if (c >= 'A' && c <= 'Z') ++u;
        else if (c >= 'a' && c <= 'z') ++l;
        else if (c >= ' ' && c <= '/') ++s;
        else if (c >= ':' && c <= '@') ++s;
        else if (c >= '[' && c <= '`') ++s;
        else if (c >= '{' && c <= '~') ++s;
    }
    // Score diversity
    if (d > 0) t += d; else t -= 2;
    if (u > 0) t += u; else t -= 2;
    if (l > 0) t += l; else t -= 2;
    if (s > 0) t += s; else t -= 2;
    // Score repetition
    if ((p.len() - r) < 3) t -= r; else t += p.len();
    // Score succession
    for (local i = 2, j = p[0], k = p[1], x = abs(k - j), o = (x == 1).tointeger(), n = p.len();
            i < n;
            j = k, k = p[i], ++i, x = abs(k - j), o += (x == 1).tointeger())
    {
        if (x == 1) {
            if (o > 2) t -= 3;
            else if (o > 1) t -= 2;
            else if (o > 0) t -= 1;
        } else if (x > 3) t += 3, o = 0;
        else if (x > 2) t += 2, o = 0;
        else if (x > 1) t += 1, o = 0;
    }
    // Return resulted score
    return t;
} 
function GetTok( string, separator, n, ... )
{
 local m = ( vargv.len() > 0 ) ? vargv[ 0 ] : n, tokenized = split( string, separator ), text = "";

 if ( ( n > tokenized.len() ) || ( n < 1 ) ) return null;

 for ( ; n <= m; n++ )
 {
  text += text == "" ? tokenized[ n - 1 ] : separator + tokenized[ n - 1 ];
 }

 return text;
}

function NumTok(string, separator)
{
    local tokenized = split(string, separator);
    return tokenized.len();
}
function GetPlayer( target )
{
 local target1 = target.tostring();

 if ( IsNum( target ) )
 {
  target = target.tointeger();

  if ( FindPlayer( target) ) return FindPlayer( target );
  else return null;
 }
 else if ( FindPlayer( target ) ) return FindPlayer( target );
 else return null;
}
function SetWeapons(player) {
local string = stats[ player.ID ].Pack;
 switch( string )
{
case 1: { 
    MessagePlayer("[#00ff00][ Packs ]:[#ffffff] Spawned with the pack "+stats[ player.ID ].Pack+".", player);
player.Disarm();
player.SetWeapon( 21, 999 ); player.SetWeapon( 19, 999 );
 player.SetWeapon( 24, 999 );
  player.SetWeapon( 26, 999 );
stats[ player.ID ].Pack = 1; 
 }
 break;
case 2: {
        MessagePlayer("[#00ff00][ Packs ]:[#ffffff] Spawned with the pack "+stats[ player.ID ].Pack+".", player);
player.Disarm();
player.SetWeapon( 19, 999 ); 
player.SetWeapon( 24, 999 ); 
player.SetWeapon( 32, 999 ); 
stats[ player.ID ].Pack = 2; 
}
break;
case 3: { 
player.Disarm();
player.SetWeapon( 21, 999 );
    MessagePlayer("[#00ff00][ Packs ]:[#ffffff] Spawned with the pack "+stats[ player.ID ].Pack+".", player);
 player.SetWeapon( 24, 999 );
 player.SetWeapon( 31, 999 );
  player.SetWeapon( 12, 15 );
 stats[ player.ID ].Pack = 3; 
 }
 break;
case 4: { 
        MessagePlayer("[#00ff00][ Packs ]:[#ffffff] Spawned with the pack "+stats[ player.ID ].Pack+".", player);
player.Disarm();
player.SetWeapon( 30 15 );
player.SetWeapon( 24, 999 );
player.SetWeapon( 20, 999 );
stats[ player.ID ].Pack = 4; 
}
break;
case 5: { 
        MessagePlayer("[#00ff00][ Packs ]:[#ffffff] Spawned with the pack "+stats[ player.ID ].Pack+".", player);
player.Disarm();
player.SetWeapon( 11, 999 );
player.SetWeapon( 15, 15 );
player.SetWeapon( 21, 999 );
player.SetWeapon( 24, 999 );
stats[ player.ID ].Pack = 5; 
}
break;
case 6:
{ 
        MessagePlayer("[#00ff00][ Packs ]:[#ffffff] Spawned with the pack "+stats[ player.ID ].Pack+".", player);
player.Disarm();
player.SetWeapon( 20, 999 );
player.SetWeapon( 24, 999 );
player.SetWeapon( 32, 999 );
stats[ player.ID ].Pack = 6; 
} break;
case 7: { 
      MessagePlayer("[#00ff00][ Packs ]:[#ffffff] Spawned with the pack "+stats[ player.ID ].Pack+".", player);  
player.Disarm();
player.SetWeapon( 19, 999 );
player.SetWeapon( 24, 999 );
player.SetWeapon( 26, 999 );
stats[ player.ID ].Pack = 7; 
}
break;
default:
return 0;
}
}
function onPlayerBeginTyping( player )
{
}

function onPlayerEndTyping( player )
{
}

function onNameChangeable( player )
{
}

function onPlayerSpectate( player, target )
{
}

function onPlayerCrashDump( player, crash )
{
}

function onPlayerMove( player, lastX, lastY, lastZ, newX, newY, newZ )
{
}

function onPlayerHealthChange( player, lastHP, newHP )
{
}

function onPlayerArmourChange( player, lastArmour, newArmour )
{
}

function onPlayerWeaponChange( player, oldWep, newWep )
{
}

function onPlayerAwayChange( player, status )
{
}

function onPlayerNameChange( player, oldName, newName )
{
}

function onPlayerActionChange( player, oldAction, newAction )
{
}

function onPlayerStateChange( player, oldState, newState )
{
}

function onPlayerOnFireChange( player, IsOnFireNow )
{
}

function onPlayerCrouchChange( player, IsCrouchingNow )
{
}

function onPlayerGameKeysChange( player, oldKeys, newKeys )
{
}

function onPlayerUpdate( player, update )
{
}

function onClientScriptData( player )
{
    local stream = Stream.ReadByte();
    local string = Stream.ReadString();
    local int = Stream.ReadInt();
    switch ( stream )
    {
      case Shy.Vote:
        if ( string == "Malibu" ) VoteMalibu++;
       else if ( string == "Construction" ) VoteConstruction++;
               else  if ( string == "WK" ) VoteWK++;
      else   if ( string == "Ammu" ) VoteAmmu++;
    else     if ( string == "Sharks" ) VoteSharks++;
     else    if ( string == "Ship" ) VoteShip++;
   else      if ( string == "Lost" ) VoteLost++;
        break; 
 case Shy.Pack:
if ( string == "Ingram" ) { 
player.SetWeapon( 24, 999 );
 stats[ player.ID ].Miniwep = "Ingram"; 
 }
if ( string == "Uzi" ) { 
player.SetWeapon( 23, 999 ); 
stats[ player.ID ].Miniwep = "Uzi"; 
}
if ( string == "MP5" ) { 
player.SetWeapon( 25, 999 );
 stats[ player.ID ].Miniwep = "MP5"; 
}
if ( string == "Pack1" ) { 
if (stats[ player.ID ].Pack == null)
{
    player.Disarm();
player.SetWeapon( 21, 999 ); player.SetWeapon( 19, 999 );
 player.SetWeapon( 24, 999 );
  player.SetWeapon( 26, 999 );
stats[ player.ID ].Pack = 1; 
}
else MessagePlayer("[#00ff00][ Pack ]:[#ffffff] You'll receive the pack in next spawn.", player), stats[ player.ID ].Pack = 1;
 }
if ( string == "Pack2" ) { 
    if ( stats[ player.ID ].Pack == null )
    {
player.Disarm();
player.SetWeapon( 19, 999 ); 
player.SetWeapon( 24, 999 ); 
player.SetWeapon( 32, 999 ); 
stats[ player.ID ].Pack = 2; 
    }
else MessagePlayer("[#00ff00][ Pack ]:[#ffffff] You'll receive the pack in next spawn.", player), stats[ player.ID ].Pack = 2;
}
if ( string == "Pack3" ) { 
    if ( stats[ player.ID ].Pack == null )
    {
player.Disarm();
player.SetWeapon( 21, 999 );
 player.SetWeapon( 24, 999 );
 player.SetWeapon( 31, 999 );
  player.SetWeapon( 12, 15 );
 stats[ player.ID ].Pack = 3; 
    }
else MessagePlayer("[#00ff00][ Pack ]:[#ffffff] You'll receive the pack in next spawn.", player), stats[ player.ID ].Pack = 3;
 }
if ( string == "Pack4" ) { 
    if ( stats[ player.ID ].Pack == null )
    {
player.Disarm();
player.SetWeapon( 30, 15 );
player.SetWeapon( 24, 999 );
player.SetWeapon( 20, 999 );
stats[ player.ID ].Pack = 4; 
}
else MessagePlayer("[#00ff00][ Pack ]:[#ffffff] You'll receive the pack in next spawn.", player), stats[ player.ID ].Pack = 4;
}
if ( string == "Pack5" ) { 
    if ( stats[ player.ID ].Pack == null )
    {
player.Disarm();
player.SetWeapon( 11, 999 );
player.SetWeapon( 15, 15 );
player.SetWeapon( 21, 999 );
player.SetWeapon( 24, 999 );
stats[ player.ID ].Pack = 5; 
}
else MessagePlayer("[#00ff00][ Pack ]:[#ffffff] You'll receive the pack in next spawn.", player), stats[ player.ID ].Pack = 5;
}
if ( string == "Pack6" ) { 
    if ( stats[ player.ID ].Pack == null)
    {
player.Disarm();
player.SetWeapon( 20, 999 );
player.SetWeapon( 24, 999 );
player.SetWeapon( 32, 999 );
stats[ player.ID ].Pack = 6; 
}
else MessagePlayer("[#00ff00][ Pack ]:[#ffffff] You'll receive the pack in next spawn.", player), stats[ player.ID ].Pack = 6;
}
if ( string == "Pack7" ) { 
    if ( stats[ player.ID ].Pack == null )
    {
player.Disarm();
player.SetWeapon( 19, 999 );
player.SetWeapon( 24, 999 );
player.SetWeapon( 26, 999 );
stats[ player.ID ].Pack = 7; 
}
else MessagePlayer("[#00ff00][ Pack ]:[#ffffff] You'll receive the pack in next spawn.", player), stats[ player.ID ].Pack = 7;
}
if ( stats[ player.ID ].Pack != null ) MessagePlayer("[#00ff00][ Packs ]: Set weapon pack "+stats[ player.ID ].Pack+" for spawn.", player);
break;
        break;
    }
}

// ========================================== V E H I C L E   E V E N T S =============================================

function onPlayerEnteringVehicle( player, vehicle, door )
{
	return 1;
}

function onPlayerEnterVehicle( player, vehicle, door )
{
}

function onPlayerExitVehicle( player, vehicle )
{
}

function onVehicleExplode( vehicle )
{
}

function onVehicleRespawn( vehicle )
{
}

function onVehicleHealthChange( vehicle, oldHP, newHP )
{
}

function onVehicleMove( vehicle, lastX, lastY, lastZ, newX, newY, newZ )
{
}

// =========================================== P I C K U P   E V E N T S ==============================================

function onPickupClaimPicked( player, pickup )
{
	return 1;
}

function onPickupPickedUp( player, pickup )
{
    if ( pickup.ID == 0 && player.World == 6 )
    {
        player.Pos = Vector(732.901, 33.8105, 15.9712);
    }
    else if ( pickup.ID == 1 && player.World == 6 )
    {
        player,Pos = Vector(727.962, -39.5353, 15.9712);
    }
}

function onPickupRespawn( pickup )
{
}

// ========================================== O B J E C T   E V E N T S ==============================================

function onObjectShot( object, player, weapon )
{
}

function onObjectBump( object, player )
{
}

// ====================================== C H E C K P O I N T   E V E N T S ==========================================

function GetCapturingTeamSkin()
{
switch( CapturingTeam )
{
case "Red": return 200;
case "Blue": return 201;
}
}
function Captured()
{
     Base = null;
        World = 1;
        VoteMalibu = 0;
        VoteConstruction = 0;
        VoteWK = 0;
        VoteAmmu = 0;
        VoteSharks = 0;
        VoteLost = 0;
        VoteShip = 0;
        Timer = 0;
        RedScore = 0;
        BlueScore = 0;
    for ( local i=0; i<GetMaxPlayers(); i++ )
    {
        local plr = FindPlayer(i);
        if (plr)
        {
SendDataToClient(plr, Shy.Ann, "Team "+CapturingTeam+" has successfully captured the base!");
        stats[ plr.ID ].Status = null;
        stats[ plr.ID ].InMatch = false;
             plr.CanAttack = false;
      plr.Disarm(); 
      stats[ plr.ID ].Done = false;
stats[ plr.ID ].Pack = null;
        plr.Pos = Vector(-1751.32, -144.044, 14.8683 );
Message("[#00ff00][ Base ]:[#ffffff] Starting the new base in 15 seconds.");
        Message("[#00ff00][ Vote ]:[#ffffff] The voting ends in 15 seconds.");
         SendDataToClient(plr, Shy.Vote );
         NewTimer("CountVotes", 15000, 1);   
stats[ plr.ID ].Rounds++;
if ( GetCapturingTeamSkin() == plr.Skin ) stats[ plr.ID ].Wins++;
else stats[ plr.ID ].Loses++;
          }
}
}
function onCheckpointEntered( player, checkpoint )
{
    if ( Base != null && stats[ player.ID ].Status == "Capture" )
    {
        for ( local i= 0; i<GetMaxPlayers(); i++ )
        {
            local m = player.Skin;
            local plr = FindPlayer(i);
           SendDataToClient(plr, Shy.Ann, "ALERT: Team "+CapturingTeam+" is capturing the base!" );
        }
       CaptureTimer <- NewTimer("Captured", 10000, 1);
       MessagePlayer("[#00ff00][ Capture ]:[#ffffff] Capturing the base in 10 seconds, don't move!", player);
    }
}

function onCheckpointExited( player, checkpoint )
{
     if ( Base != null && stats[ player.ID ].Status == "Capture" )
    {
        for ( local i= 0; i<GetMaxPlayers(); i++ )
        {
            local m = player.Skin;
            local plr = FindPlayer(i);
           if (m == 200) SendDataToClient(plr, Shy.Ann, "ALERT: Team "+CapturingTeam+" failed to capture the base!" );
           else SendDataToClient(plr, Shy.Ann, "ALERT: Team "+CapturingTeam+" failed to capture the base!" );
        }
      CaptureTimer.Stop();
       MessagePlayer("[#ff0000][ Capture ]:[#ffffff] You failed to capture the base because you moved!", player);
    }
}

// =========================================== B I N D   E V E N T S =================================================

function onKeyDown( player, key )
{ 
    if ( key == F1 )
    {
        if ( VoteKickActive && !stats[ player.ID ].Voted )
        {
            VKYes++;
            SendDataToClient(player, Shy.Ann, "Voted votekick as agree!");
            stats[ player.ID ].Voted = true;
        }
     else if ( stats[ player.ID ].Voted ) SendDataToClient(player, Shy.Ann, "You've already voted.");

    }
     else if ( key == F2 )
    {
        if ( VoteKickActive && !stats[ player.ID ].Voted )
        {
            VKNo++;
            SendDataToClient(player, Shy.Ann, "Voted votekick as against!");
            stats[ player.ID ].Voted = true;
        }
        else if ( stats[ player.ID ].Voted ) SendDataToClient(player, Shy.Ann, "You've already voted.");
    }
}

function onKeyUp( player, key )
{
}

// ================================== E N D   OF   O F F I C I A L   E V E N T S ======================================


function SendDataToClient( player, ... )
{
    if( vargv[0] )
    {
        local     byte = vargv[0],
                len = vargv.len();
                
        if( 1 > len ) print( "ToClent <" + byte + "> No params specified." );
        else
        {
            Stream.StartWrite();
            Stream.WriteByte( byte );

            for( local i = 1; i < len; i++ )
            {
                switch( typeof( vargv[i] ) )
                {
                    case "integer": Stream.WriteInt( vargv[i] ); break;
                    case "string": Stream.WriteString( vargv[i] ); break;
                    case "float": Stream.WriteFloat( vargv[i] ); break;
                }
            }
            
            if( player == null ) Stream.SendStream( null );
            else if( typeof( player ) == "instance" ) Stream.SendStream( player );
            else print( "ToClient <" + byte + "> Player is not online." );
        }
    }
    else print( "ToClient: Even the byte wasn't specified..." );
}
// ------------------------------------------------------------------------------------------------
srand((GetTickCount() % time()) / 3);

// ------------------------------------------------------------------------------------------------
_Timer <- {
    // --------------------------------------------------------------------------------------------
    m__Timers = { /* ... */ }

    // --------------------------------------------------------------------------------------------
    function Create(environment, listener, interval, repeat, ...)
    {
        // ----------------------------------------------------------------------------------------
        // Prepare the arguments pack
        vargv.insert(0, environment);
        // ----------------------------------------------------------------------------------------
        // Store timer information into a table
        local data = {
            Environment = environment,
            Listener = listener,
            Interval = interval,
            Repeat = repeat,
            Timer = null,
            Args = vargv
        };
        // ----------------------------------------------------------------------------------------
        local hash = split(data+"", ":")[1].slice(3, -1).tointeger(16);
        // ----------------------------------------------------------------------------------------
        // Create the timer instance
        data.Timer = NewTimer("tm_TimerProcess", interval, repeat, hash);
        // ----------------------------------------------------------------------------------------
        // Store the timer information
        m__Timers.rawset(hash, data);
        // ----------------------------------------------------------------------------------------
        // Return the hash that identifies this timer
        return hash;
    }

    // --------------------------------------------------------------------------------------------
    function Destroy(hash)
    {
        // See if the specified timer exists
        if (m__Timers.rawin(hash))
        {
            // Destroy the timer instance
            m__Timers.rawget(hash).Timer.Delete();
            // Remove the timer information
            m__Timers.rawdelete(hash);
        }
    }

    // --------------------------------------------------------------------------------------------
    function Exists(hash)
    {
        // See if the specified timer exists
        return m__Timers.rawin(hash);
    }

    // --------------------------------------------------------------------------------------------
    function Fetch(hash)
    {
        // Return the timer information
        return m__Timers.rawget(hash);
    }

    // --------------------------------------------------------------------------------------------
    function Clear()
    {
        // Process all existing timers
        foreach (tm in m__Timers)
        {
            // Destroy the timer instance
            tm.Timer.Delete();
        }
        // Clear existing timers
        m__Timers.clear();
    }
}

// ------------------------------------------------------------------------------------------------
tm_TimerProcess <- function(hash)
{
    // See if the specified timer exists
    if (_Timer.m__Timers.rawin(hash))
    {
        // Get the timer associated with the specified hash
        local tm = _Timer.m__Timers.rawget(hash);
        // Call the specified listener
        tm.Listener.pacall(tm.Args);
        // Calculate the remaining cycles
        if (tm.Repeat && (--tm.Repeat <= 0))
        {
            // Release the timer
            _Timer.Destroy(hash);
        }
    }
}
