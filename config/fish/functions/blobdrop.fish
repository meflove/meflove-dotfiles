function __fzf_complete_bd
    set -l tokens (commandline -op)
    set -l token (commandline -t)

    # Если первый токен - 'bd' и это первый аргумент
    if test (count $tokens) -ge 1 && [ "$tokens[1]" = bd ] && test (count $tokens) -le 2
        # Запуск fzf с bat preview
        set -l file (
            fzf --height 40% --reverse --border --query="$token" \
                --preview="bat --style=numbers --color=always {} 2>/dev/null | head -500" \
                --preview-window="right:60%"
        )

        if test -n "$file"
            commandline -t ""
            commandline -it -- (string escape -- "$file")
        end
        commandline -f repaint
    else
        # Стандартное автодополнение для других команд
        commandline -f complete
    end
end

# Привязка к Tab
bind \t __fzf_complete_bd
