enum Shy {
Rules = 0x01
Timer = 0x02
Pack = 0x03
Ann = 0x04
Vote = 0x05
VoteKick = 0x06
VoteKickResults = 0x07
Base = 0x08
KillAnn = 0x09
Score = 0x10
}


Hud.RemoveFlags(HUD_FLAG_CLOCK | HUD_FLAG_WANTED);


function Server::ServerData( stream )
{
    local type = stream.ReadByte();
    switch( type )
    {
        case Shy.Rules:
		ShowRules();
        break; 
		case Shy.Timer:
		local min = stream.ReadInt();
		local sec = stream.ReadInt();
        local red = stream.ReadInt();
        local blue = stream.ReadInt();
		TimerCC( min, sec, red, blue);
		break;
		case Shy.Pack:
		PacksYes();
		break;
      case Shy.Ann:
        local Message = stream.ReadString();
        Announcement(Message);
        break; 
        case Shy.Vote:
        local string = stream.ReadString();
        local m = UI.Button("closebtnn");
        return VoteUI();
        break;
        case Shy.VoteKick:
        local nick = stream.ReadString();
        VoteKickUI(nick);
        break;
        case Shy.VoteKickResults:
        local yes = stream.ReadInt();
        local no = stream.ReadInt();
        VoteKickResults(yes, no);
        break;
        case Shy.Base:
        local string = stream.ReadString();
        BaseUIShow(string);
        break;
        case Shy.KillAnn:
        local ann = stream.ReadString();
        KillAnnounce(ann);
        break;
      /*  case Shy.Score:
        local red = stream.ReadInt();
        local blue = stream.ReadInt();
        ShowScoreUI(red, blue); */
        break;
        default:
        break;
    }
}

function KillAnnounce(string)
{
    KillAnnRemove <- Timer.Create(this, function(np){
        if ( UI.Label("killannlbl"))
        {
            UI.Label("killannlbl").fadeOut();
        }
    }, 7500, 1, "np");
    local lab = UI.Label("killannlbl");
    if ( !lab || lab == null ) {
      UI.Label({
        id = "killannlbl"
        align = "bottom_center"
        Text = string
        TextColor = Colour(0, 128, 255)
        FontSize = 50
    })
}
else {
    UI.Label("killannlbl").Text = string;
    UI.Label("killannlbl").fadeIn();
}
}
function BaseUIShow(bbaassee)
{
    if ( UI.Canvas("basecanvy") == null || UI.Canvas("basecanvy").hidden == true )
    {
        UI.Canvas({
            id = "basecanvy"
            align = "bottom_left"
            Color = Colour(0, 0, 0)
            Alpha = 185
         RelativeSize = ["20%" "5%"]
            children = [
                UI.Label({
                    id = "baselbly"
                    align = "center"
                    move = { left = 28 }
                    Text = "Base: " +bbaassee
                    TextColor = Colour(255, 255, 255)
                    FontSize = 17
                })
            ]
        })
    }
    else
    {
        UI.Label("baselbly").setText("Base: " +bbaassee);
        UI.Canvas("basecanvy").show();
    }
}
function PacksGay()
{
    UI.Cursor("ON");
local lab = UI.Canvas("pcanvy");
local Lol = UI.Button("pcbtn");
  if (!Lol)   UI.Button({
            id = "pcbtn"
            align = "top_center"
            Size = VectorScreen(40, 33 )
            Text = "Close"
            TextColor = Colour(255, 255, 255)
            move = { down = 102, right = 108 }
            Color = Colour(255, 0, 0)
            onClick = function() {
                UI.Cursor("OFF");
                                UI.Canvas("pcanvy").hide();
                this.hide();
            }
        })

if (!lab) UI.Canvas({
    id = "pcanvy"
    align = "center"
    RelativeSize = ["20%" "42%"]
    Color = Colour(0, 0, 0)
    Alpha = 150
    children = [
        UI.Button({
            id = "packyyy1"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "Stubby, Ingram, M4"
            TextColor = Colour(255, 255, 255)
            move = { up = 181 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                SendDataToServer( Shy.Pack, "Pack1" )
                UI.Canvas("pcanvy").destroy();
              UI.Button("pcbtn").destroy();
                UI.Cursor("OFF");
                Console.Print("[#00ff00][ Pack ]:[#ffffff] Packs reloaded.");
            }
        })
                UI.Button({
            id = "packyyy2"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "Shotgun, Ingram, M60"
            TextColor = Colour(255, 255, 255)
            move = { up = 121 }
            Color = Colour(0, 0, 0)
            onClick = function() {
           SendDataToServer( Shy.Pack, "Pack2" )
                UI.Canvas("pcanvy").destroy();
              UI.Button("pcbtn").destroy();
                UI.Cursor("OFF");
                Console.Print("[#00ff00][ Pack ]:[#ffffff] Packs reloaded.");
            }
        })
                        UI.Button({
            id = "Packyyy3"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "Flamethrower, Stubby Shotgun, Ingram, Gernades"
            TextColor = Colour(255, 255, 255)
            move = { up = 61 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                UI.Cursor("OFF");
                                SendDataToServer( Shy.Pack, "Pack3")
                            UI.Canvas("pcanvy").destroy();
             UI.Button("pcbtn").destroy();
                Console.Print("[#00ff00][ Pack ]:[#ffffff] Packs reloaded.");
            }
        })
                        UI.Button({
            id = "Packyyy4"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "RPG, SPAS-12, Ingram"
            TextColor = Colour(255, 255, 255)
            move = { up = 1 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                                SendDataToServer( Shy.Pack, "Pack4")
                UI.Cursor("OFF");
                               UI.Canvas("pcanvy").destroy();
                UI.Button("pcbtn").destroy();
                Console.Print("[#00ff00][ Pack ]:[#ffffff] Packs reloaded.");
            }
        })
                        UI.Button({
            id = "Packyyy5"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "Chainsaw, Molotovs, Stubby, Ingram"
            TextColor = Colour(255, 255, 255)
            move = { down = 60 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                                SendDataToServer( Shy.Pack, "Pack5")
                UI.Cursor("OFF");
                               UI.Canvas("pcanvy").destroy();
               UI.Button("pcbtn").destroy();
                Console.Print("[#00ff00][ Vote ]:[#ffffff] Packs reloaded.");
            }
        })
                        UI.Button({
            id = "Packyyy6"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "SPAS-12, Ingram, M60"
            TextColor = Colour(255, 255, 255)
            move = { down = 121 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                UI.Cursor("OFF");
                              UI.Canvas("pcanvy").destroy();
                UI.Button("pcbtn").destroy();
                                SendDataToServer( Shy.Pack, "Pack6")
                Console.Print("[#00ff00][ Pack ]:[#ffffff] Packs reloaded.");
            }
        })
                             UI.Button({
            id = "Packyyy7"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "Shotgun, Ingram, M4"
            TextColor = Colour(255, 255, 255)
            move = { down = 181 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                UI.Cursor("OFF");
                              UI.Canvas("pcanvy").destroy();
                UI.Button("pcbtn").destroy();
                                SendDataToServer( Shy.Pack, "Pack7")
                Console.Print("[#00ff00][ Pack ]:[#ffffff] Packs reloaded.");
            }
        })
    ]
})
UI.Cursor("ON");
} 
function PacksYes()
{
    UI.Cursor("ON");
local lab = UI.Canvas("pcanvyxd");
local Lol = UI.Button("pclosebtnxd");
  if (!Lol)   UI.Button({
            id = "pclosebtnxd"
            align = "top_center"
            Size = VectorScreen(40, 33 )
            Text = "Close"
            TextColor = Colour(255, 255, 255)
            move = { down = 266, right = 108 }
            Color = Colour(255, 0, 0)
            onClick = function() {
                UI.Cursor("OFF");
                                UI.Canvas("pcanvyxd").destroy();
                this.destroy();
            }
        })
if (!lab) UI.Canvas({
    id = "pcanvyxd"
    align = "center"
    RelativeSize = ["20%" "42%"]
    Color = Colour(0, 0, 0)
    Alpha = 150
    children = [
        UI.Button({
            id = "pvotebtnxd1"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "Stubby, Ingram, M4"
            TextColor = Colour(255, 255, 255)
            move = { up = 181 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                SendDataToServer( Shy.Pack, "Pack1" )
                UI.Canvas("pcanvyxd").destroy();
              UI.Button("pclosebtnxd").destroy();
                UI.Cursor("OFF");
                Console.Print("[#00ff00][ Pack ]:[#ffffff] Packs reloaded.");
            }
        })
                UI.Button({
            id = "pcanvybtnxd2"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "Shotgun, Ingram, M60"
            TextColor = Colour(255, 255, 255)
            move = { up = 121 }
            Color = Colour(0, 0, 0)
            onClick = function() {
       SendDataToServer( Shy.Pack, "Pack2" )
                UI.Canvas("pcanvyxd").destroy();
              UI.Button("pclosebtnxd").destroy();
                UI.Cursor("OFF");
                Console.Print("[#00ff00][ Pack ]:[#ffffff] Packs reloaded.");
            }
        })
                        UI.Button({
            id = "pcanvybtnxd3"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "FlameThrower, Stubby, Ingram, Gernades"
            TextColor = Colour(255, 255, 255)
            move = { up = 61 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                 SendDataToServer( Shy.Pack, "Pack3" )
                UI.Canvas("pcanvyxd").destroy();
              UI.Button("pclosebtnxd").destroy();
                UI.Cursor("OFF");
                Console.Print("[#00ff00][ Pack ]:[#ffffff] Packs reloaded.");
            }
        })
                        UI.Button({
            id = "pcanvyxd4"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "RPG, SPAS-12, Ingram"
            TextColor = Colour(255, 255, 255)
            move = { up = 1 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                             SendDataToServer( Shy.Pack, "Pack4" )
                UI.Canvas("pcanvyxd").destroy();
              UI.Button("pclosebtnxd").destroy();
                UI.Cursor("OFF");
                Console.Print("[#00ff00][ Pack ]:[#ffffff] Packs reloaded.");
            }
        })
                        UI.Button({
            id = "pcanvybtnxd5"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "Chainsaw, Molotov, Stubby, Ingram"
            TextColor = Colour(255, 255, 255)
            move = { down = 60 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                 SendDataToServer( Shy.Pack, "Pack5" )
                UI.Canvas("pcanvyxd").destroy();
              UI.Button("pclosebtnxd").destroy();
                UI.Cursor("OFF");
                Console.Print("[#00ff00][ Pack ]:[#ffffff] Packs reloaded.");
            }
        })
                        UI.Button({
            id = "pcanvybtn6"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "SPAS-12, Ingram, M60"
            TextColor = Colour(255, 255, 255)
            move = { down = 121 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                    SendDataToServer( Shy.Pack, "Pack6" )
                UI.Canvas("pcanvyxd").destroy();
              UI.Button("pclosebtnxd").destroy();
                UI.Cursor("OFF");
                Console.Print("[#00ff00][ Pack ]:[#ffffff] Packs reloaded.");
            }
        })
                             UI.Button({
            id = "pcanvybtnxd7"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "Shotgun, Ingram, M4"
            TextColor = Colour(255, 255, 255)
            move = { down = 181 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                     SendDataToServer( Shy.Pack, "Pack7" )
                UI.Canvas("pcanvyxd").destroy();
              UI.Button("pclosebtnxd").destroy();
                UI.Cursor("OFF");
                Console.Print("[#00ff00][ Pack ]:[#ffffff] Packs reloaded.");
            }
        })
    ]
})
}
function VoteKickResults(y, n)
{
      Remove_ <- Timer.Create(this, function(n)
    {
       local m = UI.Canvas("results!");
       if ( m ) { m.fadeOut(), UI.Cursor("OFF"); }
    }, 15000, 1, "n");
    local lol = UI.Canvas("results!");
 if (!lol) {
     UI.Canvas({
         id = "results!"
         align = "mid_left"
         Color = Colour(0, 0, 0)
         RelativeSize = ["16%" "5%"]
         Alpha = 120
         children = [
             UI.Label({
                 id = "lblYes!"
                 align = "center"
                 move = { left = 40 }
                 Text = "Yes Votes: " +y
                 TextColor = Colour(0, 255, 0)
             })
               UI.Label({
                 id = "lblNo!"
                 align = "center"
                 move = { right = 40 }
                 Text = "No Votes: " +n
                 TextColor = Colour(255, 0, 0)
             })
         ]
     })
}
else lol.show();
}
     function VoteKickUI(n)
     {
  Remove_ <- Timer.Create(this, function(n)
    {
       local m = UI.Canvas("votekickcanv");
       if ( m ) { m.fadeOut(), UI.Cursor("OFF"); }
    }, 10000, 1, "n");
    local lol = UI.Canvas("votekickcanv");
 if (!lol) {
     UI.Canvas({
    id = "votekickcanv"
    align = "mid_left"
    Color = Colour(0, 0, 0)
    Alpha = 195
    RelativeSize = ["22%" "25%"]
    children = [
UI.Label({
    id = "startlbl"
    align = "top_center"
    Text = "Vote kick started against " + n
    TextColor = Colour(255, 255, 255)
    FontSize = 12
    FontFlags = GUI_FFLAG_BOLD
})
UI.Label({
    id = "owo"
    align = "top_center"
    FontName = "FAEditUmar"
    Text = "U"
    move = { up = 3, right = 120 }
    TextColor = Colour(0, 200, 0)
    FontSize = 18
    FontFlags = GUI_FFLAG_BOLD
})
UI.Label({
    id = "accept"
    align = "top_center"
    move = { down = 38, left = 83 }
    Text = "Yes"
    TextColor = Colour(255, 255, 255)
    FontSize = 16
    FontFlags = GUI_FFLAG_BOLD
})
UI.Label({
    id = "checkmark"
    align = "top_center"
    move = { down = 35, left = 55 }
    FontName = "FAEditUmar"
    Text = "O"
    TextColor = Colour(0, 200, 0)
    FontSize = 16
    FontFlags = GUI_FFLAG_BOLD
})
UI.Label({
    id = "deny"
    align = "top_center"
    move = { down = 38, right = 30 }
    Text = "No"
    TextColor = Colour(255, 255, 255)
    FontSize = 16
    FontFlags = GUI_FFLAG_BOLD
})
UI.Label({
    id = "cross"
    align = "top_center"
    move = { down = 32, right = 52 }
    FontName = "FAEditUmar"
    Text = "B"
    TextColor = Colour(255, 0, 0)
    FontSize = 16
    FontFlags = GUI_FFLAG_BOLD
})
UI.Label({
    id = "F1"
    align = "top_center"
    move = { down = 62, left = 83 }
    Text = "F1"
    TextColor = Colour(255, 255, 255)
    FontSize = 12
    FontFlags = GUI_FFLAG_BOLD
})
UI.Label({
    id = "F2"
    align = "top_center"
    move = { down = 62, right = 30 }
    Text = "F2"
    TextColor = Colour(255, 255, 255)
    FontSize = 12
    FontFlags = GUI_FFLAG_BOLD
})
UI.Label({
    id = "enddd"
    align = "bottom_center"
    Text = "The vote will end in 10 seconds!"
    TextColor = Colour(255, 0, 0)
    FontSize = 16
    FontFlags = GUI_FFLAG_BOLD
})
    ]
})
 }
 else lol.show();
     } 
function VoteUI()
{
   ShowUI <- Timer.Create(this, function(n)
    {
            local m = UI.Canvas("votecanv");
       local l = UI.Button("closebtnn");
    if ( m != null && l != null ) return m.show(), l.show(), UI.Cursor("ON");
    }, 1000, 1, "n");
    RemoveVoteUI <- Timer.Create(this, function(n)
    {
       local m = UI.Canvas("votecanv");
       local l = UI.Button("closebtnn");
       if ( m && l ) { m.hide(), l.hide(); }
       local locals = UI.Cursor("OFF");
    }, 14000, 1, "n");
    UI.Cursor("ON");
local lab = UI.Canvas("votecanv");
local Lol = UI.Button("closebtnn");
  if (!Lol)   UI.Button({
            id = "closebtnn"
            align = "top_center"
            Size = VectorScreen(40, 33 )
            Text = "Close"
            TextColor = Colour(255, 255, 255)
            move = { down = 266, right = 108 }
            Color = Colour(255, 0, 0)
            onClick = function() {
                UI.Cursor("OFF");
                                UI.Canvas("votecanv").destroy();
                this.destroy();
            }
        })

if (!lab) UI.Canvas({
    id = "votecanv"
    align = "center"
    RelativeSize = ["20%" "42%"]
    Color = Colour(0, 0, 0)
    Alpha = 150
    children = [
        UI.Button({
            id = "votebtn"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "#1 Malibu"
            TextColor = Colour(255, 255, 255)
            move = { up = 181 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                SendDataToServer( Shy.Vote, "Malibu" )
                UI.Canvas("votecanv").destroy();
              UI.Button("closebtnn").destroy();
                UI.Cursor("OFF");
                Console.Print("[#00ff00][ Vote ]:[#ffffff] Voted for base Malibu.");
            }
        })
                UI.Button({
            id = "votebtn2"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "#2 Construction Site"
            TextColor = Colour(255, 255, 255)
            move = { up = 121 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                                SendDataToServer( Shy.Vote, "Construction")
                UI.Cursor("OFF");
                             UI.Canvas("votecanv").destroy();
              UI.Button("closebtnn").destroy();
                Console.Print("[#00ff00][ Vote ]:[#ffffff] Voted for base Construction Site.");
            }
        })
                        UI.Button({
            id = "votebtn3"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "#3 WK Chariot"
            TextColor = Colour(255, 255, 255)
            move = { up = 61 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                UI.Cursor("OFF");
                                SendDataToServer( Shy.Vote, "WK")
                            UI.Canvas("votecanv").destroy();
             UI.Button("closebtnn").destroy();
                Console.Print("[#00ff00][ Vote ]:[#ffffff] Voted for base WK Chariot.");
            }
        })
                        UI.Button({
            id = "votebtn4"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "#4 Ammu Nation"
            TextColor = Colour(255, 255, 255)
            move = { up = 1 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                                SendDataToServer( Shy.Vote, "Ammu")
                UI.Cursor("OFF");
                               UI.Canvas("votecanv").destroy();
                UI.Button("closebtnn").destroy();
                Console.Print("[#00ff00][ Vote ]:[#ffffff] Voted for base Ammu Nation.");
            }
        })
                        UI.Button({
            id = "votebtn5"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "#5 Sharks Base"
            TextColor = Colour(255, 255, 255)
            move = { down = 60 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                                SendDataToServer( Shy.Vote, "Sharks")
                UI.Cursor("OFF");
                               UI.Canvas("votecanv").destroy();
               UI.Button("closebtnn").destroy();
                Console.Print("[#00ff00][ Vote ]:[#ffffff] Voted for base Sharks.");
            }
        })
                        UI.Button({
            id = "votebtn6"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "#6 [ Custom ] Lost Island"
            TextColor = Colour(255, 255, 255)
            move = { down = 121 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                UI.Cursor("OFF");
                              UI.Canvas("votecanv").destroy();
                UI.Button("closebtnn").destroy();
                                SendDataToServer( Shy.Vote, "Lost")
                Console.Print("[#00ff00][ Vote ]:[#ffffff] Voted for base Lost Island.");
            }
        })
                             UI.Button({
            id = "votebtn7"
            align = "center"
            Size = VectorScreen(250, 50 )
            Text = "#7 Ship"
            TextColor = Colour(255, 255, 255)
            move = { down = 181 }
            Color = Colour(0, 0, 0)
            onClick = function() {
                UI.Cursor("OFF");
                              UI.Canvas("votecanv").destroy();
                UI.Button("closebtnn").destroy();
                                SendDataToServer( Shy.Vote, "Ship")
                Console.Print("[#00ff00][ Vote ]:[#ffffff] Voted for base Ship.");
            }
        })
    ]
})
}
function TimerCC( min, sec, red, blue )
{
            local lub = UI.Label("Timer");
    if( min > -1 && sec > -1 )
    {
        local lab = UI.Label("Timer");
        local lbl = UI.Label("redscore");
        local lbl2 = UI.Label("bluescore");
        local sp = UI.Sprite("scoresprite");
        if(!lab && !lbl && !lbl2)
        {
            
  sp =  UI.Sprite({
        id = "scoresprite"
        align = "top_center"
        file = "Gameshow.png"
        Size = VectorScreen(450, 450)
        Color = Colour(255, 255, 255)
         move = { up = 214 }
    });
            lab = UI.Label({
                id = "Timer"  
                Text = "" + min + " : " + sec
                FontSize = 12
                FontFlags = GUI_FFLAG_BOLD
                align = "top_center"
                TextColour = Colour(0, 0, 0)
                move = { up = 2 }
            });
  lbl = UI.Label({
      id = "redscore"  
                Text = red
                FontSize = 12
                FontFlags = GUI_FFLAG_BOLD
                align = "top_center"
                TextColour = Colour(255, 255, 255)
                move = {  right = 100, up = 1 }
  });
   lbl = UI.Label({
      id = "bluescore"  
                Text = blue
                FontSize = 12
                FontFlags = GUI_FFLAG_BOLD
                align = "top_center"
                TextColour = Colour(255, 255, 255)
                move = { left = 100 }
  });
        }
        else
        {
            lab.setText(""+min+" : "+sec+"");
            lbl.setText(red);
            lbl2.setText(blue);
        }
    }
}

function Announcement(msg)
{
    local lab = UI.Canvas("Annyy");
    local lbly = UI.Label("annlbly");
	if (!lab)
	{
  UI.Canvas({
        id = "Annyy"
        align = "center"
      move = { down = 150 }
        Color = Colour(0, 0, 0)
        Size = VectorScreen(0,0)
        flags = GUI_FLAG_BORDER
        Alpha = 100
        autoResize = true
        children = [
            UI.Label({
                id = "annlbly"
                Text = msg
                TextColour = Colour(255, 255, 255)
                fontFlags = GUI_FFLAG_BOLD | GUI_FFLAG_OUTLINE,
                FontSize = 16
            })
        ]
    })	    
}
else
{
	local love = UI.Canvas("Annyy");
        local L = UI.Label("annlbly");
		L.setText(msg);
		}
			ShY <-	::Timer.Create(this, function(nope){
        local love = UI.Canvas("Annyy");
        local L = UI.Label("annlbly");
        if (love && L)
        {
            love.fadeOut();
            L.fadeOut();
            love.destroy();
            L.destroy();
        }
    }, 6000, 1, "nope");
} 
/*
function Packs()
{
UI.Cursor("ON");
local canv = UI.Canvas({
id = "canvxd"
align = "center"
children = [
UI.Sprite({
id = "packsprite"
file = "Packs_UI.png"
align = "center"
Size = VectorScreen( 400, 400 )
onClick = function() {
this.SendToBottom();
}
})
UI.Sprite({
id = "ingram"
file = "ingram.png"
align = "center"
Size = VectorScreen( 70, 70 )
move = { up = 85, left = 122 }
Color = Colour( 255, 255, 255 )
onClick = function() {
SendDataToServer( Shy.Pack, "Ingram" );
}
})
UI.Sprite({
id = "uzi"
file = "uzi.png"
align = "center"
Size = VectorScreen( 120, 120 )
move = { up = 1, left = 122 }
//Color = Colour( 255, 255, 255 )
onClick = function() {
SendDataToServer( Shy.Pack, "Uzi" );
}
})
UI.Sprite({
id = "mp5"
file = "mp5.png"
align = "center"
Size = VectorScreen( 120, 120 )
move = { down = 85, left = 122 }
//Color = Colour( 255, 255, 255 )
onClick = function() {
SendDataToServer( Shy.Pack, "MP5" );
}
})
UI.Button({
id = "packbutton"
align = "center"
move = { up = 97, right = 76 }
Color = Colour( 0,0,101 )
Size = VectorScreen( 170, 40 )
Text = "Python, Shotgun, M60"
TextColor = Colour(255,255,255)
flags = GUI_FLAG_BORDER
onClick = function() {
SendDataToServer( Shy.Pack, "Pack1" );
}
})
UI.Button({
id = "packbutton2"
align = "center"
move = { up = 39, right = 80 }
Color = Colour( 0,0,101 )
Size = VectorScreen( 170, 40 )
Text = "Molotov,Stubby,Colt45"
TextColor = Colour(255,255,255)
flags = GUI_FLAG_BORDER
onClick = function() {
SendDataToServer( Shy.Pack, "Pack2" );
}
})
UI.Button({
id = "packbutton3"
align = "center"
move = { down = 26, right = 79 }
Color = Colour( 0,0,101 )
Size = VectorScreen( 170, 40 )
Text = "Stubby,M4,Colt45,Chinsaw"
TextColor = Colour(255,255,255)
flags = GUI_FLAG_BORDER
onClick = function() {
SendDataToServer( Shy.Pack, "Pack3" );
}
})
UI.Button({
id = "packbutton4"
align = "center"
move = { down = 95, right = 76 }
Color = Colour( 0,0,101 )
Size = VectorScreen( 170, 40 )
Text = "RPG, Stubby, Python, gernade"
TextColor = Colour(255,255,255)
flags = GUI_FLAG_BORDER
onClick = function() {
SendDataToServer( Shy.Pack, "Pack4" );
}
})
UI.Button({
id = "closeicon"
align = "top_right"
move = { down = 127, left = 225 }
Size = VectorScreen( 38, 23 )
Color = Colour( 0, 0, 141  )
Text = "Close"
TextColour = Colour( 255,255,255 )
onClick = function() {
UI.Cursor("OFF");
UI.Canvas("canvxd").destroy();
}
onHoverOver = function() {
this.Colour = ::Colour( 255, 0, 0 );
}
onHoverOut = function() {
this.Colour = ::Colour( 0,0,101 ); }
})
]
})
} 
*/

function ShowRules()
{
UI.Cursor("ON");
local srules = UI.Memobox({
      id = "serverrules"
	  align = "top_center"
	  Colour = Colour(0,0,0)
	  RelativeSize = [ "100%" "100%" ]
	  onClick = function() {
	   this.SendToBottom();
	   }
	   })
	            srules.FontSize = 15;
	            srules.FontFlags = GUI_FFLAG_BOLD;
               srules.AddLine("Server Rules:", Colour(255, 0, 0) );
               srules.AddLine("You're not allowed to do deathevade. The punishment may refer from offenses.", Colour( 255, 255, 255 ) );
               srules.AddLine("You're not allowed to use any illegal modifications or hacks. The punishment is a permanant ban.", Colour(255,255,255) );
               srules.AddLine("You're not allowed to abuse anyone or leak their personal information without their permission. The punishment may refer from offenses.", Colour(255,255,255) );
               srules.AddLine("You're not allowed to kill onduty admins. The punishment may refer from offenses.", Colour(255,255,255) );
               srules.AddLine("You're not allowed to take advantages from script bugs or VCMP bugs. The punishment may refer from offenses.", Colour(255,255,255) );
               srules.AddLine("You're not allowed to spam the chat. The punishment may refer from offenses.", Colour(255,255,255) );
               srules.AddLine("You're not allowed to evade the mute. The punishment may refer from offenses.", Colour(255,255,255) );
               srules.AddLine("You're not allowed to evade the ban. The punishment is a permanant ban and lowers your chances to get unban.", Colour(255,255,255) );
               srules.AddLine("You're not allowed to trick players to /q or anything else like givecash etc. The punishment may refer from offenses.", Colour(255,255,255) );
               srules.AddLine("You're not allowed to kill in bank. The punishment may refer from offenses.", Colour(255,255,255) );
               srules.AddLine("You're not allowed to do team kills. The punishment may refer from offenses.", Colour(255,255,255) );
               srules.AddLine("You're not allowed to use any other player's account without his/her permission.", Colour(255,255,255) );
               srules.AddLine("You're not allowed to interfair in admin talks. The punishment may refer from offenses.", Colour(255,255,255) );
               srules.AddLine("Visit our forum at vcz.vc-mp.cf for more information about rules and server updates.", Colour(255,255,255) );
              UI.Button({
                 id = "bot"
                align   = "top_center"
                Size    = VectorScreen(100,30)
                Colour  = Colour( 127,204,0)
                Text    = "Close"
                onClick = function() {
				    UI.Cursor("OFF");
					UI.Button("bot").destroy();
                    UI.Memobox("serverrules").destroy();
                }
           })
} 
function errorHandling(err)
{
 local stackInfos = getstackinfos(2);

 if (stackInfos)
 {
  local locals = "";

  foreach( index, value in stackInfos.locals )
  {
   if( index != "this" )
    locals = locals + "[" + index + "] " + value + "\n";
  }

  local callStacks = "";
  local level = 2;
  do {
   callStacks += "*FUNCTION [" + stackInfos.func + "()] " + stackInfos.src + " line [" + stackInfos.line + "]\n";
   level++;
  } while ((stackInfos = getstackinfos(level)));

  local errorMsg = "AN ERROR HAS OCCURRED [" + err + "]\n";
  errorMsg += "\nCALLSTACK\n";
  errorMsg += callStacks;
  errorMsg += "\nLOCALS\n";
  errorMsg += locals;

  Console.Print(errorMsg);
 }
}

seterrorhandler(errorHandling);

function SendDataToServer( ... )
{
    if( vargv[0] )
    {
        local   byte = vargv[0],
                len = vargv.len();
                
        if( 1 > len ) Console.Print( "ToClent <" + byte + "> No params specified." );
        else
        {
            local pftStream = Stream();
            pftStream.WriteByte( byte );

            for( local i = 1; i < len; i++ )
            {
                switch( typeof( vargv[i] ) )
                {
                    case "integer": pftStream.WriteInt( vargv[i] ); break;
                    case "string": pftStream.WriteString( vargv[i] ); break;
                    case "float": pftStream.WriteFloat( vargv[i] ); break;
                }
            }
            
            Server.SendData( pftStream );
        }
    }
    else Console.Print( "ToClient: Not even the byte was specified..." );
}