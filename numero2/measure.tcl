set accuracy screen
set throttle off
set minframeskip 120
set mute on
set state 1
set radius {1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120}
set answer {5 13 29 49 81 113 149 197 253 317 377 441 529 613 709 797 901 1009 1129 1257 1373 1517 1653 1793 1961 2121 2289 2453 2629 2821 3001 3209 3409 3625 3853 4053 4293 4513 4777 5025 5261 5525 5789 6077 6361 6625 6921 7213 7525 7845 8173 8497 8809 9145 9477 9845 10189 10557 10913 11289 11681 12061 12453 12853 13273 13673 14073 14505 14949 15373 15813 16241 16729 17193 17665 18125 18605 19109 19577 20081 20593 21101 21629 22133 22701 23217 23769 24313 24845 25445 25997 26565 27145 27729 28345 28917 29525 30149 30757 31417 32017 32681 33317 33949 34621 35265 35953 36625 37297 37981 38669 39381 40089 40793 41545 42265 42981 43709 44469 45225}
set current 0
set total 0
debug set_bp 0x4010 {} {
  type_via_keybuf "\r"
}
debug set_bp 0xFF07 {$state == 1} {
  incr state
  type_via_keybuf "LOAD \"SOL.BAS\"\r"
}
debug set_bp 0xFF07 {$state == 2} {
  incr state
  if {$current > 0} {
    set newclock [machine_info time]
    set total [expr $total + $newclock - $lastclock]
    set lastclock $newclock
  }
  if {$current == 120} {
    puts stderr $total
    quit
    return
  }
  set lastclock [machine_info time]
  type_via_keybuf [format "RUN\r%d\r" [lindex $radius $current]]
  set expected [format "%d " [lindex $answer $current]]
  incr current
}
debug set_bp 0xFF07 {$state > 3} {
  puts stderr "bummer" 
  quit
}
debug set_watchpoint write_mem {0xF7C5 0xF7EF} {$state >= 3} {
  incr state
  set range {2 3 4 5 6 7 8 9 10}
  set output ""
  foreach r $range {
    append output [format %c [peek [expr $r + 0xF7C5]]]
  }
  if {[string first $expected $output] eq 0} {
    set state 2
  }
}

