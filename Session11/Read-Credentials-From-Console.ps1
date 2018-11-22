#============================================================
#
#  Read-Credentials-From-Console.ps1
#
#    Example showing how to read a username and password
#	 from the console instead of from a pop-up dialog box
#	 (as happens with the Get-Credential cmdlet)
#
#============================================================

# Read the username and password:
# ------------------------------
	$Username = Read-Host -Prompt "Username"
	$Password = Read-Host -Prompt "Password" -AsSecureString
	
	$Cred = new-object System.Management.Automation.PSCredential $Username,$Password

# The $Cred object can now be used to
# access secure web sites or servers...
