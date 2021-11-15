<#
.SYNOPSIS
  Automated MSFT Teams post.
 
.DESCRIPTION
  Automated MSFT Team's message post. Will post to EOS' General channel by default. Can be overriden with a different URI. 
  
.PARAMETERS
  $message, message to post in Teams. 
  $uri, webhook URI.
 
.INPUTS
  $message
  $uri
 
.OUTPUTS
  No outputs.
 
.NOTES
  Version:        1.0
  Author:         Joey Stitt
  Creation Date:  11/4/19
  Last Updated:   
  Purpose/Change:  
  
.EXAMPLE
  .\post-Teams.ps1 -message "Completed some automated task!"
#>
param(
  [string] $message,
  [string] $uri,
   $timeoutsec = 600
)
try{
  #Force .NET Framework to utilize TLS 1.2
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

  $body = ConvertTo-JSON @{
    text = "'" + "$message" + "'"
  }
  Invoke-RestMethod -uri $uri -Method Post -body $body -ContentType 'application/json' -TimeoutSec $timeoutsec
}
catch{
  throw $_
}