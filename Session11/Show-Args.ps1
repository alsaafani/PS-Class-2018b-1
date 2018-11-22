#--------------------------------------------------------------
#
#   Show-Args.ps1  -  Display the script's arguments
#
#--------------------------------------------------------------


    write-host  "`nThis script has been passed $( $args.count ) arguments`n"

    $argno = 1

    foreach( $arg in $args )
    {
        write-host "Argument $argno is '$arg'"
        $argno++
    }
