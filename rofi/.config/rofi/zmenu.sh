#!/bin/zsh

# --- CONFIGURAÇÃO ---
THEME="$HOME/.config/rofi/themes/style1.rasi"
TERMINAL="kitty" # Seu terminal preferido

# --- FUNÇÕES DE SUBMENU ---

# 1. Submenu de Configurações
menu_configs() {
    local -A confs
    confs=(
        "󰓅 Performance"      "perf"
        "󰖩 Rede (Impala)"    "iwgtk"
        "󰂯 Bluetooth"        "blueman-manager"
        "󰓃 Áudio"            "pavucontrol"
        "󰣇 Atualizar Arch"   "update"
        "󱕒 Editar Configs"   "edit"
        "󰔡 Hypr/Sway Conf"   "edit_wm"
    )

    # Pegamos apenas as chaves (os nomes com ícones) para o Rofi
    local choice=$(print ${(k)confs} | tr ' ' '\n' | rofi -dmenu -i -p "Config" -theme $THEME)

    case ${confs[$choice]} in
        perf)
            local p=$(print "performance\nbalanced\npower-saver" | rofi -dmenu -p "Perfil")
            [[ -n $p ]] && powerprofilesctl set $p
            ;;
        update)
            $TERMINAL -e sudo pacman -Syu
            ;;
        edit)
            local file=$(print "Monitor\nWaybar\nTeclado" | rofi -dmenu -p "Arquivo:")
            # Adicione aqui os caminhos reais:
            [[ $file == "Monitor" ]] && $TERMINAL -e nvim ~/.config/hypr/monitors.conf
            ;;
        edit_wm)
            $TERMINAL -e nvim ~/.config/hypr/hyprland.conf
            ;;
        *)
            # Se a escolha for um comando direto (como iwgtk ou pavucontrol)
            [[ -n ${confs[$choice]} ]] && eval ${confs[$choice]}
            ;;
    esac
}

# 2. Submenu de Print/Gravação
menu_print() {
    local options=("󰹑 Tela Cheia" "󰒉 Recorte" "󰕧 Gravar Vídeo")
    local choice=$(print -l $options | rofi -dmenu -i -p "Captura" -theme $THEME)

    case $choice in
        "󰹑 Tela Cheia") grim ~/Imagens/$(date +%s).png ;;
        "󰒉 Recorte")    grim -g "$(slurp)" ~/Imagens/$(date +%s).png ;;
        "󰕧 Gravar Vídeo") 
            local file="$HOME/Videos/recording_$(date +%s).mp4"
            notify-send "Gravando..." "Para parar, mate o processo wf-recorder"
            $TERMINAL -e wf-recorder -f $file 
            ;;
    esac
}

# 3. Submenu Power
menu_power() {
    local options=("󰗼 Sair" "󰜉 Reiniciar" "󰐥 Desligar")
    local choice=$(print -l $options | rofi -dmenu -i -p "Power" -theme $THEME)

    case $choice in
        "󰗼 Sair")      hyprctl dispatch exit || swaymsg exit ;;
        "󰜉 Reiniciar") reboot ;;
        "󰐥 Desligar")  poweroff ;;
    esac
}

# --- MENU PRINCIPAL ---

main() {
    local -A main_opts
    main_opts=(
        "󰀻 Apps"            "apps"
        "󱓞 Services"        "run"
        "⚙️ Config"          "config"
        "󰄀 Print"           "print"
        "󰐥 Power"           "power"
    )

    local choice=$(print ${(k)main_opts} | tr ' ' '\n' | rofi -dmenu -i -p "Menu" -theme $THEME)

    case ${main_opts[$choice]} in
        apps)   rofi -show drun -theme $THEME ;;
        run)    rofi -show run -theme $THEME ;;
        config) menu_configs ;;
        print)  menu_print ;;
        power)  menu_power ;;
    esac
}

# Executa o menu
main
