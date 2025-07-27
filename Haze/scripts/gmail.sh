#!/bin/bash
# Commander-ShepardN7 
# Gmail account credentials - requires xmlstarlet (sudo apt install xmlstarlet)
username="user@gmail.com"
password="you16digitPassword"
offset="         "  # Adjust the number of spaces for desired offset

curl -s -u "$username:$password" https://mail.google.com/mail/feed/atom/important | \
xmlstarlet sel -N a="http://purl.org/atom/ns#" -t -m "//a:entry" \
  -v "concat(a:author/a:name, ': ', a:title)" -n | \
head -n 4 | fold -s -w 50 | sed "s/^/${offset}/"


