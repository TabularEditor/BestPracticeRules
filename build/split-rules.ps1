param (
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
	[string]$combinedRulesFile,
    [Parameter(Mandatory = $true)]
	[string]$outputPath
)

import-module Newtonsoft.Json

$rulesJson = Get-Content -Raw $combinedRulesFile
$rules = [Newtonsoft.Json.Linq.JArray]::Parse($rulesJson)
ForEach($rule in $rules) {
    $dummy = New-Item -ItemType Directory -Force -Path "$outputPath\$($rule.Category)"
	$parsedRule = $rule.ToString() | ConvertFrom-Json
	Write-Host "Category: " $parsedRule.Category
	Set-Content "$outputPath\$($parsedRule.Category)\$($parsedRule.ID).json" $rule.ToString()
}