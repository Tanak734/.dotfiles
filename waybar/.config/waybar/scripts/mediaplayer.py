#!/usr/bin/env python3
import json
import gi
gi.require_version('Playerctl', '2.0')
from gi.repository import Playerctl, GLib

def on_metadata(player, metadata):
    data = {}
    if player.get_property('player-name') == 'spotify':
        data['class'] = 'spotify'
    elif player.get_property('player-name') == 'firefox':
        data['class'] = 'youtube'
    
    artist = player.get_artist()
    title = player.get_title()
    
    data['text'] = f"{artist} - {title}" if artist else title
    print(json.dumps(data))

manager = Playerctl.PlayerManager()

def on_name_appeared(manager, name):
    player = Playerctl.Player.new_from_name(name)
    player.connect('metadata', on_metadata)
    on_metadata(player, None)

manager.connect('name-appeared', on_name_appeared)
for name in manager.props.player_names:
    on_name_appeared(manager, name)

GLib.MainLoop().run()
