#=======================================================================
#
#   Dump-Updates.ps1  -  Display Updates from WindowsUpdate.Log
#
#   This script displays the updates in the given log file. If the log
#   file can't be accessed then the script retries for up to 60 seconds
#   before failing.
#
#   This version of the script uses a try/catch block to handle the errors.
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


# Load the contents of the file, retrying for up to 60 seconds:
# ------------------------------------------------------------
    for( $Seconds=60; $Seconds -gt 0; $Seconds-- )
    {
        try
        {
            $Contents = Get-Content $InputFileName -ErrorAction Stop
            break
        }
        catch
        {
            write-host -nonewline "`rWaiting $Seconds more seconds for file to become available  "
            Start-Sleep 1
        }
    }
    write-host -nonewline ("`r" + (" " * 60) + "`r")  # erase the "waiting..." message
    
# Error if we could not load the file:
# -----------------------------------
    if ( $Contents -eq $null )
    {
        write-host -foregroundcolor yellow "`rUnable to load file                                     "
        exit 1
    }
    write-host

    
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