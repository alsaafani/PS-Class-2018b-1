#=======================================================================
#
#   Dump-Updates.ps1  -  Display Updates from WindowsUpdate.Log
#
#   This script displays the updates in the given log file
#
#========================================================================


#========================================================================
#
#    Main Program - Execution starts here
#
#========================================================================

# Check for valid argument:
# ------------------------
    if ( $args.count -lt 1 )
    {
        write-host -foregroundcolor red "You must give a file name!"
        exit 1
    }
	$InputFileName = $args[0]
	
    if ( -not (test-path $InputFileName -pathtype leaf) )
    {
        write-host -foregroundcolor red $InputFileName "does not exist"
		exit 1
    }





# Load the contents of the file:
# -----------------------------

    $Contents = Get-Content $InputFileName 



# Select the lines that describe installations:
# --------------------------------------------
	$Lines = $Contents -match "Agent.+START.+installing"
	
# Show the info for each line:
# ---------------------------
	$Lines | foreach-object `
	{
		if ( $_ -match '(?<Date>\S+)\s(?<Time>\d\d:\d\d).+\[.+= ?(?<CallerID>.+)\]' )
		{
			$Date = $Matches["Date"]
			$Time = $Matches["Time"]
			$CallerID = $Matches["CallerID"]
			
			write-host "$Date $Time  $CallerID"
		}
	}
	  
    exit 0