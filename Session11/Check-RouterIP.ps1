#==============================================================================
#
#   Check-RouterIP - Confirm that the Router IP address hasn't changed
#
#     This script downloads the status page from a router, parses it to
#     extract the IP address assigned by the ISP, and checks to see if its
#     a given value.
#
#==============================================================================


# Create a web client object with the required credentials to access the router:
# -----------------------------------------------------------------------------

    $WebClient = new-object System.Net.WebClient
    $WebClient.Credentials = new-object System.Net.NetworkCredential username,password

# change "username,password" in the above line to that required for your router,
# or use the following instead if you want to enter the username/password at runtime
# instead of hard-coding it into the script:

#    $WebClient.Credentials = Get-Credential



# Get the status page from the router and extract the IP address from it.
# The status page URL and the -match RegEx pattern may need to be changed
# for your particular router:
# -----------------------------------------------------------------------
    $StatusPage = $WebClient.DownloadString( "http://192.168.1.1/Status_Router.asp" )
    if ( -not ($StatusPage -match 'var wan_ip += +"(.+)"' ) )
	{
	    write-host -foregroundcolor red "Unable to obtain IP address from router"
		exit 1
	}
    $IPAddress = $matches[1]

    
# Complain if the IP address is different:
# ---------------------------------------

	$OldIP = "10.10.10.10"

    if ( $IPAddress -ne $OldIP )
    {
        write-host -foregroundcolor red "`nIP Address has changed from $OldIP to $IPAddress`n"
        exit 1
    }
    else
    {
        write-host -foregroundcolor cyan "`nIP Address is still $IPAddress`n"
    }