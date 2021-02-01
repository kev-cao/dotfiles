#!/bin/bash
cd /home/kevin/Documents/personal_projects/manga-notifier
if [[ -f "config.json" ]]; then
  source bin/activate
  python scraper.py
fi
