

%Game board (10 by 10)
var isentinel : string := "stop"
var ianswer : string
var isteps : int := 0
%var isouth, inorth, iwest, ieast : int
var ix, iy : int := 0
loop
    put "Where would you like to go?"
    get ianswer
    isteps := isteps + 1
    if ianswer = "south" then
	if ix <= 0 then
	    put "You can't go that way."
	else
	    ix := ix - 1
	end if
    end if
    if ianswer = "north" then
	if ix >= 10 then
	    put "You can't go that way."
	else
	    ix := ix + 1
	end if
    end if
    if ianswer = "west" then
	if iy <= 0 then
	    put "You can't go that way."
	else
	    iy := iy - 1
	end if
    end if
    if ianswer = "east" then
	if iy >= 10 then
	    put "You can't go that way"
	else
	    iy := iy + 1
	end if
    end if
    exit when ianswer = isentinel
end loop
put "# of steps ", isteps - 1
put "x-value is ", ix
put "y-value is ", iy

