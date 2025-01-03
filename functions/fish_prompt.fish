function fish_prompt
  set -l CONNECTORS 'in' 'on' 'is' 'via'
  set -l last_status $status
  set -l end (set_color normal)
  set orange fab387

  # Indicator
  if test $last_status = 0
    set INDICATOR (set_color green)↪ $end
  else
    set INDICATOR (set_color red)✗ $end
  end

  # Username
  set COLORED_USER (set_color red --bold)$USER$end

  # Current Directory
  set dir_icon 󰉋
  if not test -w .
    set dir_icon 
  end
  set current_dir (basename $PWD)

  if test $PWD = $HOME
    set current_dir '~'
  end

  set DIRECTORY $CONNECTORS[1] (set_color cyan --bold --italic)$dir_icon $current_dir$end

  # Git Branch
  set branch (git symbolic-ref --short HEAD 2>/dev/null)
  if test -n "$branch"
    set GIT_BRANCH $CONNECTORS[2] (set_color magenta --bold) $branch$end
  end

  # Git Info
  set info_commit (git status -s 2>/dev/null | cut -c 1-2 | uniq | tr -d '[:space:]')
  if test -n "$info_commit"
    set git_status "[$info_commit]"
    set GIT_INFO (set_color $orange --bold --italic)$git_status$end
  end

  # Package Version
  if test -f package.json
    set PACKAGE_VERSION $CONNECTORS[3] (set_color yellow --bold)󰏗 (node -p "require('./package.json').version" 2>/dev/null)$end
  end

  # Node.js Version
  if type -q node
    set TOOL_VERSION $CONNECTORS[4] (set_color green --bold) (node --version | tr -d 'v')$end
  end

  # Java Version
  if type -q java
    set TOOL_VERSION $CONNECTORS[4] (set_color bright-red --bold) (java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')$end
  end

  # PHP Version
  if type -q php
    set TOOL_VERSION $CONNECTORS[4] (set_color bright-blue --bold) (php --version | head -n 1 | awk '{print $2}')$end
  end

  # Python Version
  if type -q python
    set TOOL_VERSION $CONNECTORS[4] (set_color blue --bold) (python --version | awk '{print $2}')$end
  end

  # .NET Version
  if type -q dotnet
    set TOOL_VERSION $CONNECTORS[4] (set_color magenta --bold) (dotnet --version)$end
  end

  if type -q rustc
    set TOOL_VERSION $CONNECTORS[4] (set_color $orange --bold)󱘗 (rustc --version | awk '{print $2}')$end
  end

  # Prompt
  echo -n $COLORED_USER $DIRECTORY $GIT_BRANCH $GIT_INFO $PACKAGE_VERSION $TOOL_VERSION
  echo # Second line separation
  echo -n $INDICATOR
end
