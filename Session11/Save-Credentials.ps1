#==============================================================================
#
#  Save-Credentials.ps1
#
#    Example of functions which can save the username and password for a set of
#    logon credentials in an encrypted format in a text file, and then recover
#    the credentials.
#
#    CAVEATS:
#    1) The encryption and decryption algorithms use the local computer's GUID.
#       This means you have to restore the credentials on the same computer you
#       saved them on.
#    
#    2) Although the password is not visible as plaintext, there's nothing to
#       stop someone from using a script just like this one to figure out what
#       the password is.  So the password is only as secure as the file it's
#       stored in - you should set the security attributes of this file so that
#       it can't be accessed by anyone who's not supposed to know the password.
#
#==============================================================================


#==============================================================================
#
#   Save-Credentials  -  Saves passed credentials in a file
#
#	  The username is stored as the first line of the file, the encrypted
#     password is stored as the second line.
#
#==============================================================================
function Save-Credentials
{
	param ( [System.Management.Automation.PSCredential] $Cred,  [string]$Filename )
	
	$Cred.Username > $Filename
	$Cred.Password | ConvertFrom-SecureString >> $Filename
}


#==============================================================================
#
#   Restore-Credentials  -  Returns the credentials from a file
#
#==============================================================================
function Restore-Credentials
{
	param ( [string]$Filename )
	
	$FileLines = Get-Content $Filename
	$Username  = $FileLines[0]
	$Password = ConvertTo-SecureString $FileLines[1]
	
	return new-object System.Management.Automation.PSCredential $Username,$Password
}


#==============================================================================
#
#   Main program - Script execution starts here
#
#	   We test the save and restore functions by saving a set of credentials
#      to a file and then restoring them and displaying their values.
#
#==============================================================================

# Get credentials and store them:
# ------------------------------
	$Creds = Get-Credential
	Save-Credentials $Creds "Creds.dat"
	
# Restore the credentials:
# -----------------------
	$RestoredCreds = Restore-Credentials "Creds.dat"
	
# Display the contents of the credentials:
# ---------------------------------------
	$PlainPW = [Runtime.InteropServices.Marshal]::PtrToStringAuto( 
			  [Runtime.InteropServices.Marshal]::SecureStringToBSTR($RestoredCreds.Password) )

	write-host ""
	write-host "Restored username is: '$($Creds.Username)'"
	write-host "Restored password is: '$PlainPW'"
	write-host ""
	