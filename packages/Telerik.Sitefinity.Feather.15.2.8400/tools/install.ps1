param($installPath, $toolsPath, $package, $project)

  # Need to load MSBuild assembly if it's not loaded yet.
  Add-Type -AssemblyName 'Microsoft.Build, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a'

  # Grab the loaded MSBuild project for the project
  $msbuild = [Microsoft.Build.Evaluation.ProjectCollection]::GlobalProjectCollection.GetLoadedProjects($project.FullName) | Select-Object -First 1
  $msbuild.Xml.Imports | 
  Where-Object { $_.Project -eq 'Build\RazorGenerator.MsBuild\build\RazorGenerator.MsBuild.targets' -or $_.Project -eq 'Build\FeatherPrecompilation.targets'} | 
  ForEach-Object { $msbuild.Xml.RemoveChild($_) }

  # Add project references
  Write-Host "Adding project references..."
  $references = "System.Web.Extensions", "System.Web.ApplicationServices"
  try
  {
    foreach ($reference in $references)
    {
      # Check if reference doesn't already exist
      $existingReference = $msbuild.Items | Where-Object { $_.ItemType -eq "Reference" -and $_.EvaluatedInclude.Split(",")[0] -eq $reference } | Select-Object -First 1
      if (!$existingReference)
      {
        Write-Host ("Adding '{0}' to {1}" -f $reference, $project.Name)

        $msbuild.AddItem("Reference", $reference)

        Write-Host ("Successfully added '{0}' to {1}" -f $reference, $project.Name)
      }
      else 
      {
        Write-Host ("{0} already has a reference to '{1}'" -f $project.Name, $reference)
      }
    }
  }
  catch
  {
    Write-Host ("Could not add references {0} to {1}. Please add these references manually or contact Sitefinity support." -f [system.String]::Join(", ", $references), $project.Name)
    Write-Error $_.Exception.Message
  }

  # Remove Recaptha views from Bootstrap package
  ForEach-Object { try { $project.ProjectItems.Item('ResourcePackages').ProjectItems.Item('Bootstrap').ProjectItems.Item('MVC').ProjectItems.Item('Views').ProjectItems.Item('Recaptcha') } catch { $null } } |
  Where-Object {$_ -ne $null} | 
  ForEach-Object { $_.Remove() }
  
  # Save changes to project
  $project.Save()

  $fileInfo = new-object -typename System.IO.FileInfo -ArgumentList $project.FullName
  $projectDirectory = $fileInfo.DirectoryName

  # Make sure all Resource Packages have RazorGenerator directives
  $generatorDirectivesPath = "$projectDirectory\ResourcePackages\Bootstrap\razorgenerator.directives"
  if (Test-Path $generatorDirectivesPath) 
  {
    Get-ChildItem "$projectDirectory\ResourcePackages" -Directory -Exclude "Bootstrap" |
    Where-Object { $_.GetFiles("razorgenerator.directives").Count -eq 0 } |
    ForEach-Object { Copy-Item $generatorDirectivesPath $_.FullName }
  }

  # Prompt to remove Recaptcha template if exists since it isn't distributed with Feather anymore
  $recaptchaTemplatesPath = "$projectDirectory\ResourcePackages\Bootstrap\MVC\Views\Recaptcha"
  if (Test-Path $recaptchaTemplatesPath) 
  {
    Remove-Item $recaptchaTemplatesPath -Recurse -Confirm
  }

  # Append attributes to the AssemblyInfo 
  Write-Host "Appending ControllerContainerAttribute and ResourcePackageAttribute to the AssemblyInfo..."
  $assemblyInfoPath = Join-Path $projectDirectory "Properties\AssemblyInfo.cs"
  if (Test-Path $assemblyInfoPath)
  {
    # Append ControllerContainerAttribute to the AssemblyInfo
	  $attributeRegex = "\[\s*assembly\s*\:\s*(?:(?:(?:(?:(?:(?:(?:Telerik\.)?Sitefinity\.)?Frontend\.)?Mvc\.)?Infrastructure\.)?Controllers\.)?Attributes\.)?ControllerContainer(?:Attribute)?\s*\]"
    $controllerContainerAttributeExists = (Get-Content $assemblyInfoPath | Where-Object { $_ -match $attributeRegex } | Group-Object).Count -eq 1
    if (!$controllerContainerAttributeExists)
    {
      Add-Content $assemblyInfoPath "`r`n[assembly: Telerik.Sitefinity.Frontend.Mvc.Infrastructure.Controllers.Attributes.ControllerContainer]"
      Write-Host "Finished appending ControllerContainerAttribute to the AssemblyInfo."
    }
    else
    {
      Write-Host "ControllerContainerAttribute is already in the AssemblyInfo. Nothing is appended."
    }

    # Append ResourcePackageAttribute to the AssemblyInfo
    $attributeRegex = "\[\s*assembly\s*\:\s*(?:(?:(?:(?:(?:(?:(?:Telerik\.)?Sitefinity\.)?Frontend\.)?Mvc\.)?Infrastructure\.)?Controllers\.)?Attributes\.)?ResourcePackage(?:Attribute)?\s*\]"
    $resourcePackageAttributeExists = (Get-Content $assemblyInfoPath | Where-Object { $_ -match $attributeRegex } | Group-Object).Count -eq 1
    if (!$resourcePackageAttributeExists)
    {
      Add-Content $assemblyInfoPath "`r`n[assembly: Telerik.Sitefinity.Frontend.Mvc.Infrastructure.Controllers.Attributes.ResourcePackage]"
      Write-Host "Finished appending ResourcePackageAttribute to the AssemblyInfo."
    }
    else
    {
      Write-Host "ResourcePackageAttribute is already in the AssemblyInfo. Nothing is appended."
    }
  }
  else
  {
    Write-Host "AssemblyInfo not found."
  }

  . "$PSScriptRoot\UpdateDefaultTemplates.ps1" -resourcePackagesDirectory "$projectDirectory\ResourcePackages"
# SIG # Begin signature block
# MIIvyQYJKoZIhvcNAQcCoIIvujCCL7YCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCwjN5nAtjJfqsB
# xvFrJndcAgqwoKjp3/o0bplLfPV7UaCCFA0wggVyMIIDWqADAgECAhB2U/6sdUZI
# k/Xl10pIOk74MA0GCSqGSIb3DQEBDAUAMFMxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
# ExBHbG9iYWxTaWduIG52LXNhMSkwJwYDVQQDEyBHbG9iYWxTaWduIENvZGUgU2ln
# bmluZyBSb290IFI0NTAeFw0yMDAzMTgwMDAwMDBaFw00NTAzMTgwMDAwMDBaMFMx
# CzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSkwJwYDVQQD
# EyBHbG9iYWxTaWduIENvZGUgU2lnbmluZyBSb290IFI0NTCCAiIwDQYJKoZIhvcN
# AQEBBQADggIPADCCAgoCggIBALYtxTDdeuirkD0DcrA6S5kWYbLl/6VnHTcc5X7s
# k4OqhPWjQ5uYRYq4Y1ddmwCIBCXp+GiSS4LYS8lKA/Oof2qPimEnvaFE0P31PyLC
# o0+RjbMFsiiCkV37WYgFC5cGwpj4LKczJO5QOkHM8KCwex1N0qhYOJbp3/kbkbuL
# ECzSx0Mdogl0oYCve+YzCgxZa4689Ktal3t/rlX7hPCA/oRM1+K6vcR1oW+9YRB0
# RLKYB+J0q/9o3GwmPukf5eAEh60w0wyNA3xVuBZwXCR4ICXrZ2eIq7pONJhrcBHe
# OMrUvqHAnOHfHgIB2DvhZ0OEts/8dLcvhKO/ugk3PWdssUVcGWGrQYP1rB3rdw1G
# R3POv72Vle2dK4gQ/vpY6KdX4bPPqFrpByWbEsSegHI9k9yMlN87ROYmgPzSwwPw
# jAzSRdYu54+YnuYE7kJuZ35CFnFi5wT5YMZkobacgSFOK8ZtaJSGxpl0c2cxepHy
# 1Ix5bnymu35Gb03FhRIrz5oiRAiohTfOB2FXBhcSJMDEMXOhmDVXR34QOkXZLaRR
# kJipoAc3xGUaqhxrFnf3p5fsPxkwmW8x++pAsufSxPrJ0PBQdnRZ+o1tFzK++Ol+
# A/Tnh3Wa1EqRLIUDEwIrQoDyiWo2z8hMoM6e+MuNrRan097VmxinxpI68YJj8S4O
# JGTfAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB0G
# A1UdDgQWBBQfAL9GgAr8eDm3pbRD2VZQu86WOzANBgkqhkiG9w0BAQwFAAOCAgEA
# Xiu6dJc0RF92SChAhJPuAW7pobPWgCXme+S8CZE9D/x2rdfUMCC7j2DQkdYc8pzv
# eBorlDICwSSWUlIC0PPR/PKbOW6Z4R+OQ0F9mh5byV2ahPwm5ofzdHImraQb2T07
# alKgPAkeLx57szO0Rcf3rLGvk2Ctdq64shV464Nq6//bRqsk5e4C+pAfWcAvXda3
# XaRcELdyU/hBTsz6eBolSsr+hWJDYcO0N6qB0vTWOg+9jVl+MEfeK2vnIVAzX9Rn
# m9S4Z588J5kD/4VDjnMSyiDN6GHVsWbcF9Y5bQ/bzyM3oYKJThxrP9agzaoHnT5C
# JqrXDO76R78aUn7RdYHTyYpiF21PiKAhoCY+r23ZYjAf6Zgorm6N1Y5McmaTgI0q
# 41XHYGeQQlZcIlEPs9xOOe5N3dkdeBBUO27Ql28DtR6yI3PGErKaZND8lYUkqP/f
# obDckUCu3wkzq7ndkrfxzJF0O2nrZ5cbkL/nx6BvcbtXv7ePWu16QGoWzYCELS/h
# AtQklEOzFfwMKxv9cW/8y7x1Fzpeg9LJsy8b1ZyNf1T+fn7kVqOHp53hWVKUQY9t
# W76GlZr/GnbdQNJRSnC0HzNjI3c/7CceWeQIh+00gkoPP/6gHcH1Z3NFhnj0qinp
# J4fGGdvGExTDOUmHTaCX4GUT9Z13Vunas1jHOvLAzYIwggboMIIE0KADAgECAhB3
# vQ4Ft1kLth1HYVMeP3XtMA0GCSqGSIb3DQEBCwUAMFMxCzAJBgNVBAYTAkJFMRkw
# FwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSkwJwYDVQQDEyBHbG9iYWxTaWduIENv
# ZGUgU2lnbmluZyBSb290IFI0NTAeFw0yMDA3MjgwMDAwMDBaFw0zMDA3MjgwMDAw
# MDBaMFwxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTIw
# MAYDVQQDEylHbG9iYWxTaWduIEdDQyBSNDUgRVYgQ29kZVNpZ25pbmcgQ0EgMjAy
# MDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMsg75ceuQEyQ6BbqYoj
# /SBerjgSi8os1P9B2BpV1BlTt/2jF+d6OVzA984Ro/ml7QH6tbqT76+T3PjisxlM
# g7BKRFAEeIQQaqTWlpCOgfh8qy+1o1cz0lh7lA5tD6WRJiqzg09ysYp7ZJLQ8LRV
# X5YLEeWatSyyEc8lG31RK5gfSaNf+BOeNbgDAtqkEy+FSu/EL3AOwdTMMxLsvUCV
# 0xHK5s2zBZzIU+tS13hMUQGSgt4T8weOdLqEgJ/SpBUO6K/r94n233Hw0b6nskEz
# IHXMsdXtHQcZxOsmd/KrbReTSam35sOQnMa47MzJe5pexcUkk2NvfhCLYc+YVaMk
# oog28vmfvpMusgafJsAMAVYS4bKKnw4e3JiLLs/a4ok0ph8moKiueG3soYgVPMLq
# 7rfYrWGlr3A2onmO3A1zwPHkLKuU7FgGOTZI1jta6CLOdA6vLPEV2tG0leis1Ult
# 5a/dm2tjIF2OfjuyQ9hiOpTlzbSYszcZJBJyc6sEsAnchebUIgTvQCodLm3HadNu
# twFsDeCXpxbmJouI9wNEhl9iZ0y1pzeoVdwDNoxuz202JvEOj7A9ccDhMqeC5LYy
# AjIwfLWTyCH9PIjmaWP47nXJi8Kr77o6/elev7YR8b7wPcoyPm593g9+m5XEEofn
# GrhO7izB36Fl6CSDySrC/blTAgMBAAGjggGtMIIBqTAOBgNVHQ8BAf8EBAMCAYYw
# EwYDVR0lBAwwCgYIKwYBBQUHAwMwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4E
# FgQUJZ3Q/FkJhmPF7POxEztXHAOSNhEwHwYDVR0jBBgwFoAUHwC/RoAK/Hg5t6W0
# Q9lWULvOljswgZMGCCsGAQUFBwEBBIGGMIGDMDkGCCsGAQUFBzABhi1odHRwOi8v
# b2NzcC5nbG9iYWxzaWduLmNvbS9jb2Rlc2lnbmluZ3Jvb3RyNDUwRgYIKwYBBQUH
# MAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2NvZGVzaWdu
# aW5ncm9vdHI0NS5jcnQwQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9i
# YWxzaWduLmNvbS9jb2Rlc2lnbmluZ3Jvb3RyNDUuY3JsMFUGA1UdIAROMEwwQQYJ
# KwYBBAGgMgECMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24u
# Y29tL3JlcG9zaXRvcnkvMAcGBWeBDAEDMA0GCSqGSIb3DQEBCwUAA4ICAQAldaAJ
# yTm6t6E5iS8Yn6vW6x1L6JR8DQdomxyd73G2F2prAk+zP4ZFh8xlm0zjWAYCImbV
# YQLFY4/UovG2XiULd5bpzXFAM4gp7O7zom28TbU+BkvJczPKCBQtPUzosLp1pnQt
# pFg6bBNJ+KUVChSWhbFqaDQlQq+WVvQQ+iR98StywRbha+vmqZjHPlr00Bid/XSX
# hndGKj0jfShziq7vKxuav2xTpxSePIdxwF6OyPvTKpIz6ldNXgdeysEYrIEtGiH6
# bs+XYXvfcXo6ymP31TBENzL+u0OF3Lr8psozGSt3bdvLBfB+X3Uuora/Nao2Y8nO
# ZNm9/Lws80lWAMgSK8YnuzevV+/Ezx4pxPTiLc4qYc9X7fUKQOL1GNYe6ZAvytOH
# X5OKSBoRHeU3hZ8uZmKaXoFOlaxVV0PcU4slfjxhD4oLuvU/pteO9wRWXiG7n9dq
# cYC/lt5yA9jYIivzJxZPOOhRQAyuku++PX33gMZMNleElaeEFUgwDlInCI2Oor0i
# xxnJpsoOqHo222q6YV8RJJWk4o5o7hmpSZle0LQ0vdb5QMcQlzFSOTUpEYck08T7
# qWPLd0jV+mL8JOAEek7Q5G7ezp44UCb0IXFl1wkl1MkHAHq4x/N36MXU4lXQ0x72
# f1LiSY25EXIMiEQmM2YBRN/kMw4h3mKJSAfa9TCCB6cwggWPoAMCAQICDHJsAG/o
# HyfTg/C2WDANBgkqhkiG9w0BAQsFADBcMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
# R2xvYmFsU2lnbiBudi1zYTEyMDAGA1UEAxMpR2xvYmFsU2lnbiBHQ0MgUjQ1IEVW
# IENvZGVTaWduaW5nIENBIDIwMjAwHhcNMjQxMDExMTkxNjI0WhcNMjUxMTI3MTQ0
# NTA0WjCCAQsxHTAbBgNVBA8MFFByaXZhdGUgT3JnYW5pemF0aW9uMRAwDgYDVQQF
# Ewc1NzQzNTgyMRMwEQYLKwYBBAGCNzwCAQMTAlVTMRkwFwYLKwYBBAGCNzwCAQIT
# CERlbGF3YXJlMQswCQYDVQQGEwJVUzEWMBQGA1UECBMNTWFzc2FjaHVzZXR0czET
# MBEGA1UEBxMKQnVybGluZ3RvbjEeMBwGA1UECRMVMTUgV2F5c2lkZSBSZCBTdGUg
# NDAwMSYwJAYDVQQKEx1QUk9HUkVTUyBTT0ZUV0FSRSBDT1JQT1JBVElPTjEmMCQG
# A1UEAxMdUFJPR1JFU1MgU09GVFdBUkUgQ09SUE9SQVRJT04wggIiMA0GCSqGSIb3
# DQEBAQUAA4ICDwAwggIKAoICAQCRlypE6JLwyb1KZBHXlaNNkfr/2K5FnPVyJ1dZ
# 2MzV1dPnP/w150+FYS+CexgEohk15CwL4V+KcXECKdCvcbbLKBSvCnL9Ck1C47jA
# CKsKQZAlD59XeFmdC47gme6g7QrqA//iY9+F56GBhgD96Mr7bQxUHtCbxVKkcBsc
# 3DQyhe9XK1Nf7Q7Xgn3Pjo9nUhrkTdYiQ2XoDK9qZkfWm040nI3lGkkGqpJ59EgL
# xVUsYRRlPIRbJ0VVGONJaL9j7npAdtq4/XvPX1G8pSTFFTHWacAjH0NEIWVAGEtA
# 8eZlfpTVgEoV5CEnt4HT+4NAIsqGfjMAGt2W4iErpk+IIRvs9PzerIoPiZviUQdn
# kMNUhVElt8S9kfJMpEB8v5tnakZsSj2zzR0Q0Q8ju9sLsfKSkKhMVpDS3aD3dwf5
# 5Fd0Od3lc7DHBjGqMgjD6HbpUsAIkxI7VeztAGIWaXfTtCCjiT/V7swaDsNZ39Ws
# c64Ziou3UTe3LTu5BwSN7fk59GCWLhUSjht6jizRtwR8pi+dfKTAnPkF2xXmR764
# 1ELzwOHV6fKwFjfhLX2+xWwFKnAiiEyGfDELeXbd5ERyY+XYPzQiQ/tqnXW683yx
# fvn9JcrbD+yGgm0PB+VYG0oxDXuBuYfAoGBHmZXXyM/3K65QSZNC0aSE4shVufQn
# 164L6wIDAQABo4IBtjCCAbIwDgYDVR0PAQH/BAQDAgeAMIGfBggrBgEFBQcBAQSB
# kjCBjzBMBggrBgEFBQcwAoZAaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9j
# YWNlcnQvZ3NnY2NyNDVldmNvZGVzaWduY2EyMDIwLmNydDA/BggrBgEFBQcwAYYz
# aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNDVldmNvZGVzaWduY2Ey
# MDIwMFUGA1UdIAROMEwwQQYJKwYBBAGgMgECMDQwMgYIKwYBBQUHAgEWJmh0dHBz
# Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAcGBWeBDAEDMAkGA1Ud
# EwQCMAAwRwYDVR0fBEAwPjA8oDqgOIY2aHR0cDovL2NybC5nbG9iYWxzaWduLmNv
# bS9nc2djY3I0NWV2Y29kZXNpZ25jYTIwMjAuY3JsMBMGA1UdJQQMMAoGCCsGAQUF
# BwMDMB8GA1UdIwQYMBaAFCWd0PxZCYZjxezzsRM7VxwDkjYRMB0GA1UdDgQWBBR5
# VcHLeGc1Knox1V7EBUmbA6+0eDANBgkqhkiG9w0BAQsFAAOCAgEAFl60PaXiJzyG
# mDap034Aca4ivZWWLaAwGvd8qDBU0Unmb6i2eEIi1CzvyuByEYIfyNysEocglPVV
# HHL7JHZeNuctxV1Xc0HLmc9B+oWtaLu7HWe9gZjiFaplRLKUEABO+Q2Vu1OSA+6H
# +qPFVG187nImRh7KO4lh0rxn0Ntfo5IEWG8/EsRCPcEtPlwg2mxXgK+gLRbxPQzH
# sDRh5IwwkVH/HIPn4ctuq/F4M7CjoHK8n465+73wO9+vIgi07m/A2PflyRvlBzy5
# 4y48C6NBMeNNXQ5PulxlqJV2Qzofa9ZWACZD2aYddK/pj7ddGGLfme5FeNbyGnx0
# Jg24l10LDh+/ellP6NtPb5xbbxZHCh+d+2cRjAEvXCMlm5CK2DJEAwCUDWFS/xoH
# Tmo3gdnPfbx60gzkRocmJFtEVtc0KUFwUruSImEknJqWzqcElX0tyXVlBsEimLWo
# YOVwUi2s/MEpeU2qG2ww+kElkTEIUQeutZZcHpE479im8P4lnq7nXXkBSorFwXIV
# fX9xv8XYydyypuSQiTSa8CPNQEq40MjHQ6C9xJJnY1+6hssNdFcwiK0ioS9zYPaO
# 4uynGYD8rP7TwG0+wTGCZ+Rs753kMy1Z2+lngESQKnXRaUqvu0svO9npasG3gx6V
# /+MHp+VpLjcP1VrGfARV9jOy70pN+WIxghsSMIIbDgIBATBsMFwxCzAJBgNVBAYT
# AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTIwMAYDVQQDEylHbG9iYWxT
# aWduIEdDQyBSNDUgRVYgQ29kZVNpZ25pbmcgQ0EgMjAyMAIMcmwAb+gfJ9OD8LZY
# MA0GCWCGSAFlAwQCAQUAoIHMMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwG
# CisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMC8GCSqGSIb3DQEJBDEiBCBqO3dV
# kLizrfJ/+ilIYMvxxiwmvNbAwMJccyyxkEtmTDBgBgorBgEEAYI3AgEMMVIwUKAw
# gC4AUAByAG8AZwByAGUAcwBzACAAUwBpAHQAZQBmAGkAbgBpAHQAeQAgAEMATQBT
# oRyAGmh0dHBzOi8vd3d3LnByb2dyZXNzLmNvbS8gMA0GCSqGSIb3DQEBAQUABIIC
# ACFjfCoZMgLJAPgiO7fBXlLFwwRJ2LLFzd+wiJb1vBkEyRDwUOLj33bKZTg0wh2U
# aalCRxvf3bKEc0eJrTS3UcryeUW60rhLpoMaNnjXYoMzFZe9EEUfbxGU26nLlPWa
# Cz+jjGmsmsZJ5o5zyCcxUundSHq8Yz00E8E4ehrxnauPfRK3hq4GQq09ou/tiDay
# koCH+He6yq+kvihvxqJoAMeygqam3Ek0pPdoEpwyb4+aEW+b1z4QBs43fWGnwd6N
# 9nlbluleL92RxsVHBvIhnxv4iROr2N1dkhC0ci3uX4InGaJraLvfeZmwlW+JQkxk
# tBuLb9k0iJGjfd/SHyq0tYjqa5fX/aESRMJ8ukptMALcPSj8aKSFX1zK9c7L0+6n
# Tc6WthxcC9hu8Xdhy6ErRmD9u9xOGA2gSCX4W3k9GvTJpmmwoI9Hy0KoA1qyDUo9
# OHsDuvMBQ/8Tr3kGs1gbYNz3ghM7zL3Esc8pDSu1bC6JMWXAU5/rAqjxFNHy+4Ty
# ndV5AuZ2yUjpTW8qtlA8oJ/t/61OSDfw0mycgB/Lryi0IhrDYJeakaqsWH3GkV1h
# qCZZUnRIhthUq5+H92NUgSwQAwMLtcku8lHEYHXmtSzwCT3z5SKP/1BAcalTiq+Q
# 7qTOFp5JWFVdnhARo5dClDlYn2sDTgmIvLt4N+JRXu0doYIXqDCCF6QGCisGAQQB
# gjcDAwExgheUMIIXkAYJKoZIhvcNAQcCoIIXgTCCF30CAQMxDzANBglghkgBZQME
# AgEFADCCAWkGCyqGSIb3DQEJEAEEoIIBWASCAVQwggFQAgEBBgorBgEEAYRZCgMB
# MDEwDQYJYIZIAWUDBAIBBQAEILkpiQ1zhvB5CU3xFSNRjiCHfNPkVnjus980CIw7
# Xo/EAgZnEPOdoTwYEzIwMjQxMTAxMDkzNDI1LjczNVowBIACAfSggeikgeUwgeIx
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xLTArBgNVBAsTJE1p
# Y3Jvc29mdCBJcmVsYW5kIE9wZXJhdGlvbnMgTGltaXRlZDEmMCQGA1UECxMdVGhh
# bGVzIFRTUyBFU046QzM5Mi05NjQxLTQ1NDAxNTAzBgNVBAMTLE1pY3Jvc29mdCBQ
# dWJsaWMgUlNBIFRpbWUgU3RhbXBpbmcgQXV0aG9yaXR5oIIPKDCCB4IwggVqoAMC
# AQICEzMAAAAF5c8P/2YuyYcAAAAAAAUwDQYJKoZIhvcNAQEMBQAwdzELMAkGA1UE
# BhMCVVMxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjFIMEYGA1UEAxM/
# TWljcm9zb2Z0IElkZW50aXR5IFZlcmlmaWNhdGlvbiBSb290IENlcnRpZmljYXRl
# IEF1dGhvcml0eSAyMDIwMB4XDTIwMTExOTIwMzIzMVoXDTM1MTExOTIwNDIzMVow
# YTELMAkGA1UEBhMCVVMxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEy
# MDAGA1UEAxMpTWljcm9zb2Z0IFB1YmxpYyBSU0EgVGltZXN0YW1waW5nIENBIDIw
# MjAwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCefOdSY/3gxZ8FfWO1
# BiKjHB7X55cz0RMFvWVGR3eRwV1wb3+yq0OXDEqhUhxqoNv6iYWKjkMcLhEFxvJA
# eNcLAyT+XdM5i2CgGPGcb95WJLiw7HzLiBKrxmDj1EQB/mG5eEiRBEp7dDGzxKCn
# TYocDOcRr9KxqHydajmEkzXHOeRGwU+7qt8Md5l4bVZrXAhK+WSk5CihNQsWbzT1
# nRliVDwunuLkX1hyIWXIArCfrKM3+RHh+Sq5RZ8aYyik2r8HxT+l2hmRllBvE2Wo
# k6IEaAJanHr24qoqFM9WLeBUSudz+qL51HwDYyIDPSQ3SeHtKog0ZubDk4hELQSx
# nfVYXdTGncaBnB60QrEuazvcob9n4yR65pUNBCF5qeA4QwYnilBkfnmeAjRN3LVu
# Lr0g0FXkqfYdUmj1fFFhH8k8YBozrEaXnsSL3kdTD01X+4LfIWOuFzTzuoslBrBI
# LfHNj8RfOxPgjuwNvE6YzauXi4orp4Sm6tF245DaFOSYbWFK5ZgG6cUY2/bUq3g3
# bQAqZt65KcaewEJ3ZyNEobv35Nf6xN6FrA6jF9447+NHvCjeWLCQZ3M8lgeCcnnh
# TFtyQX3XgCoc6IRXvFOcPVrr3D9RPHCMS6Ckg8wggTrtIVnY8yjbvGOUsAdZbeXU
# IQAWMs0d3cRDv09SvwVRd61evQIDAQABo4ICGzCCAhcwDgYDVR0PAQH/BAQDAgGG
# MBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRraSg6NS9IY0DPe9ivSek+2T3b
# ITBUBgNVHSAETTBLMEkGBFUdIAAwQTA/BggrBgEFBQcCARYzaHR0cDovL3d3dy5t
# aWNyb3NvZnQuY29tL3BraW9wcy9Eb2NzL1JlcG9zaXRvcnkuaHRtMBMGA1UdJQQM
# MAoGCCsGAQUFBwMIMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMA8GA1UdEwEB
# /wQFMAMBAf8wHwYDVR0jBBgwFoAUyH7SaoUqG8oZmAQHJ89QEE9oqKIwgYQGA1Ud
# HwR9MHsweaB3oHWGc2h0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvY3Js
# L01pY3Jvc29mdCUyMElkZW50aXR5JTIwVmVyaWZpY2F0aW9uJTIwUm9vdCUyMENl
# cnRpZmljYXRlJTIwQXV0aG9yaXR5JTIwMjAyMC5jcmwwgZQGCCsGAQUFBwEBBIGH
# MIGEMIGBBggrBgEFBQcwAoZ1aHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9w
# cy9jZXJ0cy9NaWNyb3NvZnQlMjBJZGVudGl0eSUyMFZlcmlmaWNhdGlvbiUyMFJv
# b3QlMjBDZXJ0aWZpY2F0ZSUyMEF1dGhvcml0eSUyMDIwMjAuY3J0MA0GCSqGSIb3
# DQEBDAUAA4ICAQBfiHbHfm21WhV150x4aPpO4dhEmSUVpbixNDmv6TvuIHv1xIs1
# 74bNGO/ilWMm+Jx5boAXrJxagRhHQtiFprSjMktTliL4sKZyt2i+SXncM23gRezz
# soOiBhv14YSd1Klnlkzvgs29XNjT+c8hIfPRe9rvVCMPiH7zPZcw5nNjthDQ+zD5
# 63I1nUJ6y59TbXWsuyUsqw7wXZoGzZwijWT5oc6GvD3HDokJY401uhnj3ubBhbkR
# 83RbfMvmzdp3he2bvIUztSOuFzRqrLfEvsPkVHYnvH1wtYyrt5vShiKheGpXa2AW
# psod4OJyT4/y0dggWi8g/tgbhmQlZqDUf3UqUQsZaLdIu/XSjgoZqDjamzCPJtOL
# i2hBwL+KsCh0Nbwc21f5xvPSwym0Ukr4o5sCcMUcSy6TEP7uMV8RX0eH/4JLEpGy
# ae6Ki8JYg5v4fsNGif1OXHJ2IWG+7zyjTDfkmQ1snFOTgyEX8qBpefQbF0fx6URr
# YiarjmBprwP6ZObwtZXJ23jK3Fg/9uqM3j0P01nzVygTppBabzxPAh/hHhhls6kw
# o3QLJ6No803jUsZcd4JQxiYHHc+Q/wAMcPUnYKv/q2O444LO1+n6j01z5mggCSlR
# wD9faBIySAcA9S8h22hIAcRQqIGEjolCK9F6nK9ZyX4lhthsGHumaABdWzCCB54w
# ggWGoAMCAQICEzMAAAA90Z/i1EHN40AAAAAAAD0wDQYJKoZIhvcNAQEMBQAwYTEL
# MAkGA1UEBhMCVVMxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEyMDAG
# A1UEAxMpTWljcm9zb2Z0IFB1YmxpYyBSU0EgVGltZXN0YW1waW5nIENBIDIwMjAw
# HhcNMjQwNDE4MTc1OTA4WhcNMjUwNDE3MTc1OTA4WjCB4jELMAkGA1UEBhMCVVMx
# EzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoT
# FU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEtMCsGA1UECxMkTWljcm9zb2Z0IElyZWxh
# bmQgT3BlcmF0aW9ucyBMaW1pdGVkMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjpD
# MzkyLTk2NDEtNDU0MDE1MDMGA1UEAxMsTWljcm9zb2Z0IFB1YmxpYyBSU0EgVGlt
# ZSBTdGFtcGluZyBBdXRob3JpdHkwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIK
# AoICAQDN4fglfsRUiZIPV5lJAuMPiV8CL4QqlttQfAozok1rvbAGV0s60oCU69gt
# FQ8lEgJ2aep6oDqYNe7yzeitjYGbGDa/prZjTsNC2elIKHBJu5JVfWCqHBk2fs1r
# jUbudtOyyTjhwVHZk1tB3UnK8QdJQrvzF/qejqVLQ+Jbr/5qd/uiHNdh7q1BAOiG
# tPJlna+TR+IU1nfn3vp8jp8MLxoJc3gl59fZSwZCAsrVcWoMJunp54mYqmbi4KXo
# a5PdwghfrRTIRq3wfDIap17060MTSyEUNhxIm79JrTxqJL4/LDoFWLgrg2sZUJ7G
# 7qEH9TBSI9+EEph84/VMcPF+zeuoG2beIY/ZM0+5KhOFFiyZTk9eIrkcbTeSRpe/
# +iag37wGPmHmLHDVYinpcwbS5cq6s5nDhC9XEwMH04Lucx9mUdxkueEN5E+slHEx
# 72yydFj2ECpH8oVCJlpm9SD5+Bnd0EHgRJ+4fBwHw4UohqbZcQWy0Im5YPZnhiTx
# QeJJkUxy12RCzg9S9z/FHUJMgfXaIEy7lH3is9lR2nTBi8rdajz6eckQc+AA8z67
# M9kYKsrxa2azBDkMyGgpVtSUXqguPjlh3X43oEPdGvlaCtWBSH+jbo40WjgWTeGW
# p3/SANE6LI2Wp1A1d9vvJZjbgY6fWKS2shf6qc2mzl0ihkkN5wIDAQABo4IByzCC
# AccwHQYDVR0OBBYEFJEC7Q7nomO84zd26pHuWDBbaSawMB8GA1UdIwQYMBaAFGtp
# KDo1L0hjQM972K9J6T7ZPdshMGwGA1UdHwRlMGMwYaBfoF2GW2h0dHA6Ly93d3cu
# bWljcm9zb2Z0LmNvbS9wa2lvcHMvY3JsL01pY3Jvc29mdCUyMFB1YmxpYyUyMFJT
# QSUyMFRpbWVzdGFtcGluZyUyMENBJTIwMjAyMC5jcmwweQYIKwYBBQUHAQEEbTBr
# MGkGCCsGAQUFBzAChl1odHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2Nl
# cnRzL01pY3Jvc29mdCUyMFB1YmxpYyUyMFJTQSUyMFRpbWVzdGFtcGluZyUyMENB
# JTIwMjAyMC5jcnQwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcD
# CDAOBgNVHQ8BAf8EBAMCB4AwZgYDVR0gBF8wXTBRBgwrBgEEAYI3TIN9AQEwQTA/
# BggrBgEFBQcCARYzaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9Eb2Nz
# L1JlcG9zaXRvcnkuaHRtMAgGBmeBDAEEAjANBgkqhkiG9w0BAQwFAAOCAgEAB0g+
# nIy4HHJKK1BxvxlxrMP+gMEF3OHo/amheINLM6ujwDzPc8+IgZId0yctdR06XiIQ
# Ek427+lfRMAO2M1N4VsjOF0xl59k0nCaYHHLfECjbwO/GKVrf76KYBtgMmzjuXBx
# jY9d/tSHE6RLcDdZhpsGc3fpiY/9p9Vb56bG/qGPVVJOkYR0g7NuDQpUy7Xr7GFG
# b2gwU3XKuVPYDdNO49Qxy3AdFV8JE1Ad/7Lem5dVC9Ajjh05lniM+ndszLvytvsq
# Fasd9zrrvIIiBPkH3VNo5yWcRMdf4hqXM5HG0dzLLfxh9TyKo7XRLgMr2+Fq2l3P
# w2tVCq2cD3gtLzR26szDeMckBnoBrDuh7ZBXnRoXkCEFkap3MDoGlSKWrICA6SEV
# 3LeMeep2oLM6mG2S+wKWMPzm/q04GeXGLRxGG7xjKytFoj5q/L0KyIW9mjtogod3
# kL9T0g6TJsDKUJVCekPo/1YZXP7u5PrZ7c6dGs3BsbyqXLDJF5TQfXYOnnaBPumh
# 2A3vZph2qE48hDrQKZRrLqpGjiAk98GQqR2Rb4TEKfK3otZYuJtQHloQMs7bMTTu
# qbhKYp/29ryyoEZyzy+y7Xtdyx/6rz5QhUk8mhFqMk+HZLRLQ1tlHF8gVaKxeuD2
# oSdHLpjvPgZtFifZXFzltkkUHbGrLfOaCUiWMUoxggbMMIIGyAIBATB4MGExCzAJ
# BgNVBAYTAlVTMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xMjAwBgNV
# BAMTKU1pY3Jvc29mdCBQdWJsaWMgUlNBIFRpbWVzdGFtcGluZyBDQSAyMDIwAhMz
# AAAAPdGf4tRBzeNAAAAAAAA9MA0GCWCGSAFlAwQCAQUAoIIEJTARBgsqhkiG9w0B
# CRACDzECBQAwGgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJEAEEMBwGCSqGSIb3DQEJ
# BTEPFw0yNDExMDEwOTM0MjVaMC8GCSqGSIb3DQEJBDEiBCCp43CfTOpxPj9sV/Xe
# PzVkDB2UYIw43MENwipdERZYeDCBuQYLKoZIhvcNAQkQAi8xgakwgaYwgaMwgaAE
# IJ/FNljsjXSPYE0BuFr7DRU3KiRGaVAioygTt7csc+54MHwwZaRjMGExCzAJBgNV
# BAYTAlVTMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xMjAwBgNVBAMT
# KU1pY3Jvc29mdCBQdWJsaWMgUlNBIFRpbWVzdGFtcGluZyBDQSAyMDIwAhMzAAAA
# PdGf4tRBzeNAAAAAAAA9MIIC5wYLKoZIhvcNAQkQAhIxggLWMIIC0qGCAs4wggLK
# MIICMwIBATCCARChgeikgeUwgeIxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNo
# aW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
# cG9yYXRpb24xLTArBgNVBAsTJE1pY3Jvc29mdCBJcmVsYW5kIE9wZXJhdGlvbnMg
# TGltaXRlZDEmMCQGA1UECxMdVGhhbGVzIFRTUyBFU046QzM5Mi05NjQxLTQ1NDAx
# NTAzBgNVBAMTLE1pY3Jvc29mdCBQdWJsaWMgUlNBIFRpbWUgU3RhbXBpbmcgQXV0
# aG9yaXR5oiMKAQEwBwYFKw4DAhoDFQDHkONLN7qgqDGVk+OTEUrEfUotdKBnMGWk
# YzBhMQswCQYDVQQGEwJVUzEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9u
# MTIwMAYDVQQDEylNaWNyb3NvZnQgUHVibGljIFJTQSBUaW1lc3RhbXBpbmcgQ0Eg
# MjAyMDANBgkqhkiG9w0BAQUFAAIFAOrOj64wIhgPMjAyNDEwMzEyMzIyMjJaGA8y
# MDI0MTEwMTIzMjIyMlowdzA9BgorBgEEAYRZCgQBMS8wLTAKAgUA6s6PrgIBADAK
# AgEAAgIcAgIB/zAHAgEAAgIRCDAKAgUA6s/hLgIBADA2BgorBgEEAYRZCgQCMSgw
# JjAMBgorBgEEAYRZCgMCoAowCAIBAAIDB6EgoQowCAIBAAIDAYagMA0GCSqGSIb3
# DQEBBQUAA4GBAI+dVZKqmc2wiMVjiKzd+1rsb4zy9fnQQ9kVHKkx7TYjopEuFlry
# wxbFi8ei5JoLa5MaIHwZtNPe91aYUHv+hS1jLDR/CSy69+/d5CM77cYuH3hC8mRH
# 7PK+fBfLg8VyufO+FfZCtnspqqkWNTtSsj7XwM5FLzh5a4sxpDpIid3AMA0GCSqG
# SIb3DQEBAQUABIICAHv97uvDnYirQSYFBN1Y6hU3dMmCN7/XJ50tIoCGjw4UQZ3j
# wf7tIB7hWLBftk/+TZRWKuLJ+8k2XLZi29TZTU3cwKoM97+jpIRqFz3KKJNaiKLJ
# 4w59KadUVMvmdc3WkJep657zRi70u2SIO9O0GmicAw5QuRHqnlVh3H7s4E1Lzt38
# cZ+WGQTbOBvTgM2tg4+Bds8Qtf/AX+WoenyRu5DcHaJqK/2qvzECSz+qhTOHG2jS
# Rm+QpUyTIRSvedOIc96//I7pQ2OgyCCg6HfTrk1YYgCMwSErSrejaO+fZ9nX6wET
# P0jAN9F4BCdO/uql3xAOXy+gN0VEGOmRwA+/yG0WOh76sgFBrrEedg/rM1qqMEem
# 3vbLNbh0zBjSc8QhRjuVDZkH/H/mF12mU64ZNRujWCUAt9HMvqdao6D8TbTWlfpi
# 1ry6a0OUF+H7QGVFfWIZsuQrXvyNxxymaxZJzjXDUOBbitDo1uQVk86KikuPgwhm
# 06VMl5WYYqRyIEeZ1kAwYaYWbV55mtNY3dvWo2rfLzWPXEwA5t1ikNXgrbg6kDvt
# Ri8o1lF5iouoJdLJAGBIkSlJZDl6oyUp+WjyZ/6IE49IYvQ6IA0liT2E0/qm5KFL
# 4M/EFNbhjh+4LUD1nNxuZ+yjohMMUvrYMMc96eSz3jUvSRG5mjJ5OP0sjR6b
# SIG # End signature block
