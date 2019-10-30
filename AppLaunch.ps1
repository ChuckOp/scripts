# Measure app start times

$Apps =  
    "$Env:windir\system32\SnippingTool.exe",
    "$Env:windir\system32\calc.exe",
    "${Env:ProgramFiles(x86)}\Windows Media Player\wmplayer.exe",
    "$Env:ProgramFiles\Windows NT\Accessories\wordpad.exe",
    "${Env:ProgramFiles(x86)}\Microsoft Office\root\Office16\winword.exe",
    "${Env:ProgramFiles(x86)}\Microsoft Office\root\Office16\outlook.exe",
    "${Env:ProgramFiles(x86)}\Microsoft Office\root\Office16\excel.exe",
    "${Env:ProgramFiles(x86)}\Microsoft Office\root\Office16\powerpnt.exe",
    "${Env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe"

Measure-Command { 
    Foreach ($App in $Apps) {
        Write-Output "Launching " | Out-Default;
        Write-Output $App | Out-Default;
        Start-Process -FilePath $App | Out-Default;
    }
    Read-Host -Prompt "Press any key when apps have finished loading"
}
 