﻿function Test-vRAContentPackage {
<#
    .SYNOPSIS
    Validates a vRA Content Package    

    .DESCRIPTION
    Validates a vRA Content Package  

    .PARAMETER File
    The content package file

    .INPUTS
    System.String

    .OUTPUTS
    System.Management.Automation.PSObject

    .EXAMPLE
    Test-vRAContentPackage -File C:\Packages\ContentPackage100.zip

    .EXAMPLE
    Get-ChildItem -Path C:\Packages\ContentPackage100.zip| Test-vRAContentPackage

#>
[CmdletBinding(SupportsShouldProcess,ConfirmImpact="Low")][OutputType('System.Management.Automation.PSObject')]

    Param (

    [parameter(Mandatory=$true,ValueFromPipeline=$true,ValueFromPipelinebyPropertyName=$true)]
    [ValidateNotNullOrEmpty()]
    [String[]]$File

    )

    begin {

        Write-Warning -Message "This command is deprecated and will be removed in a future release. Please use Test-vRAPackage instead."

        # --- Set Set Line Feed
        $LF = "`r`n"
   
    }

    process {

        foreach ($FilePath in $File){

            try {

                # --- Resolve the file path
                $FileInfo = [System.IO.FileInfo](Resolve-Path $FilePath).Path

                # --- Create the multi-part form
                $Boundary = [guid]::NewGuid().ToString()
                $FileBin = [System.IO.File]::ReadAllBytes($FileInfo.FullName)
                $Encoding = [System.Text.Encoding]::GetEncoding("iso-8859-1")
                $EncodedFile = $Encoding.GetString($FileBin)

                $Form = (
                    "--$($Boundary)",
                    "Content-Disposition: form-data; name=`"file`"; filename=`"$($FileInfo.Name)`"",
                    "Content-Type:application/octet-stream$($LF)",
                    $EncodedFile,
                    "--$($Boundary)--$($LF)"
                ) -join $LF

                $URI = "/content-management-service/api/packages/validate"

                # --- Set custom headers for the request
                $Headers = @{
                
                    "Authorization" = "Bearer $($Global:vRAConnection.Token)";
                    "Accept" = "Application/json"
                    "Accept-Encoding" = "gzip,deflate,sdch";
                    "Content-Type" = "multipart/form-data; boundary=$($Boundary)"
                }

                if ($PSCmdlet.ShouldProcess($FileInfo.FullName)){

                    Invoke-vRARestMethod -Method POST -Uri $URI -Body $Form -Headers $Headers -Verbose:$VerbosePreference

                }

            }
            catch [Exception]{

                throw

            }
        }
    }

    end {

    }
}