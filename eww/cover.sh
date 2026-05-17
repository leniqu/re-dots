#!/usr/bin/env bash
cover_url=$(playerctl metadata mpris:artUrl 2>/dev/null)
if [ -n "$cover_url" ]; then
    curl -s "$cover_url" -o /tmp/cover.jpg
fi
