﻿function Get-ScriptDirectory{
    # like https://blogs.msdn.microsoft.com/powershell/2007/06/19/get-scriptdirectory-to-the-rescue/
    # this script wants to find files in the same folder
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    try {
        Split-Path $Invocation.MyCommand.Path -ea 0
    }
    catch {
        Write-Warning 'You need to call this function from within a saved script.'
    }
}
# set location. include scripts, and set variables
$sd = Get-ScriptDirectory
Set-Location $sd
.\ExceLoader\Create-XamlAmlForm.ps1  # function that implements the GUI

# create parameters to pass to XamlForm
$xamlFile =   $sd + '\ExceLoader\XamlAml.xaml'
$configFile = $sd + '\config.xml'

# show the Xaml GUI
$Form = Create-XamlAmlForm -sd $sd -xaml $xamlFile -configFile $configFile
try {
    $Form.ShowDialog() | Out-Null
}
catch {
  Write-Host $_
}
finally {
    $Form.Close()
}