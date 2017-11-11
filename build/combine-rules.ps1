$standardRules = @()
$contribRules = @()

Get-ChildItem -Recurse -Filter *.json |
    ForEach-Object {
        $src = $_.DirectoryName.Substring($_.DirectoryName.IndexOf("\src") + 5)
        $ruleJson = Get-Content -Raw -Path $_.FullName
        $rule = ConvertFrom-Json $ruleJson

        $rule | Add-Member Source $src

        if($src.StartsWith("standard")) { $standardRules += $rule }
        if($src.StartsWith("contrib")) { $contribRules += $rule }

        Write-Host "Processing rule:" $_.Name
    }

$jsonStandard = ConvertTo-Json $standardRules
$jsonContrib = ConvertTo-Json $contribRules
Write-Host $env:build_stagingDirectory
Set-Content ($env:build_stagingDirectory + "\BPARules-standard.json") $standardRules
Set-Content ($env:build_stagingDirectory + "\BPARules-contrib.json") $contribRules
Write-Host "Finished combining" $standardRules.Length "standard rule(s)"
Write-Host "Finished combining" $contribRules.Length "contrib rule(s)"