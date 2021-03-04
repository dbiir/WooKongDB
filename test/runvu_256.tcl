#!/bin/tclsh
set i 1
set USERNAME [index $argv $i]
set i 2
set HOST [index $argv $i]
set i 3
set PORT [index $argv $i]
set i 4
set USEDATABASE [index $argv $i]

proc runtimer { seconds } {
set x 0
set timerstop 0
	while {!$timerstop} {
		incr x
		after 1000
		if { ![ expr {$x % 60} ] } {
			set y [ expr $x / 60 ]
			puts "Timer: $y minutes elapsed"
		}
		update
		if {  [ vucomplete ] || $x eq $seconds } { set timerstop 1 }
	}
	return
}

puts "SETTING CONFIGURATION"
dbset db pg
dbset bm TPC-C
diset connection pg_host $HOST
diset connection pg_port $PORT

diset tpcc pg_user $USEDATABASE
diset tpcc pg_pass $USEDATABASE
diset tpcc pg_dbase $USEDATABASE
vuset logtotemp 1
diset tpcc pg_driver timed
diset tpcc pg_rampup 2
diset tpcc pg_duration 3
diset tpcc pg_raiseerror true
loadscript

puts "SEQUENCE STARTED"
foreach z { 8 16 32 64 128 } {
	puts "$z VU TEST"
	vuset vu $z
	vucreate
	vurun
	runtimer 2400
	vudestroy
	after 5000
}
puts "TEST SEQUENCE COMPLETE"
exit
