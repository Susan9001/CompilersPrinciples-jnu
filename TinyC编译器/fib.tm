* TINY Compilation to TM Code
* File: fib.tm
* Standard prelude:
  0:     LD  6,0(0) 	load maxaddress from location 0
  1:     ST  0,0(0) 	clear location 0
* End of standard prelude.
  2:     IN  0,0,0 	read integer value
  3:     ST  0,0(5) 	read: store value
* -> assign
* -> Const
  4:    LDC  0,0(0) 	load const
* <- Const
  5:     ST  0,1(5) 	assign: store value
* <- assign
* -> if
* -> Op
* -> Const
  6:    LDC  0,0(0) 	load const
* <- Const
  7:     ST  0,0(6) 	op: push left
* -> Id
  8:     LD  0,0(5) 	load id value
* <- Id
  9:     LD  1,0(6) 	op: load left
 10:    SUB  0,1,0 	op <
 11:    JLT  0,2(7) 	br if true
 12:    LDC  0,0(0) 	false case
 13:    LDA  7,1(7) 	unconditional jmp
 14:    LDC  0,1(0) 	true case
* <- Op
* if: jump to else belongs here
* -> if
* -> Op
* -> Id
 16:     LD  0,0(5) 	load id value
* <- Id
 17:     ST  0,0(6) 	op: push left
* -> Const
 18:    LDC  0,1(0) 	load const
* <- Const
 19:     LD  1,0(6) 	op: load left
 20:    SUB  0,1,0 	op ==
 21:    JEQ  0,2(7) 	br if true
 22:    LDC  0,0(0) 	false case
 23:    LDA  7,1(7) 	unconditional jmp
 24:    LDC  0,1(0) 	true case
* <- Op
* if: jump to else belongs here
* -> assign
* -> Const
 26:    LDC  0,1(0) 	load const
* <- Const
 27:     ST  0,1(5) 	assign: store value
* <- assign
* -> Id
 28:     LD  0,1(5) 	load id value
* <- Id
 29:    OUT  0,0,0 	write ac
* if: jump to end belongs here
 25:    JEQ  0,5(7) 	if: jmp to else
* -> assign
* -> Const
 31:    LDC  0,3(0) 	load const
* <- Const
 32:     ST  0,2(5) 	assign: store value
* <- assign
* -> assign
* -> Const
 33:    LDC  0,1(0) 	load const
* <- Const
 34:     ST  0,3(5) 	assign: store value
* <- assign
* -> assign
* -> Const
 35:    LDC  0,1(0) 	load const
* <- Const
 36:     ST  0,4(5) 	assign: store value
* <- assign
* -> Id
 37:     LD  0,3(5) 	load id value
* <- Id
 38:    OUT  0,0,0 	write ac
* -> Id
 39:     LD  0,4(5) 	load id value
* <- Id
 40:    OUT  0,0,0 	write ac
* -> repeat
* repeat: jump after body comes back here
* -> assign
* -> Op
* -> Id
 41:     LD  0,3(5) 	load id value
* <- Id
 42:     ST  0,0(6) 	op: push left
* -> Id
 43:     LD  0,4(5) 	load id value
* <- Id
 44:     LD  1,0(6) 	op: load left
 45:    ADD  0,1,0 	op +
* <- Op
 46:     ST  0,1(5) 	assign: store value
* <- assign
* -> Id
 47:     LD  0,1(5) 	load id value
* <- Id
 48:    OUT  0,0,0 	write ac
* -> assign
* -> Id
 49:     LD  0,4(5) 	load id value
* <- Id
 50:     ST  0,3(5) 	assign: store value
* <- assign
* -> assign
* -> Id
 51:     LD  0,1(5) 	load id value
* <- Id
 52:     ST  0,4(5) 	assign: store value
* <- assign
* -> assign
* -> Op
* -> Id
 53:     LD  0,2(5) 	load id value
* <- Id
 54:     ST  0,0(6) 	op: push left
* -> Const
 55:    LDC  0,1(0) 	load const
* <- Const
 56:     LD  1,0(6) 	op: load left
 57:    ADD  0,1,0 	op +
* <- Op
 58:     ST  0,2(5) 	assign: store value
* <- assign
* -> Op
* -> Id
 59:     LD  0,0(5) 	load id value
* <- Id
 60:     ST  0,0(6) 	op: push left
* -> Id
 61:     LD  0,2(5) 	load id value
* <- Id
 62:     LD  1,0(6) 	op: load left
 63:    SUB  0,1,0 	op <
 64:    JLT  0,2(7) 	br if true
 65:    LDC  0,0(0) 	false case
 66:    LDA  7,1(7) 	unconditional jmp
 67:    LDC  0,1(0) 	true case
* <- Op
 68:    JEQ  0,-28(7) 	repeat: jmp back to body
* <- repeat
 30:    LDA  7,38(7) 	jmp to end
* <- if
* if: jump to end belongs here
 15:    JEQ  0,54(7) 	if: jmp to else
 69:    LDA  7,0(7) 	jmp to end
* <- if
* End of execution.
 70:   HALT  0,0,0 	
