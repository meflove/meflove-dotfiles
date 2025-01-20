function magic-enter-cmd --description "Customize your own magic-commands"
    # default magic command
    set --local my_magic_command ll

    # git dir magic command
    if command git rev-parse --is-inside-work-tree &>/dev/null
        set my_magic_command "ll && git status"
    end

    # look for something else, like an .env directory
    # or whatever other magic commands you need
    # ...

    # be sure not to actually run the command
    # just print it out
    echo $my_magic_command
end
