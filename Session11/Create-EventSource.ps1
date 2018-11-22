#------------------------------------------------------------------------------
#
#       Create-EventSource  -  Set up an Event Log "Source" 
#
#   Writing to the Event Log requires a "source" name to be set up ahead
#   of time.   The source name helps to identify WHAT wrote the message and
#   is typically the name of a program or script.
#
#   This script creates a source of the name given as the command argument.
#
#   Note that administrative privilege is needed to run the script.
#
#------------------------------------------------------------------------------

# Verify that a source was given:
# -------------------------------
	if ( $args.count -ne 1 )
	{
		write-host "`nThis script requires one event log source name as a command argument`n"
		exit 1
	}
	$Source = $args[0]

# See if the source already exists.:
# --------------------------------
	$SourceExists = $false
	try
	{
		$SourceExists = [System.Diagnostics.EventLog]::SourceExists( $Source )
	}
	catch
	{
		write-host "`nUnable to access Event Log Source"
		write-host "This is probably because you don't have administrative privileges`n"
		exit 1
	}
    if( $SourceExists )
    {
		write-host "`nEvent log source '$Source' already exists`n"
		exit 0
	}

# Otherwise create the source.   This will fail if the user doesn't hold admin privileges:
# ---------------------------------------------------------------------------------------
	try
	{
		[System.Diagnostics.EventLog]::CreateEventSource( $Source, "Application" )
		write-host "`nEvent log source '$Source' has been created`n"
		exit 0
    }
	catch
	{
		write-host "`nUnable to create event log source '$Source'"
		write-host "This is probably because you do not have administrative privileges`n"
		exit 1
	}
