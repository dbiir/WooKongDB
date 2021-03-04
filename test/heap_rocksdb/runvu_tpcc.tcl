#!/bin/tclsh
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
		if { [ vucomplete ] || $x eq $seconds } {
			set timerstop 1
		}
	}
	return
}

puts "SETTING CONFIGURATION"
dbset db pg
dbset bm TPC-C
diset connection pg_host 127.0.0.1
diset connection pg_port 15432

diset tpcc pg_user tpccheap
diset tpcc pg_pass tpccheap
diset tpcc pg_dbase tpccheap
vuset logtotemp 1
diset tpcc pg_driver timed
diset tpcc pg_rampup 1
diset tpcc pg_duration 1
diset tpcc pg_raiseerror true
loadscript

puts "SEQUENCE STARTED"
vuset vu 512
vucreate
vurun
runtimer 2400
vudestroy
after 5000
puts "TEST SEQUENCE COMPLETE"
exit
