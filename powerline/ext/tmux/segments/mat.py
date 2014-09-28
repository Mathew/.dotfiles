# -*- coding: utf-8 -*-

import os
import sys
import socket

from powerline.theme import requires_segment_info
from powerline.segments.common import user, hostname, NowPlayingSegment


# Segments shouldn't live here but oh well.

class MacNowPlayingSegment(NowPlayingSegment):
    """
    Taken from a proposed PR for the powerline github.
    """
    STATE_SYMBOLS = {
        'fallback': '♫',
        'play': '♫',
        'pause': '▮▮',
        'stop': '■',
    }

    def player_spotify_mac(self, pl):
        ascript = '''
        tell application "System Events"
                set process_list to (name of every process)
        end tell

        if process_list contains "Spotify" then
                tell application "Spotify"
                        if player state is playing or player state is paused then
                                set track_name to name of current track
                                set artist_name to artist of current track
                                set album_name to album of current track
                                set track_length to duration of current track
                                set trim_length to 40
                                set now_playing to player state & album_name & artist_name & track_name & track_length
                                if length of now_playing is less than trim_length then
                                        set now_playing_trim to now_playing
                                else
                                        set now_playing_trim to characters 1 thru trim_length of now_playing as string
                                end if
                        else
                                return player state
                        end if

                end tell
        else
                return "stopped"
        end if
        '''

        spotify = asrun(ascript)

        spotify_status = spotify.split(", ")
        state = self._convert_state(spotify_status[0])
        if state == 'stop':
                return
        return {
            'state': state,
            'state_symbol': self.STATE_SYMBOLS.get(state),
            'album': spotify_status[1],
            'artist': "#[bold]" + spotify_status[2],
            'title': spotify_status[3],
            'total': self._convert_seconds(int(spotify_status[4]))
        }

mac_now_playing = MacNowPlayingSegment()


def asrun(ascript):
    "Run the given AppleScript and return the standard output and error."
    from subprocess import Popen, PIPE
    osa = Popen(
        ['osascript', '-'],
        stdin=PIPE,
        stdout=PIPE
    )
    return osa.communicate(ascript)[0]


def asquote(astr):
    "Return the AppleScript equivalent of the given string."

    astr = astr.replace('"', '" & quote & "')
    return '"{}"'.format(astr)


@requires_segment_info
def user_hostname(pl, segment_info, only_if_ssh=False, exclude_domain=False):
    user_seg = user(pl, segment_info)
    host = hostname(pl, segment_info, only_if_ssh, exclude_domain)

    user_seg[0]['contents'] = "{0}@{1}".format(user_seg[0]['contents'], host)
    return user_seg
