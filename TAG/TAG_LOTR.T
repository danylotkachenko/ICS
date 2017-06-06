%Game board (10 by 10)
var isentinel : string := "stop"
var ianswer : string
var isteps : int := 0
var ix, iy : int := 1
var irope : int
var iforces : int
var icreature : int
var inum1 : int := 1
var inum2 : int := 2
var inum3 : int := 3
var ianswer2 : string
var iobjects : int := 0
var icommand : string
var icommand_correct : string := "use"
var ianswer3 : string
var ianswer4 : string
var ipoints_lost : int
var ilife_scale : int := 100
var imission_lost : int := 0
var ch : string (1)

var istatement : string := "You can't go that way. You are on the very edge of the field."
var istatement2 : string
var istatement3 : string
var istatement4 : string
var istatement5 : string
var istatement6 : string
%setscreen ("graphics:800;600")
Text.Colour (yellow)
Text.ColourBack (black)
cls
locate (1, 23)
put "THE LORD OF THE RINGS - LABYRINTH"
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
    for icount : 0 .. 10
        put "*" ..
    end for
    put " "

    put "Where would you like to go?"
    get ianswer

    if ianswer = "south" then
        if iy = 4 and ix < 4 then %add same if statement to four other sides
            put "There is a cliff in front of you. You can't climb on it."
        else
            if iy = 1 then
                put istatement
            else
                iy := iy - 1
                isteps := isteps + 1
                randint (irope, 1, 4)
                if iobjects = 1 then
                    irope := 0
                end if
                if irope = inum1 then
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
            end if
        end if
        if iy > 3 or ix > 3 then         %add x
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
                            iy := iy + 0
                        end if
                        if ianswer3 = "attack" then
                            iy := iy - 1
                            isteps := isteps + 1
                            randint (ipoints_lost, 1, 10)
                            ilife_scale := ilife_scale - ipoints_lost
                            if ilife_scale > 0 then
                                put "You sucessfully defeated all of the Orcs. During the fight you lost ", ipoints_lost, " points."
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
                    put "You were attacked by a horde of Goblins." ..
                    put " You are trapped. Your only option is to defeat them."
                    iy := iy - 1
                    isteps := isteps + 1
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
                    put "There is a Ringwraith on your way. You have a few options, which can save you from the Nazgul."
                    loop
                        put "a) Hide - put the One Ring on. "
                        put "b) Attack - attack the Ringwraith."
                        put "c) Give - give the Ring to the Nazgul."
                        get ianswer4
                        if ianswer4 = "hide" then
                            iy := iy - 1
                            isteps := isteps + 1
                            randint (ipoints_lost, 10, 30)
                            ilife_scale := ilife_scale - ipoints_lost
                            if ipoints_lost > 15 and ilife_scale > 0 then
                                put "Even with the Ring on Nazgul was able to see you. You were able to win the round. Though, you sustained heavy damage. You lost " ..
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
                            iy := iy - 1
                            isteps := isteps + 1
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
                            put "You lost. Middle-earth will get thrown into an Age OF Darkness."
                            isteps := isteps + 1
                            imission_lost := imission_lost + 1
                            %implement end of the game when ilife_scale is zero or less
                        end if
                        if ianswer4 not= "hide" and ianswer4 not= "attack" and ianswer4 not= "give" then
                            put "Invalid command. Try again."
                        end if
                        exit when ianswer4 = "hide" or ianswer4 = "attack" or ianswer4 = "give"
                        exit when imission_lost = 1
                    end loop
                end if
            end if
        end if
    end if

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ianswer = "north" then
        if iy = 10 then
            put istatement
        else
            if iy = 3 and ix < 4 then
                put "You can't go there. You're standing on the edge of the cliff. You have to get down from it to continue your jorney."
                if iobjects = 1 then
                    put "Since you have a rope you can try to get down. To activate the rope type in (use)."
                    get icommand
                    if icommand = icommand_correct then
                        iy := iy + 1
                        isteps := isteps + 1
                        put "You got down."
                    end if
                end if
            else
                iy := iy + 1
                isteps := isteps + 1

                randint (irope, 1, 4)
                if iobjects = 1 then
                    irope := 0
                end if
                if irope = inum1 then
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
            end if
        end if
        if iy > 3 or ix > 3 then     %add x
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
                            iy := iy + 0
                        end if
                        if ianswer3 = "attack" then
                            iy := iy + 1
                            isteps := isteps + 1
                            randint (ipoints_lost, 1, 10)
                            ilife_scale := ilife_scale - ipoints_lost
                            if ilife_scale > 0 then
                                put "You sucessfully defeated all of the Orcs. During the fight you lost ", ipoints_lost, " points."
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
                    put "You were attacked by a horde of Goblins." ..
                    put " You are trapped. Your only option is to defeat them."
                    iy := iy + 1
                    isteps := isteps + 1
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
                    put "There is a Ringwraith on your way. You have a few options, which can save you from the Nazgul."
                    loop
                        put "a) Hide - put the One Ring on. "
                        put "b) Attack - attack the Ringwraith."
                        put "c) Give - give the Ring to the Nazgul."
                        get ianswer4
                        if ianswer4 = "hide" then
                            iy := iy + 1
                            isteps := isteps + 1
                            randint (ipoints_lost, 10, 30)
                            ilife_scale := ilife_scale - ipoints_lost
                            if ipoints_lost > 15 and ilife_scale > 0 then
                                put "Even with the Ring on Nazgul was able to see you. You were able to win the round. Though, you sustained heavy damage. You lost " ..
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
                            iy := iy + 1
                            isteps := isteps + 1
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
                            put "You lost. Middle-earth will get thrown into an Age OF Darkness."
                            isteps := isteps + 1
                            imission_lost := imission_lost + 1
                            %implement end of the game when ilife_scale is zero or less
                        end if
                        if ianswer4 not= "hide" and ianswer4 not= "attack" and ianswer4 not= "give" then
                            put "Invalid command. Try again."
                        end if
                        exit when ianswer4 = "hide" or ianswer4 = "attack" or ianswer4 = "give"
                        exit when imission_lost = 1
                    end loop
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
                ix := ix - 1
                isteps := isteps + 1

                randint (irope, 1, 4)
                if iobjects = 1 then
                    irope := 0
                end if
                if irope = inum1 then
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
            end if
        end if
        if ix > 3 or iy > 3 then     %add x
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
                            ix := ix + 0
                        end if
                        if ianswer3 = "attack" then
                            ix := ix - 1
                            isteps := isteps + 1
                            randint (ipoints_lost, 1, 10)
                            ilife_scale := ilife_scale - ipoints_lost
                            if ilife_scale > 0 then
                                put "You sucessfully defeated all of the Orcs. During the fight you lost ", ipoints_lost, " points."
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
                    put "You were attacked by a horde of Goblins." ..
                    put " You are trapped. Your only option is to defeat them."
                    ix := ix - 1
                    isteps := isteps + 1
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
                    put "There is a Ringwraith on your way. You have a few options, which can save you from the Nazgul."
                    loop
                        put "a) Hide - put the One Ring on. "
                        put "b) Attack - attack the Ringwraith."
                        put "c) Give - give the Ring to the Nazgul."
                        get ianswer4
                        if ianswer4 = "hide" then
                            ix := ix - 1
                            isteps := isteps + 1
                            randint (ipoints_lost, 10, 30)
                            ilife_scale := ilife_scale - ipoints_lost
                            if ipoints_lost > 15 and ilife_scale > 0 then
                                put "Even with the Ring on Nazgul was able to see you. You were able to win the round. Though, you sustained heavy damage. You lost " ..
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
                            ix := ix - 1
                            isteps := isteps + 1
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
                            put "You lost. Middle-earth will get thrown into an Age OF Darkness."
                            isteps := isteps + 1
                            imission_lost := imission_lost + 1
                            %implement end of the game when ilife_scale is zero or less
                        end if
                        if ianswer4 not= "hide" and ianswer4 not= "attack" and ianswer4 not= "give" then
                            put "Invalid command. Try again."
                        end if
                        exit when ianswer4 = "hide" or ianswer4 = "attack" or ianswer4 = "give"
                        exit when imission_lost = 1
                    end loop
                end if
            end if
        end if
    end if

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if ianswer = "east" then
        if ix = 10 then
            put istatement
        else
            if ix = 3 and iy < 4 then
                put "You can't go there. You're standing on the edge of the cliff. You have to get down from it to continue your jorney."
                if iobjects = 1 then
                    put "Since you have a rope you can try to get down. To activate the rope type in (use)."
                    get icommand
                    if icommand = icommand_correct then
                        ix := ix + 1
                        isteps := isteps + 1
                        put "You got down."
                    end if
                end if
            else
                ix := ix + 1
                isteps := isteps + 1

                randint (irope, 1, 4)
                if iobjects = 1 then
                    irope := 0
                end if
                if irope = inum1 then
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
            end if
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
                            ix := ix + 0
                        end if
                        if ianswer3 = "attack" then
                            ix := ix + 1
                            isteps := isteps + 1
                            randint (ipoints_lost, 1, 10)
                            ilife_scale := ilife_scale - ipoints_lost
                            if ilife_scale > 0 then
                                put "You sucessfully defeated all of the Orcs. During the fight you lost ", ipoints_lost, " points."
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
                    put "You were attacked by a horde of Goblins." ..
                    put " You are trapped. Your only option is to defeat them."
                    ix := ix + 1
                    isteps := isteps + 1
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
                    put "There is a Ringwraith on your way. You have a few options, which can save you from the Nazgul."
                    loop
                        put "a) Hide - put the One Ring on. "
                        put "b) Attack - attack the Ringwraith."
                        put "c) Give - give the Ring to the Nazgul."
                        get ianswer4
                        if ianswer4 = "hide" then
                            ix := ix + 1
                            isteps := isteps + 1
                            randint (ipoints_lost, 10, 30)
                            ilife_scale := ilife_scale - ipoints_lost
                            if ipoints_lost > 15 and ilife_scale > 0 then
                                put "Even with the Ring on Nazgul was able to see you. You were able to win the round. Though, you sustained heavy damage. You lost " ..
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
                            ix := ix + 1
                            isteps := isteps + 1
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
                            put "You lost. Middle-earth will get thrown into an Age OF Darkness."
                            isteps := isteps + 1
                            imission_lost := imission_lost + 1
                            %implement end of the game when ilife_scale is zero or less
                        end if
                        if ianswer4 not= "hide" and ianswer4 not= "attack" and ianswer4 not= "give" then
                            put "Invalid command. Try again."
                        end if
                        exit when ianswer4 = "hide" or ianswer4 = "attack" or ianswer4 = "give"
                        exit when imission_lost = 1
                    end loop
                end if
            end if
        end if
    end if

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    exit when ianswer = isentinel
    exit when imission_lost = 1
end loop
put ilife_scale
put "# of steps ", isteps
put "x-value is ", ix
put "y-value is ", iy
