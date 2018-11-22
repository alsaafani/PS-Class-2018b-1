#-----------------------------------------------------------------------
#
#  OUPath.ps1 - Convert a hierarchical path specification such as
#               "IT.ITServers" into an X500 path specific to this
#               AD such as "OU=ITServers, OU=IT, OU=$OURoot, DC=ADTest, DC=com"
#
#-----------------------------------------------------------------------

function OUPath
{
    param ( [string]$Path )
    
# Set the result to the base path for all our OUs:
# -----------------------------------------------

    $Result = 'OU=$OURoot, DC=ADTest, DC=com'
    
    
# If no path was given then that's all there is:
# ---------------------------------------------

    if ( $Path.Trim() -eq "" ) { return $Result }


# Break the string up into it's component pieces:
# ----------------------------------------------

    $Pieces = $Path.Split(".")
    
    
# Go through each piece and add it to the front of the result:
# -----------------------------------------------------------

    foreach( $Piece in $Pieces )
    {
        $Result = "OU=$Piece, $Result"
    }
    
   
# Return the result:
# -----------------

    return $Result
}
