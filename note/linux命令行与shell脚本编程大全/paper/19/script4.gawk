BEGIN {
print "The latest list of users and shells"
printf "%-20s \t %-20s\n" ,"UserID" , "Shell"
print "----------\t -----------"
FS=":"
}

{
printf "%-20s \t %-20s\n", $1,  $7
}

END {
print "This concludes the listing"
}

