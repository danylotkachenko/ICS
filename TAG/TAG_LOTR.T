%Game board (10 by 10)
var isentinel : string := "stop" %exits the game
var ianswer : string %direction in which user wants to go
var isteps : int := 0 %calculates # of steps taken
var ix, iy : int := 1 %x and y values that make up the field
var irope : int %generates random number, if it is correct then user founds a rope
var iforces : int %generates random number, if it is correct then other command generates a unit
var icreature : int %generates 1 of 3 different types of enemies
var inum1 : int := 1 %correct condition for generating a rope
var inum2 : int := 2 %correct condition for generating an enemy
var inum3 : int := 3 %another correct condition for generating an enemy
var inum4 : int := 4
var ianswer2 : string %true or false condition, if it is true user takes the rope, if it is wrong user doesn't take it
var iobjects : int := 0 %condition which makes it impossble to take a rope more than once
var icommand : string %condition which allows user to get down from the cliff
var icommand_correct : string := "use" %correct answer to the icommand, if it is inputted user gets down from the cliff
var ianswer3 : string %gets one of two possible answers, whether user wants to fight or retreat
var ianswer4 : string %gets one of three possible answers, combat options
%var ianswer5 : string %tells whether user wants to play a game
var ianswer6 : string
var ipoints_lost : int %random command, which generates number of points lost
var ilife_scale : int := 100 %shows # of points you have, decreses # after combat situation
var imission_lost : int := 0 %condition similar to boolean, if it is positive user loses, end of the game is implemented
var ch : string (1) %program  to  pause  until  the  user presses a key
var imax_count : int := 10 %starting amount of life points, one asteriks stands for 10 points
var igame_won : int := 0
var ifont : int := Font.New ("Times New Roman:24:bold")
var ifont2 : int := Font.New ("Times New Roman:18:bold")

%BEGIN MOUNTAIN DEFINITION
var mountain : array 1 .. 10, 1 .. 10 of int

for i : 1 .. 10
    for j : 1 .. 10
        mountain (i, j) := 0
    end for
end for

mountain (10, 10) := 3
mountain (9, 10) := 2
mountain (10, 9) := 2
mountain (9, 9) := 1
mountain (9, 8) := 2
mountain (8, 9) := 1
mountain (8, 8) := 0
mountain (8, 10) := 0
mountain (10, 8) := 0
%END MOUNTAIN DEFINITION

var istatement : string := "You can't go that way. You are on the very edge of the field."
var istatement2 : string
var istatement3 : string
var istatement4 : string
var istatement5 : string
var istatement6 : string


function CanIGoThroughMountain (direction : string) : boolean

    var newX : int
    var newY : int

    if iy = 7 and ix > 7 then
        put "In north direction you can see Mount Doom. The only thing left to do is ascend the mountain and destroy the Ring."
    end if
    if ix = 7 and iy > 7 then
        put "You finally reached Mount Doom. Now you have to find a safe path to the entrance."
    end if

    if (direction = "east") then
        newX := ix + 1
        newY := iy
    end if
    if (direction = "west") then
        newX := ix - 1
        newY := iy
    end if
    if (direction = "north") then
        newX := ix
        newY := iy + 1
    end if
    if (direction = "south") then
        newX := ix
        newY := iy - 1
    end if

    %put "Coordinates: ", ix, " ", iy
    %put "array indecies: ", newX, " ", newY
    if (abs (mountain (newX, newY) - mountain (ix, iy)) > 1) then
        put "It is impossible to go that way. Let's find another path."
        result false
    else
        result true
    end if
end CanIGoThroughMountain


View.Set ("nocursor")
Text.ColourBack (red)
cls
Font.Draw ("THE LORD OF THE RINGS - LABYRINTH", 9, 205, ifont, black)
Font.Draw ("By Danylo Tkachenko", 196, 18, ifont2, black)
getch (ch)

%setscreen ("graphics:800;600")
Text.Colour (yellow)
Text.ColourBack (black)
cls
locate (1, 23)
put "THE LORD OF THE RINGS - LABYRINTH"
put " "
put "     Middle-earth is under attack. Sauron, a being of unfathomable evil, plans  to rule the lands using the will sapping Rings of Power. " ..
put "His forces include vileOrcs, hordes of slavering Goblins, the mighty Ringwraith and more."
put " "
put "     Standing between Sauron and the One Ring he needs to complete his "
put "tyrannical plans are a few desperate heroes. Hobbits, small in stature, but "
put "stout hearted, may be the key. They form a fellowship with Men, weak but "
put "passionate, powerful Dwarves, graceful Elves - each sending representatives to "
put "serve the good of all free people of Middle-earth."
put " "
put "     You play as Frodo Baggins, a Hobbit whos destiny is to destroy the One "
put "Ring. You meet Frodo on the final " ..
put "stage of the jorney, where there is danger on every corner. You need to help him cross the wastes of Mordor so he can "
put "destroy the Ring in the Mount Doom and free the lands from the darkness."
put " "
put "To contiue press any key."
getch (ch)
cls

locate (1, 33)
put "Tutorial"
put "1. To move around use compass directions - south, north, east and west only"
put "2. To attack an enemy unit - attack"
put "3. To retreat from the enemy unit - retreat"
put "4. To use an object - use"
put "5. Other not commonly used commands will be provided during the game"
put "6. To exit the game - stop"
put " "
put "To start the game press any key"
getch (ch)
cls

loop
    %put " "
    put "Life scale: ", ilife_scale
    imax_count := ilife_scale div 10
    for icount : 0 .. imax_count
        put "*" ..
    end for
    put " "

    put "Where would you like to go?"
    get ianswer

    if ianswer = "south" then
        if iy = 4 and ix < 4 then     %add same if statement to four other sides
            put "There is a tall cliff in front of you. You can't climb on it."
        else
            if iy = 1 then
                put istatement
            else
                if CanIGoThroughMountain ("south") then
                    iy := iy - 1
                    isteps := isteps + 1
                    randint (irope, 1, 4)
                    if iobjects = 1 then
                        irope := 0
                    end if
                    if irope = inum1 or irope = inum4 then
                        put "You found an Elvish rope. It was lying in the trunk of the tree."
                        loop
                            put "Would you like to take a rope?"
                            get ianswer2
                            if ianswer2 = "yes" then
                                iobjects := iobjects + 1
                                put "You took the rope."
                            end if
                            if ianswer2 = "no" then
                                iobjects := iobjects + 0
                                put "You didn't take the rope."
                            end if
                            if ianswer2 not= "yes" and ianswer2 not= "no" then
                                iobjects := iobjects + 0
                                put "Invalid answer"
                            end if
                            exit when ianswer2 = "yes" or ianswer2 = "no"
                        end loop
                    end if
                    if iy > 3 or ix > 3 then         %add x
                        randint (iforces, 1, 4)
                        if iforces = inum2 or iforces = inum3 then
                            randint (icreature, 3, 5)

                            if icreature = 3 then
                                put "There are vile Orcs blocking the path. You have two options: "
                                loop
                                    put "a) Retreat - move to where you came from."
                                    put "b) Attack - fight Sauron's forces."
                                    get ianswer3
                                    if ianswer3 = "retreat" then
                                        iy := iy + 1
                                    end if
                                    if ianswer3 = "attack" then
                                        iy := iy + 0
                                        isteps := isteps + 0
                                        randint (ipoints_lost, 1, 10)
                                        ilife_scale := ilife_scale - ipoints_lost
                                        if ilife_scale > 0 then
                                            put "You successfully defeated all of the Orcs. During the fight you lost ", ipoints_lost, " points."
                                            put "The pass is clear for now."
                                        else
                                            put "You were defeated."
                                            imission_lost := imission_lost + 1
                                            %implement end of the game when ilife_scale is zero or less
                                        end if
                                    end if
                                    if ianswer3 not= "retreat" and ianswer3 not= "attack" then
                                        put "Invalid command."
                                    end if
                                    exit when ianswer3 = "retreat" or ianswer3 = "attack"
                                end loop
                            end if

                            if icreature = 4 then
                                put "You were attacked by a horde of Goblins. "
                                put "You are trapped. Your only option is to fight them."
                                delay (3000)
                                iy := iy + 0
                                isteps := isteps + 0
                                randint (ipoints_lost, 1, 15)
                                ilife_scale := ilife_scale - ipoints_lost
                                put "You defeated the enemy. During the fight you lost ", ipoints_lost, " points."
                                if ilife_scale <= 0 then
                                    put "You weren't able to win. You run out of energy."
                                    %game ends if ilife_points <= 0
                                    imission_lost := imission_lost + 1
                                end if
                            end if

                            if icreature = 5 then
                                put "There is a Ringwraith on your way. The only options that can save you are:"
                                %put "from the Nazgul."
                                loop
                                    put "a) Hide - put the One Ring on. "
                                    put "b) Attack - attack the Ringwraith."
                                    put "c) Give - give the Ring to the Nazgul."
                                    get ianswer4
                                    if ianswer4 = "hide" then
                                        iy := iy + 0
                                        isteps := isteps + 0
                                        randint (ipoints_lost, 10, 30)
                                        ilife_scale := ilife_scale - ipoints_lost
                                        if ipoints_lost > 15 and ilife_scale > 0 then
                                            put "Ringwraith can sense the Ring. You are still visible to him!"
                                            delay (2000)
                                            put "You were able to win the round. Though, you sustained heavy damage. You lost " ..
                                            put ipoints_lost, "points."
                                        else
                                            if ipoints_lost <= 15 and ilife_scale > 0 then
                                                put "Ringwraith can see you even when you are invisible. Luckily, you were able to defeat him. During the fight you lost " ..
                                                put ipoints_lost, " life points. Not bad at all, considering you were fighting a Nazgul."
                                            end if
                                        end if
                                        if ilife_scale <= 0 then
                                            put "You were defeated."
                                            imission_lost := imission_lost + 1
                                            %implement end of the game when ilife_scale is zero or less
                                        end if
                                    end if
                                    if ianswer4 = "attack" then
                                        iy := iy + 0
                                        isteps := isteps + 0
                                        randint (ipoints_lost, 10, 20)
                                        ilife_scale := ilife_scale - ipoints_lost
                                        if ilife_scale > 0 then
                                            put "You were able to defeat the mighty Nazgul. It cost you ", ipoints_lost, " points."
                                        else
                                            put "You were defeated."
                                            imission_lost := imission_lost + 1
                                            %implement end of the game when ilife_scale is zero or less
                                        end if
                                    end if
                                    if ianswer4 = "give" then
                                        put "You lost. Now middle-earth will get thrown into an Age of Darkness."
                                        isteps := isteps + 0
                                        imission_lost := imission_lost + 1
                                        %implement end of the game when ilife_scale is zero or less
                                    end if
                                    if ianswer4 not= "hide" and ianswer4 not= "attack" and ianswer4 not= "give" then
                                        put "Invalid command. Try again."
                                    end if
                                    exit when ianswer4 = "hide" or ianswer4 = "attack" or ianswer4 = "give" or imission_lost = 1
                                    %exit when imission_lost = 1
                                end loop
                            end if
                        end if
                    end if
                end if
            end if
        end if
    end if

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ianswer = "north" then

        if ix = 10 and iy = 10 then
            loop
                put "You reached your final destination. You have to throw the ring into The Crack of Doom. Now, would you like to do so?"
                get ianswer6
                if ianswer6 = "yes" then
                    put "You destroyed the ring!"
                    igame_won := igame_won + 1
                end if
                if ianswer6 = "no" then
                    put "You succumbed to the Ring's power and claimed it as your own."
                    delay (2500)
                    put "Just as you put the ring on ,Gollum (who had been following you all along)"
                    put "attacks and bites off your finger and the Ring. Gollum gloats over getting his "
                    put "precious back, but he ends up losing his balance and falls to death and "
                    put "takes the Ring with him. The Ring is finally destroyed, freeing Middle-earth "
                    put "from Sauron's power. Mount Doom erupts violently, trapping you among the lava"
                    put "flows until the Great Eagles rescue you."
                    igame_won := igame_won + 1
                end if
                if ianswer6 not= "yes" and ianswer6 not= "no" then
                    put "Wrong input."
                end if
                exit when igame_won = 1
            end loop
        end if

        if iy = 10 then
            put istatement
        else
            if iy = 3 and ix < 4 then
                put "You can't go there. You're standing on the edge of the cliff. "
                put "You have to get down from it to continue your jorney."
                if iobjects = 1 then
                    put "Since you have a rope you can try to get down. "
                    put "To activate the rope type in (use)."
                    get icommand
                    if icommand = icommand_correct then
                        iy := iy + 1
                        isteps := isteps + 1
                        put "You got down."
                    end if
                end if
            else
                if CanIGoThroughMountain ("north") then
                    iy := iy + 1
                    isteps := isteps + 1

                    randint (irope, 1, 4)
                    if iobjects = 1 then
                        irope := 0
                    end if
                    if irope = inum1 or irope = inum4 then
                        put "You found a rope."
                        loop
                            put "Would you like to take a rope?"
                            get ianswer2
                            if ianswer2 = "yes" then
                                iobjects := iobjects + 1
                                put "You took the rope."
                            end if
                            if ianswer2 = "no" then
                                iobjects := iobjects + 0
                                put "You didn't take the rope."
                            end if
                            if ianswer2 not= "yes" and ianswer2 not= "no" then
                                iobjects := iobjects + 0
                                put "Invalid answer"
                            end if
                            exit when ianswer2 = "yes" or ianswer2 = "no"
                        end loop
                    end if
                    if iy > 3 or ix > 3 then         %add x
                        randint (iforces, 1, 4)
                        if iforces = inum2 or iforces = inum3 then
                            randint (icreature, 3, 5)

                            if icreature = 3 then
                                put "There are vile Orcs blocking the path. You have two options: "
                                loop
                                    put "a) Retreat - move to your previous location."
                                    put "b) Attack - fight Sauron's forces."
                                    get ianswer3
                                    if ianswer3 = "retreat" then
                                        iy := iy - 1
                                    end if
                                    if ianswer3 = "attack" then
                                        iy := iy + 0
                                        isteps := isteps + 0
                                        randint (ipoints_lost, 1, 10)
                                        ilife_scale := ilife_scale - ipoints_lost
                                        if ilife_scale > 0 then
                                            put "You successfully defeated all of the Orcs. During the fight you lost ", ipoints_lost, " points."
                                        else
                                            put "You were defeated."
                                            imission_lost := imission_lost + 1
                                            %implement end of the game when ilife_scale is zero or less
                                        end if
                                    end if
                                    if ianswer3 not= "retreat" and ianswer3 not= "attack" then
                                        put "Invalid command."
                                    end if
                                    exit when ianswer3 = "retreat" or ianswer3 = "attack"
                                end loop
                            end if

                            if icreature = 4 then
                                put "You were attacked by a horde of Goblins. " ..
                                put "You are trapped. Your only option is to defeat them."
                                delay (3000)
                                iy := iy + 0
                                isteps := isteps + 0
                                randint (ipoints_lost, 1, 15)
                                ilife_scale := ilife_scale - ipoints_lost
                                put "You defeated the enemy. During the fight you lost ", ipoints_lost, " points."
                                if ilife_scale <= 0 then
                                    put "You were defeated. Now Sauron will rule the middle-earth."
                                    %game ends if ilife_points <= 0
                                    imission_lost := imission_lost + 1
                                end if
                            end if

                            if icreature = 5 then
                                put "There is a Ringwraith on your way. You have a few options, which can save you"
                                put "from the Nazgul."
                                loop
                                    put "a) Hide - put the One Ring on. "
                                    put "b) Attack - attack the Ringwraith."
                                    put "c) Give - give the Ring to the Ringwraith."
                                    get ianswer4
                                    if ianswer4 = "hide" then
                                        iy := iy + 0
                                        isteps := isteps + 0
                                        randint (ipoints_lost, 10, 30)
                                        ilife_scale := ilife_scale - ipoints_lost
                                        if ipoints_lost > 15 and ilife_scale > 0 then
                                            put "Nazgul can still see you."
                                            delay (1000)
                                            put "You were able to win the fight. Though, you sustained heavy damage. You lost ", ipoints_lost, " points."
                                        else
                                            if ipoints_lost <= 15 and ilife_scale > 0 then
                                                put "Ringwraith can see you even when you are invisible to everyone. Still, you were able to defeat him. During the fight you lost " ..
                                                put ipoints_lost, " life points. Not bad at all, "
                                                put "considering you were fighting a Nazgul."
                                            end if
                                        end if
                                        if ilife_scale <= 0 then
                                            put "You were defeated."
                                            imission_lost := imission_lost + 1
                                            %implement end of the game when ilife_scale is zero or less
                                        end if
                                    end if
                                    if ianswer4 = "attack" then
                                        iy := iy + 0
                                        isteps := isteps + 0
                                        randint (ipoints_lost, 10, 20)
                                        ilife_scale := ilife_scale - ipoints_lost
                                        if ilife_scale > 0 then
                                            put "You were able to defeat the mighty Nazgul. It cost you ", ipoints_lost, " points."
                                        else
                                            put "You were defeated."
                                            imission_lost := imission_lost + 1
                                            %implement end of the game when ilife_scale is zero or less
                                        end if
                                    end if
                                    if ianswer4 = "give" then
                                        put "You lost. Middle-earth will get thrown into an Age of Darkness."
                                        isteps := isteps + 0
                                        imission_lost := imission_lost + 1
                                        %implement end of the game when ilife_scale is zero or less
                                    end if
                                    if ianswer4 not= "hide" and ianswer4 not= "attack" and ianswer4 not= "give" then
                                        put "Invalid command. Try again."
                                    end if
                                    exit when ianswer4 = "hide" or ianswer4 = "attack" or ianswer4 = "give" or imission_lost = 1
                                    %exit when imission_lost = 1
                                end loop
                            end if
                        end if
                    end if
                end if
            end if
        end if
    end if

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ianswer = "west" then
        if ix = 4 and iy < 4 then         %add same if statement to all four sides
            put "There is a cliff in front of you. You can't climb on it."
        else
            if ix = 1 then
                put istatement
            else
                if CanIGoThroughMountain ("west") then
                    ix := ix - 1
                    isteps := isteps + 1

                    randint (irope, 1, 4)
                    if iobjects = 1 then
                        irope := 0
                    end if
                    if irope = inum1 or irope = inum4 then
                        put "You found an Elvish rope. It was hidden behind the rock."
                        loop
                            put "Would you like to take a rope?"
                            get ianswer2
                            if ianswer2 = "yes" then
                                iobjects := iobjects + 1
                                put "You took the rope."
                            end if
                            if ianswer2 = "no" then
                                iobjects := iobjects + 0
                                put "You didn't take the rope. Such a pity."
                            end if
                            if ianswer2 not= "yes" and ianswer2 not= "no" then
                                iobjects := iobjects + 0
                                put "Invalid answer"
                            end if
                            exit when ianswer2 = "yes" or ianswer2 = "no"
                        end loop
                    end if
                    if ix > 3 or iy > 3 then         %add x
                        randint (iforces, 1, 4)
                        if iforces = inum2 or iforces = inum3 then
                            randint (icreature, 3, 5)

                            if icreature = 3 then
                                put "There are vile Orcs blocking the path. You have two options: "
                                loop
                                    put "a) Retreat - move to where you came from."
                                    put "b) Attack - fight Sauron's forces."
                                    get ianswer3
                                    if ianswer3 = "retreat" then
                                        ix := ix + 1
                                    end if
                                    if ianswer3 = "attack" then
                                        ix := ix + 0
                                        isteps := isteps + 0
                                        randint (ipoints_lost, 1, 10)
                                        ilife_scale := ilife_scale - ipoints_lost
                                        if ilife_scale > 0 then
                                            put "You successfully defeated all of the Orcs. During the fight you lost ", ipoints_lost, " points."
                                        else
                                            put "You were defeated."
                                            imission_lost := imission_lost + 1
                                            %implement end of the game when ilife_scale is zero or less
                                        end if
                                    end if
                                    if ianswer3 not= "retreat" and ianswer3 not= "attack" then
                                        put "Invalid command."
                                    end if
                                    exit when ianswer3 = "retreat" or ianswer3 = "attack"
                                end loop
                            end if

                            if icreature = 4 then
                                put "You were attacked by a horde of Goblins. " ..
                                put "You are trapped. Your only option is to defeat them."
                                delay (3000)
                                ix := ix + 0
                                isteps := isteps + 0
                                randint (ipoints_lost, 1, 15)
                                ilife_scale := ilife_scale - ipoints_lost
                                put "You defeated the enemy. During the fight you lost ", ipoints_lost, " points."
                                if ilife_scale <= 0 then
                                    put "You run out of energy. You were so close!"
                                    %game ends if ilife_points <= 0
                                    imission_lost := imission_lost + 1
                                end if
                            end if

                            if icreature = 5 then
                                put "There is a Ringwraith on your way. You have a few options, which can save you."
                                put "from the Nazgul."
                                loop
                                    put "a) Hide - put the One Ring on. "
                                    put "b) Attack - attack the Ringwraith."
                                    put "c) Give - give the Ring to the Nazgul."
                                    get ianswer4
                                    if ianswer4 = "hide" then
                                        ix := ix + 0
                                        isteps := isteps + 0
                                        randint (ipoints_lost, 10, 30)
                                        ilife_scale := ilife_scale - ipoints_lost
                                        if ipoints_lost > 15 and ilife_scale > 0 then
                                            put "Nazgul spotted you. There is nowhere to hide. You have to face him."
                                            delay (1000)
                                            put "You were able to win the round. Though, you sustained heavy damage. You lost " ..
                                            put ipoints_lost, "points."
                                        else
                                            if ipoints_lost <= 15 and ilife_scale > 0 then
                                                put "Ringwraith can see you even when you are invisible to everyone. Still, you were able to defeat him. During the fight you lost " ..
                                                put ipoints_lost, " life points. Not bad at all, considering you were fighting a Nazgul."
                                            end if
                                        end if
                                        if ilife_scale <= 0 then
                                            put "You were defeated."
                                            imission_lost := imission_lost + 1
                                            %implement end of the game when ilife_scale is zero or less
                                        end if
                                    end if
                                    if ianswer4 = "attack" then
                                        ix := ix + 0
                                        isteps := isteps + 0
                                        randint (ipoints_lost, 10, 20)
                                        ilife_scale := ilife_scale - ipoints_lost
                                        if ilife_scale > 0 then
                                            put "You were able to defeat the mighty Nazgul. It cost you ", ipoints_lost, " points."
                                        else
                                            put "You were defeated."
                                            imission_lost := imission_lost + 1
                                            %implement end of the game when ilife_scale is zero or less
                                        end if
                                    end if
                                    if ianswer4 = "give" then
                                        put "You lost. Middle-earth will get thrown into an Age of Darkness."
                                        isteps := isteps + 0
                                        imission_lost := imission_lost + 1
                                        %implement end of the game when ilife_scale is zero or less
                                    end if
                                    if ianswer4 not= "hide" and ianswer4 not= "attack" and ianswer4 not= "give" then
                                        put "Invalid command. Try again."
                                    end if
                                    exit when ianswer4 = "hide" or ianswer4 = "attack" or ianswer4 = "give" or imission_lost = 1
                                    %exit when imission_lost = 1
                                end loop
                            end if
                        end if
                    end if
                end if
            end if
        end if
    end if

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ianswer = "east" then

        if ix = 10 and iy = 10 then
            loop
                put "You reached your final destination. You have to throw the ring into The Crack of Doom. Now, would you like to do so?"
                get ianswer6
                if ianswer6 = "yes" then
                    put "You destroyed the ring!"
                    igame_won := igame_won + 1
                end if
                if ianswer6 = "no" then
                    put "You succumbed to the Ring's power and claimed it as your own."
                    delay (2500)
                    put "Just as you put the ring on ,Gollum (who had been following you all along)"
                    put "attacks and bites off your finger and the Ring. Gollum gloats over getting his "
                    put "precious back, but he ends up losing his balance and falls to death and "
                    put "takes the Ring with him. The Ring is finally destroyed, freeing Middle-earth "
                    put "from Sauron's power. Mount Doom erupts violently, trapping you among the lava"
                    put "flows until the Great Eagles rescue you."
                    igame_won := igame_won + 1
                end if
                if ianswer6 not= "yes" and ianswer6 not= "no" then
                    put "Wrong input."
                end if
                exit when igame_won = 1
            end loop
        end if

        if ix = 10 then
            put istatement
        else
            if ix = 3 and iy < 4 then
                put "You can't go there. You're standing on the edge of the cliff."
                put "You have to get down from it to continue your jorney."
                if iobjects = 1 then
                    put "Since you have a rope you can try to get down."
                    put "To activate the rope type in (use)."
                    get icommand
                    if icommand = icommand_correct then
                        ix := ix + 1
                        isteps := isteps + 1
                        put "You got down."
                    end if
                end if
            else
                if CanIGoThroughMountain ("east") then
                    ix := ix + 1
                    isteps := isteps + 1

                    randint (irope, 1, 4)
                    if iobjects = 1 then
                        irope := 0
                    end if
                    if irope = inum1 or irope = inum4 then
                        put "You found a rope. It was hidden in the small cave you noticed."
                        put "Judging by the small it belonged to the mountain troll."
                        loop
                            put "Would you like to take it?"
                            get ianswer2
                            if ianswer2 = "yes" then
                                iobjects := iobjects + 1
                                put "You took the rope."
                            end if
                            if ianswer2 = "no" then
                                iobjects := iobjects + 0
                                put "You didn't take the rope."
                            end if
                            if ianswer2 not= "yes" and ianswer2 not= "no" then
                                iobjects := iobjects + 0
                                put "Invalid answer"
                            end if
                            exit when ianswer2 = "yes" or ianswer2 = "no"
                        end loop
                    end if
                    if ix > 3 or iy > 3 then         %add x
                        randint (iforces, 1, 4)
                        if iforces = inum2 or iforces = inum3 then
                            randint (icreature, 3, 5)

                            if icreature = 3 then
                                put "There are vile Orcs blocking the path. You have two options: "
                                loop
                                    put "a) Retreat - move to where you came from."
                                    put "b) Attack - fight Sauron's forces. It is possible to lose life points!"
                                    get ianswer3
                                    if ianswer3 = "retreat" then
                                        ix := ix - 1
                                    end if
                                    if ianswer3 = "attack" then
                                        ix := ix + 0
                                        isteps := isteps + 0
                                        randint (ipoints_lost, 1, 10)
                                        ilife_scale := ilife_scale - ipoints_lost
                                        if ilife_scale > 0 then
                                            put "You successfully defeated all of the Orcs. During the fight you lost ", ipoints_lost, " points."
                                        else
                                            put "You were defeated."
                                            imission_lost := imission_lost + 1
                                            %implement end of the game when ilife_scale is zero or less
                                        end if
                                    end if
                                    if ianswer3 not= "retreat" and ianswer3 not= "attack" then
                                        put "Invalid command."
                                    end if
                                    exit when ianswer3 = "retreat" or ianswer3 = "attack"
                                end loop
                            end if

                            if icreature = 4 then
                                put "You were attacked by a horde of Goblins. " ..
                                put "You are trapped. Your only option is to defeat them."
                                delay (3000)
                                ix := ix + 0
                                isteps := isteps + 0
                                randint (ipoints_lost, 1, 15)
                                ilife_scale := ilife_scale - ipoints_lost
                                put "You defeated the enemy. During the fight you lost ", ipoints_lost, " points."
                                if ilife_scale <= 0 then
                                    put "You were defeated. Therefore you lost the game."
                                    %game ends if ilife_points <= 0
                                    imission_lost := imission_lost + 1
                                end if
                            end if

                            if icreature = 5 then
                                put "There is a Ringwraith on your way. You have a few options, which can save you"
                                put "from the Nazgul."
                                loop
                                    put "a) Hide - put the One Ring on. "
                                    put "b) Attack - attack the Ringwraith."
                                    put "c) Give - give the Ring to the Nazgul."
                                    get ianswer4
                                    if ianswer4 = "hide" then
                                        ix := ix + 0
                                        isteps := isteps + 0
                                        randint (ipoints_lost, 10, 30)
                                        ilife_scale := ilife_scale - ipoints_lost
                                        if ipoints_lost > 15 and ilife_scale > 0 then
                                            put "Even with the ring on Nazgul was able to see you. You were able to win the round. Though, you sustained heavy damage. You lost " ..
                                            put ipoints_lost, "points."
                                        else
                                            if ipoints_lost <= 15 and ilife_scale > 0 then
                                                put "Ringwraith can see you even when you are invisible to everyone. Still, you were able to defeat him. During the fight you lost " ..
                                                put ipoints_lost, "life points. Not bad at all, considering you were fighting a Nazgul."
                                            end if
                                        end if
                                        if ilife_scale <= 0 then
                                            put "You were defeated."
                                            imission_lost := imission_lost + 1
                                            %implement end of the game when ilife_scale is zero or less
                                        end if
                                    end if
                                    if ianswer4 = "attack" then
                                        ix := ix + 0
                                        isteps := isteps + 0
                                        randint (ipoints_lost, 10, 20)
                                        ilife_scale := ilife_scale - ipoints_lost
                                        if ilife_scale > 0 then
                                            put "You were able to defeat the mighty Nazgul. It cost you ", ipoints_lost, " points."
                                        else
                                            put "You were defeated."
                                            imission_lost := imission_lost + 1
                                            %implement end of the game when ilife_scale is zero or less
                                        end if
                                    end if
                                    if ianswer4 = "give" then
                                        put "You lost. Middle-earth will get thrown into an Age of Darkness."
                                        isteps := isteps + 0
                                        imission_lost := imission_lost + 1
                                        %implement end of the game when ilife_scale is zero or less
                                    end if
                                    if ianswer4 not= "hide" and ianswer4 not= "attack" and ianswer4 not= "give" then
                                        put "Invalid command. Try again."
                                    end if
                                    exit when ianswer4 = "hide" or ianswer4 = "attack" or ianswer4 = "give" or imission_lost = 1
                                    %exit when imission_lost = 1
                                end loop
                            end if
                        end if
                    end if
                end if
            end if
        end if
    end if

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    exit when ianswer = isentinel or imission_lost = 1 or igame_won = 1
    %exit when imission_lost = 1
end loop
if imission_lost = 1 then
    Text.Colour (red)
    put " "
    put "   The Age of Men is over. The time of the Orcs has come. - Gothmog, Orc Leader"
else
    if ianswer = isentinel then
        Text.Colour (green)
        put "Would you like to play again?"
    else
        if igame_won = 1 then
            Text.Colour (white)
            put " "
            %put "You destroyed the One Ring and saved all of the free people of Middle-earth."
            put "   Let us together rebuild this world that we may share in the days of peace. - Aragorn"
        end if
    end if
end if
%put ilife_scale
put "# of steps ", isteps
put "x-value is ", ix
put "y-value is ", iy
