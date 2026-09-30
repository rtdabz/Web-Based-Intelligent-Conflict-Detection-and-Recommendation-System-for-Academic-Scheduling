<#
Conflict-avoiding git workflow for the team.

Rules this script enforces:
  1. Nobody commits directly to main. Each dev works on their own branch.
  2. Always start from the latest main.
  3. Before pushing, rebase your branch on the latest main so conflicts
     surface on YOUR machine, in small pieces, not at merge time.
  4. Push with --force-with-lease (safe: refuses if someone else pushed to your branch).
  5. Merge to main through a Pull Request.

Usage:
  .\scripts\git-sync.ps1 start feat/my-change   # new branch from latest main
  .\scripts\git-sync.ps1 pull                   # bring latest main into your branch
  .\scripts\git-sync.ps1 push "commit message"  # commit, rebase on main, push
  .\scripts\git-sync.ps1 status                 # how far behind/ahead of main
#>
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet('start', 'pull', 'push', 'status')]
    [string]$Command,

    [Parameter(Position = 1)]
    [string]$Arg
)

$ErrorActionPreference = 'Stop'
$Main = 'main'
$Remote = 'origin'

function Git {
    & git @args
    if ($LASTEXITCODE -ne 0) { throw "git $($args -join ' ') failed" }
}

function Current-Branch { (& git rev-parse --abbrev-ref HEAD).Trim() }

function Assert-Clean {
    if (& git status --porcelain) {
        throw 'You have uncommitted changes. Commit them (or `git stash`) first.'
    }
}

function Stop-OnRebaseConflict {
    Write-Host ''
    Write-Host 'Conflict while rebasing. Fix it like this:' -ForegroundColor Yellow
    Write-Host '  1. git status                      (see conflicted files)'
    Write-Host '  2. edit files, remove <<<<<<< ======= >>>>>>> markers, keep both sides'' intent'
    Write-Host '  3. git add <files>'
    Write-Host '  4. git rebase --continue'
    Write-Host '  5. re-run this script'
    Write-Host '  (to give up: git rebase --abort)'
    exit 1
}

function Rebase-On-Main {
    Git fetch $Remote
    & git rebase "$Remote/$Main"
    if ($LASTEXITCODE -ne 0) { Stop-OnRebaseConflict }
}

switch ($Command) {
    'start' {
        if (-not $Arg) { throw 'Give a branch name: start feat/my-change' }
        Assert-Clean
        Git fetch $Remote
        Git checkout -B $Arg "$Remote/$Main"
        Write-Host "On new branch $Arg, based on latest $Main." -ForegroundColor Green
    }

    'pull' {
        $branch = Current-Branch
        Assert-Clean
        Rebase-On-Main
        Write-Host "$branch is now up to date with $Main." -ForegroundColor Green
        Write-Host 'Reminder: run `composer install` / `npm install` / `php artisan migrate` if others changed deps or migrations.'
    }

    'push' {
        $branch = Current-Branch
        if ($branch -eq $Main) { throw "Do not push straight to $Main. Use: start feat/your-change" }
        if (-not $Arg) { throw 'Give a commit message: push "what you changed"' }

        if (& git status --porcelain) {
            Git add -A
            Git commit -m $Arg
        }

        Rebase-On-Main

        # First push of a new branch, or update after rebase.
        Git push --force-with-lease -u $Remote $branch
        Write-Host "Pushed $branch. Open a Pull Request into $Main." -ForegroundColor Green
    }

    'status' {
        Git fetch $Remote
        $branch = Current-Branch
        $behind = (& git rev-list --count "HEAD..$Remote/$Main").Trim()
        $ahead = (& git rev-list --count "$Remote/$Main..HEAD").Trim()
        Write-Host "$branch is $ahead commit(s) ahead and $behind commit(s) behind $Remote/$Main."
        if ([int]$behind -gt 0) { Write-Host 'Run: .\scripts\git-sync.ps1 pull' -ForegroundColor Yellow }
    }
}
