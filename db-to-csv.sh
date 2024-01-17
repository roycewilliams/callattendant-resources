#!/bin/bash
# Recommended: ".mode column" in .sqliterc for legibility

SHOW_RECORD_COUNT=3

for table in CallLog Blacklist Whitelist Message; do
	wc -l ${table}.csv
	sqlite3 -header -csv -separator $'\t'  callattendant.db "SELECT * from ${table};" >${table}.csv
	wc -l ${table}.csv
	head -n ${SHOW_RECORD_COUNT} ${table}.csv
	echo '-'
	tail -n ${SHOW_RECORD_COUNT} ${table}.csv
done
