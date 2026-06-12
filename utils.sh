#!/data/data/com.termux/files/usr/bin/bash
# ─────────────────────────────────────────
#  GIT-GET — utils.sh
#  Dev: Md. Mainul Islam (CODEX-M41NUL)
# ─────────────────────────────────────────

# Color scheme: Yellow / Green / White
Y="\033[93m"       # Yellow  (primary)
G="\033[92m"       # Green   (secondary)
W="\033[97m"       # White   (text)
R="\033[91m"       # Red     (error)
DIM="\033[2m"
B="\033[1m"
RST="\033[0m"

ok_msg()   { echo -e "  ${G}${B}+${RST}  ${W}$1${RST}"; }
err_msg()  { echo -e "  ${R}${B}x${RST}  ${W}$1${RST}"; }
info_msg() { echo -e "  ${Y}${B}>${RST}  ${W}$1${RST}"; }
warn_msg() { echo -e "  ${Y}${B}!${RST}  ${W}$1${RST}"; }

separator() { echo -e "  ${Y}$(printf '%0.s-' $(seq 1 55))${RST}"; }

clear_screen() { clear; }

progress_bar() {
    local label="$1"
    local total=35
    local bar_width=30
    for i in $(seq 1 $total); do
        filled=$(( bar_width * i / total ))
        arrow=""
        [ $filled -gt 1 ] && arrow=$(printf '%0.s=' $(seq 1 $(( filled - 1 ))))
        [ $filled -gt 0 ] && arrow="${arrow}>"
        empty=$(printf '%0.s.' $(seq 1 $(( bar_width - filled ))))
        pct=$(( 100 * i / total ))
        if   [ $pct -lt 40 ]; then bc="${R}"
        elif [ $pct -lt 80 ]; then bc="${Y}"
        else bc="${G}"; fi
        printf "\r  ${W}%-22s${RST}  ${bc}${B}[%-30s]${RST}  ${W}%3d%%${RST}" \
               "$label" "${arrow}${empty}" "$pct"
        sleep 0.03
    done
    echo ""
}

spinner() {
    local label="$1"
    local duration="${2:-3}"
    local frames=("|" "/" "-" "\\")
    local end_at=$(( $(date +%s) + duration ))
    local i=0
    while [ "$(date +%s)" -lt "$end_at" ]; do
        printf "\r  ${Y}${B}%s${RST}  ${W}%s${RST}  " "${frames[$((i % 4))]}" "$label"
        sleep 0.1
        (( i++ ))
    done
    printf "\r  ${G}${B}+${RST}  ${W}%s - Done!${RST}      \n" "$label"
}

prompt_input() {
    local msg="$1"
    local example="$2"
    [ -n "$example" ] && echo -e "\n  ${DIM}${W}Example : $example${RST}"
    echo -ne "\n  ${Y}${B}>${RST}  ${W}${msg}${RST}  "
    read -r val
    echo "$val"
}

pause() {
    echo -ne "\n  ${Y}Press ENTER to continue...${RST}  "
    read -r
}
