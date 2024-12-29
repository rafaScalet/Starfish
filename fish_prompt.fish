function fish_prompt
    # Username
    set_color red --bold
    printf $USER
    set_color normal
    printf ' in '

    # Current Directory
    set_color cyan --bold --italic
    set dir_icon 󰉋
    if not test -w .
        set dir_icon 
    end
    set current_dir (basename $PWD)

    printf "$dir_icon $current_dir"
    set_color normal

    # Git Branch
    set branch (git symbolic-ref --short HEAD 2>/dev/null)
    if test -n "$branch"
        printf ' on '
        set_color magenta --bold
        printf " $branch"
        set_color normal
    end

    # Package Version
    if test -f package.json
        printf " is "
        set_color yellow --bold
        printf "󰏗 "(node -p "require('./package.json').version" 2>/dev/null)
        set_color normal
    end

    # Node.js Version
    if type -q node
        printf " via "
        set_color green --bold
        echo -n "" (node --version | tr -d 'v')
        set_color normal
    end

    # Java Version
    if type -q java
        printf " via "
        set_color bright-red --bold
        echo -n "" (java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')
        set_color normal
    end

    # PHP Version
    if type -q php
        printf " via "
        set_color bright-blue --bold
        echo -n "" (php --version | head -n 1 | awk '{print $2}')
        set_color normal
    end

    # Python Version
    if type -q python
        printf " via "
        set_color blue --bold
        echo -n "" (python --version | awk '{print $2}')
        set_color normal
    end

    # .NET Version
    if type -q dotnet
        printf " via "
        set_color magenta --bold
        echo -n "" (dotnet --version)
        set_color normal
    end

    echo

    set_color green --bold
    echo -n "↪  "
    set_color normal
end
