#!/bin/bash

users=$(awk -F ":" 'BEGIN {OFS=":"}{print $1,$6}' /etc/passwd)
#md5_file=/var/log/current_users
#changes_file=/var/log/user_changes

md5_file=./current_users
changes_file=./user_changes
test -f $md5_file || touch $md5_file
test -f $changes_file || touch $changes_file

oldhash=$(cat $md5_file | awk -F " " '{print $1}')
newhash=$(echo -n $users | md5sum | awk -F " " '{print $1}')

echo $oldhash
echo $newhash

if [ "$newhash" != "$oldhash" ]; then
	echo "$(date "+%Y/%m/%d %T") changes occurred" > $changes_file
fi
echo $newhash > $md5_file

