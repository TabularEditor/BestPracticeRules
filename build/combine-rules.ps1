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
if($jsonStandard -eq "") { $jsonStandard = "[]" }
if($jsonContrib -eq "") { $jsonContrib = "[]" }

Set-Content ($env:Build_SourcesDirectory + "\BPARules-standard.json") $jsonStandard
Set-Content ($env:Build_SourcesDirectory + "\BPARules-contrib.json") $jsonContrib
Write-Host "Finished combining" $standardRules.Length "standard rule(s)"
Write-Host "Finished combining" $contribRules.Length "contrib rule(s)"

cd $env:Build_SourcesDirectory
Write-Host "##[command]git add ."
git add .
Write-Host "##[command]git commit -m ""Combined rules"""
git commit -m "Combined rules"
Write-Host "##[command]git push origin master"
git push origin master