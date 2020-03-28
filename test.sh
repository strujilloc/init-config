#!/usr/bin/env zsh
programs=(
"speedtest" 
"tools"
"tmux"
)
echo "Programs to be installed:"
for program in ${programs[@]}; do
    echo "->${program}"
done
inst_speedtest(){
    echo "executing function speedtest"
}
for program in ${programs[@]}; do
    case ${program} in
        speedtest)
            echo "Installing speedtest..."
            var="inst_${program}"
            $var
            ;;
        tools)
            echo "Installing tools..."
            ;;
        *)
            echo "${program} is unknown"
            ;;
    esac
done

