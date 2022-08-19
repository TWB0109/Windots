# Enable vi editing mode
Set-PSReadLineOption -EditMode Vi

$ENV:STARSHIP_CONFIG = "$HOME\starship\config.toml"
Invoke-Expression (&starship init powershell)

# ALIASES
## :q = exit
function QuitWithColonQ
{
  Invoke-command -ScriptBlock {exit}
}

New-Alias -Name :q -Value QuitWithColonQ

## Grep
New-Alias -Name grep -Value sls

## vim = hx
New-Alias -Name vim -Value hx

#  Powershell 'cd' that behaves like a real shell
#  no args brings you home, '-' brings you to the previous dir 
#  Credits: https://github.com/albertvaka

del alias:cd -Force # Remove builtin cd alias to Set-Location
function cd {
    $pwd = Get-Location
    if ($args.Count -eq 0) {
        Set-Location ~
    } elseif ($args[0] -eq "-") {
        Set-Location @global:OLDPWD
    } else {
        Set-Location @args
    }
    $global:OLDPWD = $pwd
}

# Bonus: Make autocompletion work like on bash:
# Set-PSReadlineKeyHandler -Key Tab -Function Complete
# Or like in zsh:
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
