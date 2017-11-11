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
    }

$jsonStandard = ConvertTo-Json $standardRules
$jsonContrib = ConvertTo-Json $contribRules
Set-Content "BPARules-standard.json" $standardRules
Set-Content "BPARules-contrib.json" $contribRules