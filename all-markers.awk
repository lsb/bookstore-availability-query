BEGIN { FS="\t" ; ORS=""; print "http://maps.googleapis.com/maps/api/staticmap?maptype=roadmap&sensor=false&size=640x640" }
$5~/is NOT/ {$5="red"}
$5~/is IN/ {$5="green"}
$5~/bad phone/ {$5="white"}
$5~/does not/ {$5="gray"}
$5~/./ {print "&markers=color:" $5 "%7C" $3 "," $4 }
END { print "\n" }
