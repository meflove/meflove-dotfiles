function perp
    echo "Perplexity lookup for: $argv"
    set search (string join '%20' $argv)
    xdg-open "https://www.perplexity.ai/search?s=o&q=$search" 2&>/dev/null &
end
