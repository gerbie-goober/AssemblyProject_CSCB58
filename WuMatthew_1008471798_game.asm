#####################################################################
#
# CSCB58 Winter 2023 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Matthew Wu, 1008471798, wumatth8, matthewwyne.wu@mail.utoronto.ca
#
# Bitmap Display Configuration:
# - Unit width in pixels: 4 
# - Unit height in pixels: 4 
# - Display width in pixels: 256 
# - Display height in pixels: 256 
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestones have been reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 3 
#
# Which approved features have been implemented for milestone 3?
# 1. moving objects (2)
# 2. moving platforms (2)
# 3. health score (3 LIVES MAX)
# 4. START MENU
# 5. win condition (reach the wormhole)
# 6. lose condition (lose all three lives)
#
# Link to video demonstration for final submission:
# - https://www.loom.com/share/8786033c55fc4296bcd0ed7502eb1425
#
# Are you OK with us sharing the video with people outside course staff?
# - yes
#
# Any additional information that the TA needs to know:
# - (write here, if any)
#
#####################################################################

#ADDRESSES
.eqv BASE_ADDRESS 0x10008000
.eqv TITLE_ZERO 0x10008140
.eqv START_ZERO 0x10008A1c
.eqv PLAYER_ZERO 0x1000ad08
.eqv OBSTACLE_ZERO 0x1000a2e0
.eqv SUCCESS_ZERO 0x10008b34
.eqv FAIL_ZERO 0x10008f2c
.eqv LIVES_ZERO 0x1000828c
#COLORS
.eqv PLAYER_COLOR 0xc334eb
.eqv PICKUP_COLOR 0xeb3c4e
.eqv BACKGROUND_COLOR 0x00000
.eqv OBSTACLE_COLOR 0x8ce3f5
.eqv PLATFORM_COLOR 0xfffff0
.eqv PORTAL_COLOR 0xf59728
	
.text
.globl main
main:
	li $t0, BASE_ADDRESS # $t0 stores the base address for display
	li $s0, PLAYER_ZERO # $s0 stores the top left of player
	li $t9, OBSTACLE_ZERO 
	
	li $t2, PLAYER_COLOR # $t2 stores the player body color
	li $t3, PLATFORM_COLOR # $t3 stores white (PLATFORM COLOR)
	li $t4, BACKGROUND_COLOR # t4 stores black (BACKGROUND COLOR)
	li $t5, PICKUP_COLOR
	li $s2, OBSTACLE_COLOR
	li $t1, PORTAL_COLOR
	
	li $s1, BASE_ADDRESS #temp var to store address
	li $s7, 0 #temp index
	jal CLEAR_SCREEN
	
LOAD_START_SCREEN:
	jal DRAW_TITLE
	jal DRAW_START
	
	li $s5, 12
	
	li $s1, 0xffff0000
	lw $s1 0($s1)
	beq $s1, 1, keypress_loop_start
	
	#sleep for 0.1 seconds
	li $a0, 100
	li $v0, 32
	syscall
	 
	j LOAD_START_SCREEN

keypress_loop_start:
	lw $s1, 0xffff0004
	beq $s1, 0x72, R_PRESSED
	beq $s1, 0x71, Q_PRESSED
	
	j LOAD_START_SCREEN
	

DRAW_TITLE:
	li $s4, TITLE_ZERO
	# W
	sw $t3, 0($s4)
	sw $t3, 256($s4)
	sw $t3, 512($s4)
	sw $t3, 768($s4)
	sw $t3, 1024($s4)
	sw $t3, 1280($s4)
	sw $t3, 1284($s4)
	sw $t3, 1288($s4)
	sw $t3, 1292($s4)
	sw $t3, 1296($s4)
	sw $t3, 1032($s4)
	sw $t3, 776($s4)
	sw $t3, 520($s4)
	sw $t3, 1040($s4)
	sw $t3, 784($s4)
	sw $t3, 528($s4)
	sw $t3, 272($s4)
	sw $t3, 16($s4)
	#.
	sw $t3, 1304($s4)
	#O
	sw $t3, 32($s4)
	sw $t3, 288($s4)
	sw $t3, 544($s4)
	sw $t3, 800($s4)
	sw $t3, 1056($s4)
	sw $t3, 1312($s4)
	sw $t3, 36($s4)
	sw $t3, 40($s4)
	sw $t3, 44($s4)
	sw $t3, 48($s4)
	sw $t3, 304($s4)
	sw $t3, 560($s4)
	sw $t3, 816($s4)
	sw $t3, 1072($s4)
	sw $t3, 1328($s4)
	sw $t3, 1324($s4)
	sw $t3, 1320($s4)
	sw $t3, 1316($s4)
	#.
	sw $t3, 1336($s4)
	#R
	sw $t3, 68($s4)
	sw $t3, 324($s4)
	sw $t3, 580($s4)
	sw $t3, 836($s4)
	sw $t3, 1092($s4)
	sw $t3, 1348($s4)
	sw $t3, 1344($s4)
	sw $t3, 72($s4)
	sw $t3, 76($s4)
	sw $t3, 80($s4)
	sw $t3, 336($s4)
	#.
	sw $t3, 1368($s4)
	#M
	sw $t3, 96($s4)
	sw $t3, 352($s4)
	sw $t3, 608($s4)
	sw $t3, 864($s4)
	sw $t3, 1120($s4)
	sw $t3, 1376($s4)
	sw $t3, 100($s4)
	sw $t3, 104($s4)
	sw $t3, 360($s4)
	sw $t3, 616($s4)
	sw $t3, 872($s4)
	sw $t3, 108($s4)
	sw $t3, 112($s4)
	sw $t3, 368($s4)
	sw $t3, 624($s4)
	sw $t3, 880($s4)
	sw $t3, 1136($s4)
	sw $t3, 1392($s4)
	#.
	sw $t3, 1400($s4)
	jr $ra

DRAW_START:
	li $s4, START_ZERO
	#P
	sw $t3, 0($s4)
	sw $t3, 256($s4)
	sw $t3, 512($s4)
	sw $t3, 516($s4)
	sw $t3, 520($s4)
	sw $t3, 264($s4)
	sw $t3, 768($s4)
	sw $t3, 1024($s4)
	sw $t3, 4($s4)
	sw $t3, 8($s4)
	#R
	sw $t3, 16($s4)
	sw $t3, 272($s4)
	sw $t3, 528($s4)
	sw $t3, 784($s4)
	sw $t3, 1040($s4)
	sw $t3, 20($s4)
	sw $t3, 24($s4)
	sw $t3, 280($s4)
	#E
	sw $t3, 32($s4)
	sw $t3, 288($s4)
	sw $t3, 544($s4)
	sw $t3, 548($s4)
	sw $t3, 552($s4)
	sw $t3, 800($s4)
	sw $t3, 1056($s4)
	sw $t3, 1060($s4)
	sw $t3, 1064($s4)
	sw $t3, 36($s4)
	sw $t3, 40($s4)
	
	#S
	sw $t3, 48($s4)
	sw $t3, 304($s4)
	sw $t3, 564($s4)
	sw $t3, 568($s4)
	sw $t3, 824($s4)
	sw $t3, 1072($s4)
	sw $t3, 1076($s4)
	sw $t3, 1080($s4)
	sw $t3, 52($s4)
	sw $t3, 56($s4)
	
	#S
	sw $t3, 64($s4)
	sw $t3, 320($s4)
	sw $t3, 580($s4)
	sw $t3, 584($s4)
	sw $t3, 840($s4)
	sw $t3, 1096($s4)
	sw $t3, 1092($s4)
	sw $t3, 1088($s4)
	sw $t3, 68($s4)
	sw $t3, 72($s4)
	
	#R
	sw $t2, 88($s4)
	sw $t2, 92($s4)
	sw $t2, 96($s4)
	sw $t2, 352($s4)
	sw $t2, 344($s4)
	sw $t2, 600($s4)
	sw $t2, 856($s4)
	sw $t2, 1112($s4)
	
	#T
	sw $t3, 112($s4)
	sw $t3, 116($s4)
	sw $t3, 372($s4)
	sw $t3, 628($s4)
	sw $t3, 884($s4)
	sw $t3, 1140($s4)
	sw $t3, 120($s4)
	
	#O
	sw $t3, 128($s4)
	sw $t3, 384($s4)
	sw $t3, 392($s4)
	sw $t3, 640($s4)
	sw $t3, 648($s4)
	sw $t3, 896($s4)
	sw $t3, 904($s4)
	sw $t3, 1152($s4)
	sw $t3, 1156($s4)
	sw $t3, 1160($s4)
	sw $t3, 132($s4)
	sw $t3, 136($s4)

	#START SYMBOL
	sw $t2, 152($s4)
	sw $t2, 408($s4)
	sw $t2, 412($s4)
	sw $t2, 664($s4)
	sw $t2, 668($s4)
	sw $t2, 672($s4)
	sw $t2, 920($s4)
	sw $t2, 924($s4)
	sw $t2, 1176($s4)
	
	#Q
	sw $t2, 1880($s4)
	sw $t2, 2136($s4)
	sw $t2, 2392($s4)
	sw $t2, 2396($s4)
	sw $t2, 2400($s4)
	sw $t2, 1884($s4)
	sw $t2, 1888($s4)
	sw $t2, 2144($s4)
	sw $t2, 2400($s4)
	sw $t2, 2656($s4)
	sw $t2, 2912($s4)
	sw $t2, 2916($s4)
	
	#T
	sw $t3, 1904($s4)
	sw $t3, 1908($s4)
	sw $t3, 2164($s4)
	sw $t3, 2420($s4)
	sw $t3, 2676($s4)
	sw $t3, 2932($s4)
	sw $t3, 1912($s4)
	#O
	sw $t3, 1920($s4)
	sw $t3, 2176($s4)
	sw $t3, 2184($s4)
	sw $t3, 2432($s4)
	sw $t3, 2440($s4)
	sw $t3, 2688($s4)
	sw $t3, 2696($s4)
	sw $t3, 2944($s4)
	sw $t3, 2948($s4)
	sw $t3, 2952($s4)
	sw $t3, 1924($s4)
	sw $t3, 1928($s4)
	
	#Q
	sw $t2, 1944($s4)
	sw $t2, 2208($s4)
	sw $t2, 2200($s4)
	sw $t2, 2464($s4)
	sw $t2, 2460($s4)
	sw $t2, 2456($s4)
	sw $t2, 2720($s4)
	sw $t2, 2976($s4)
	sw $t2, 2980($s4)
	sw $t2, 1948($s4)
	sw $t2, 1952($s4)
	#U
	sw $t2, 1964($s4)
	sw $t2, 1972($s4)
	sw $t2, 2220($s4)
	sw $t2, 2228($s4)
	sw $t2, 2476($s4)
	sw $t2, 2484($s4)
	sw $t2, 2732($s4)
	sw $t2, 2740($s4)
	sw $t2, 2988($s4)
	sw $t2, 2992($s4)
	sw $t2, 2996($s4)
	#I
	sw $t2, 1980($s4)
	sw $t2, 2236($s4)
	sw $t2, 2492($s4)
	sw $t2, 2748($s4)
	sw $t2, 3004($s4)
	#T
	sw $t2, 1988($s4)
	sw $t2, 1992($s4)
	sw $t2, 1996($s4)
	sw $t2, 2248($s4)
	sw $t2, 2504($s4)
	sw $t2, 2760($s4)
	sw $t2, 3016($s4)
	jr $ra

CLEAR_SCREEN:
	sw $t4, 0($s1)
	addi $s1, $s1, 4
	addi $s7, $s7, 1
	blt $s7, 16834, CLEAR_SCREEN
	jr $ra

SUCCESS:
	li $s4, SUCCESS_ZERO
	#S
	sw $t2, 0($s4)
	sw $t2, 256($s4)
	sw $t2, 512($s4)
	sw $t2, 772($s4)
	sw $t2, 776($s4)
	sw $t2, 780($s4)
	sw $t2, 1036($s4)
	sw $t2, 1292($s4)
	sw $t2, 1548($s4)
	sw $t2, 1544($s4)
	sw $t2, 1540($s4)
	sw $t2, 1536($s4)
	sw $t2, 4($s4)
	sw $t2, 8($s4)
	sw $t2, 12($s4)
	#U
	sw $t3, 1556($s4)
	sw $t3, 20($s4)
	sw $t3, 32($s4)
	sw $t3, 276($s4)
	sw $t3, 288($s4)
	sw $t3, 532($s4)
	sw $t3, 544($s4)
	sw $t3, 788($s4)
	sw $t3, 800($s4)
	sw $t3, 1044($s4)
	sw $t3, 1056($s4)
	sw $t3, 1300($s4)
	sw $t3, 1312($s4)
	sw $t3, 1560($s4)
	sw $t3, 1564($s4)
	sw $t3, 1568($s4)
	#C
	sw $t2, 40($s4)
	sw $t2, 296($s4)
	sw $t2, 308($s4)
	sw $t2, 552($s4)
	sw $t2, 808($s4)
	sw $t2, 1064($s4)
	sw $t2, 1320($s4)
	sw $t2, 1332($s4)
	sw $t2, 44($s4)
	sw $t2, 48($s4)
	sw $t2, 52($s4)
	sw $t2, 1576($s4)
	sw $t2, 1580($s4)
	sw $t2, 1584($s4)
	sw $t2, 1588($s4)
	#C
	sw $t3, 60($s4)
	sw $t3, 316($s4)
	sw $t3, 328($s4)
	sw $t3, 572($s4)
	sw $t3, 828($s4)
	sw $t3, 1084($s4)
	sw $t3, 1340($s4)
	sw $t3, 1352($s4)
	sw $t3, 64($s4)
	sw $t3, 68($s4)
	sw $t3, 72($s4)
	sw $t3, 1596($s4)
	sw $t3, 1600($s4)
	sw $t3, 1604($s4)
	sw $t3, 1608($s4)
	#E
	sw $t2, 80($s4)
	sw $t2, 336($s4)
	sw $t2, 592($s4)
	sw $t2, 848($s4)
	sw $t2, 852($s4)
	sw $t2, 856($s4)
	sw $t2, 860($s4)
	sw $t2, 1104($s4)
	sw $t2, 1360($s4)
	sw $t2, 84($s4)
	sw $t2, 88($s4)
	sw $t2, 92($s4)
	sw $t2, 1616($s4)
	sw $t2, 1620($s4)
	sw $t2, 1624($s4)
	sw $t2, 1628($s4)
	#S
	sw $t3, 100($s4)
	sw $t3, 356($s4)
	sw $t3, 612($s4)
	sw $t3, 872($s4)
	sw $t3, 876($s4)
	sw $t3, 880($s4)
	sw $t3, 1136($s4)
	sw $t3, 1392($s4)
	sw $t3, 104($s4)
	sw $t3, 108($s4)
	sw $t3, 112($s4)
	sw $t3, 1636($s4)
	sw $t3, 1640($s4)
	sw $t3, 1644($s4)
	sw $t3, 1648($s4)
	#S
	sw $t2, 120($s4)
	sw $t2, 376($s4)
	sw $t2, 632($s4)
	sw $t2, 892($s4)
	sw $t2, 896($s4)
	sw $t2, 900($s4)
	sw $t2, 1156($s4)
	sw $t2, 1412($s4)
	sw $t2, 124($s4)
	sw $t2, 128($s4)
	sw $t2, 132($s4)
	sw $t2, 1656($s4)
	sw $t2, 1660($s4)
	sw $t2, 1664($s4)
	sw $t2, 1668($s4)
	#!
	sw $t3, 144($s4)
	sw $t3, 400($s4)
	sw $t3, 656($s4)
	sw $t3, 912($s4)
	sw $t3, 1168($s4)
	sw $t3, 1680($s4)
	j END

FAIL:
	li $v0, 32
	li $a0, 70
	syscall 
	
	li $s1, BASE_ADDRESS #temp var to store address
	li $s7, 0 #temp index
	jal CLEAR_SCREEN
	li $s4, FAIL_ZERO
	#G
	sw $t3, 0($s4)
	sw $t3, 256($s4)
	sw $t3, 512($s4)
	sw $t3, 768($s4)
	sw $t3, 1024($s4)
	sw $t3, 1032($s4)
	sw $t3, 1036($s4)
	sw $t3, 1280($s4)
	sw $t3, 1292($s4)
	sw $t3, 1536($s4)
	sw $t3, 1540($s4)
	sw $t3, 1544($s4)
	sw $t3, 1548($s4)
	sw $t3, 4($s4)
	sw $t3, 8($s4)
	sw $t3, 12($s4)
	#A
	sw $t3, 20($s4)
	sw $t3, 24($s4)
	sw $t3, 28($s4)
	sw $t3, 32($s4)
	sw $t3, 276($s4)
	sw $t3, 288($s4)
	sw $t3, 532($s4)
	sw $t3, 544($s4)
	sw $t3, 788($s4)
	sw $t3, 800($s4)
	sw $t3, 1044($s4)
	sw $t3, 1048($s4)
	sw $t3, 1052($s4)
	sw $t3, 1056($s4)
	sw $t3, 1300($s4)
	sw $t3, 1312($s4)
	sw $t3, 1556($s4)
	sw $t3, 1568($s4)
	sw $t3, 4($s4)
	sw $t3, 8($s4)
	sw $t3, 12($s4)
	#M
	sw $t3, 40($s4)
	sw $t3, 44($s4)
	sw $t3, 48($s4)
	sw $t3, 52($s4)
	sw $t3, 56($s4)
	sw $t3, 296($s4)
	sw $t3, 304($s4)
	sw $t3, 312($s4)
	sw $t3, 552($s4)
	sw $t3, 560($s4)
	sw $t3, 568($s4)
	sw $t3, 808($s4)
	sw $t3, 816($s4)
	sw $t3, 824($s4)
	sw $t3, 1064($s4)
	sw $t3, 1080($s4)
	sw $t3, 1320($s4)
	sw $t3, 1336($s4)
	sw $t3, 1576($s4)
	sw $t3, 1592($s4)
	#E
	sw $t3, 64($s4)
	sw $t3, 320($s4)
	sw $t3, 576($s4)
	sw $t3, 832($s4)
	sw $t3, 836($s4)
	sw $t3, 840($s4)
	sw $t3, 844($s4)
	sw $t3, 1088($s4)
	sw $t3, 1344($s4)
	sw $t3, 64($s4)
	sw $t3, 68($s4)
	sw $t3, 72($s4)
	sw $t3, 76($s4)
	sw $t3, 1600($s4)
	sw $t3, 1604($s4)
	sw $t3, 1608($s4)
	sw $t3, 1612($s4)
	#O
	sw $t3, 92($s4)
	sw $t3, 96($s4)
	sw $t3, 100($s4)
	sw $t3, 104($s4)
	sw $t3, 348($s4)
	sw $t3, 360($s4)
	sw $t3, 604($s4)
	sw $t3, 616($s4)
	sw $t3, 860($s4)
	sw $t3, 872($s4)
	sw $t3, 1116($s4)
	sw $t3, 1128($s4)
	sw $t3, 1372($s4)
	sw $t3, 1384($s4)
	sw $t3, 1628($s4)
	sw $t3, 1632($s4)
	sw $t3, 1636($s4)
	sw $t3, 1640($s4)
	#V
	sw $t3, 112($s4)
	sw $t3, 124($s4)
	sw $t3, 368($s4)
	sw $t3, 380($s4)
	sw $t3, 624($s4)
	sw $t3, 636($s4)
	sw $t3, 880($s4)
	sw $t3, 892($s4)
	sw $t3, 1136($s4)
	sw $t3, 1148($s4)
	sw $t3, 1396($s4)
	sw $t3, 1400($s4)
	sw $t3, 1652($s4)
	sw $t3, 1656($s4)
	#E
	sw $t3, 132($s4)
	sw $t3, 388($s4)
	sw $t3, 644($s4)
	sw $t3, 900($s4)
	sw $t3, 904($s4)
	sw $t3, 908($s4)
	sw $t3, 912($s4)
	sw $t3, 1156($s4)
	sw $t3, 1412($s4)
	sw $t3, 132($s4)
	sw $t3, 136($s4)
	sw $t3, 140($s4)
	sw $t3, 144($s4)
	sw $t3, 1668($s4)
	sw $t3, 1672($s4)
	sw $t3, 1676($s4)
	sw $t3, 1680($s4)
	#R
	sw $t3, 152($s4)
	sw $t3, 408($s4)
	sw $t3, 420($s4)
	sw $t3, 664($s4)
	sw $t3, 676($s4)
	sw $t3, 920($s4)
	sw $t3, 924($s4)
	sw $t3, 928($s4)
	sw $t3, 932($s4)
	sw $t3, 1176($s4)
	sw $t3, 1180($s4)
	sw $t3, 1432($s4)
	sw $t3, 1440($s4)
	sw $t3, 152($s4)
	sw $t3, 156($s4)
	sw $t3, 160($s4)
	sw $t3, 164($s4)
	sw $t3, 1688($s4)
	sw $t3, 1700($s4)
	j END
	
END: 	
	li $v0, 10
	syscall

LOAD_LEVEL:
	li $t0, BASE_ADDRESS
	li $s1, 0 # temp index for drawing border
	li $s6, LIVES_ZERO
	jal DRAW_FINISH
	jal DRAW_LIVES
	jal DRAW_OBSTACLE
	jal DRAW_LEVEL
    	jal DRAW_BORDER
    	jal DRAW_PLAYER
    	li $s6, LIVES_ZERO
	j MAIN_LOOP
		
	
MAIN_LOOP:
	# RESPONSBILITIES:
	## - CHECK FOR KEYBOARD INPUT (for movement, keys to restart or pause)
	## - CHECK IF PLAYER IS STANDING ON PLATFORM
	## - UPDATE PLAYER LOCATION, ENEMIES, PLATFORMS, ETC.
	## - CHECK FOR COLLISIONS
	## - UPDATE OTHER GAME STATE AND END OF GAME
	## - ERASE OBJECTS FROM THE OLD POSITION ON THE SCREEN
	## - REDRAW OBJECTS IN THE NEW POSITION ON THE SCREEN
	# NOTE: at end of loop, MAIN_LOOP should sleep and go back to step 1
	
	li $t0, BASE_ADDRESS # reset $t0 to base address
	
	lw $s1, 992($t0)
	beq $s1, $t4, FAIL
	li $s1, 0 # temp index for drawing border
	addi $sp, $sp, 4
	sw $ra, ($sp)
	jal DRAW_BORDER
	li $t0, BASE_ADDRESS # reset $t0 to base address
	jal DRAW_FINISH
	jal DRAW_LEVEL
	lw $ra, ($sp)
	addi $sp, $sp, -4
	
	li $s1, 0xffff0000
	lw $s1, 0($s1)
	beq $s1, 1, keypress_loop
	
	j MOVE_OBSTACLE
	
	j MAIN_LOOP
	
CHECK_GRAVITY:
	addi $s3, $s3, 1
	lw $s1, 1280($s0) #check if platform is below player
	beq $s1, $t3, MAIN_LOOP # if reach platform, go back to 
	beq $s3, 35, DEDUCT_LIFE # after 50 iterations of not being reaching a platform, end game
	
	jal CLEAR_PLAYER
	addi $s0, $s0, 256
	jal DRAW_PLAYER
	jal DRAW_LEVEL
	
	li $v0, 32
	li $a0, 50
	syscall 
	
	j CHECK_GRAVITY

DEDUCT_LIFE:
	jal LOSE_LIFE
	addi $s6, $s6, 36
	jal CLEAR_PLAYER
	li $s0, PLAYER_ZERO
	j MAIN_LOOP
	

keypress_loop:
	lw $s1, 0xffff0004
	beq $s1, 0x64, D_PRESSED
	beq $s1, 0x77, W_PRESSED
	beq $s1, 0x61, A_PRESSED
	beq $s1, 0x73, S_PRESSED
	beq $s1, 0x70, P_PRESSED
	
	# FIX THISSS !! do nothing if not accepted key presses were pressed
	bne $s1, 0x64, LOAD_LEVEL
	bne $s1, 0x77, LOAD_LEVEL
	bne $s1, 0x61, LOAD_LEVEL
	bne $s1, 0x73, LOAD_LEVEL
	bne $s1, 0x70, LOAD_LEVEL
	j MAIN_LOOP

Q_PRESSED:
	li $s1, BASE_ADDRESS #temp var to store address
	li $s7, 0 #temp index
	jal CLEAR_SCREEN
	j END
	
R_PRESSED:
	li $s1, BASE_ADDRESS #temp var to store address
	li $s7, 0 #temp index
	li $s0, PLAYER_ZERO
	jal CLEAR_SCREEN
	j LOAD_LEVEL
	
P_PRESSED:
	jal CLEAR_PLAYER
	li $s0, PLAYER_ZERO
	j LOAD_LEVEL

LOSE_LIFE:
	sw $t4, 0($s6)
	sw $t4, 4($s6)
	sw $t4, 12($s6)
	sw $t4, 16($s6)
	sw $t4, 252($s6)
	sw $t4, 256($s6)
	sw $t4, 260($s6)
	sw $t4, 264($s6)
	sw $t4, 268($s6)
	sw $t4, 272($s6)
	sw $t4, 276($s6)
	sw $t4, 512($s6)
	sw $t4, 516($s6)
	sw $t4, 520($s6)
	sw $t4, 524($s6)
	sw $t4, 528($s6)
	sw $t4, 772($s6)
	sw $t4, 776($s6)
	sw $t4, 780($s6)
	sw $t4, 1032($s6)
	jr $ra
	
DRAW_LIFE:
	sw $t5, 0($s6)
	sw $t5, 4($s6)
	sw $t5, 12($s6)
	sw $t5, 16($s6)
	sw $t5, 252($s6)
	sw $t5, 256($s6)
	sw $t5, 260($s6)
	sw $t5, 264($s6)
	sw $t5, 268($s6)
	sw $t5, 272($s6)
	sw $t5, 276($s6)
	sw $t5, 512($s6)
	sw $t5, 516($s6)
	sw $t5, 520($s6)
	sw $t5, 524($s6)
	sw $t5, 528($s6)
	sw $t5, 772($s6)
	sw $t5, 776($s6)
	sw $t5, 780($s6)
	sw $t5, 1032($s6)
	jr $ra
	
DRAW_LIVES:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal DRAW_LIFE
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	addi $s6, $s6, 36
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal DRAW_LIFE
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	addi $s6, $s6, 36
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal DRAW_LIFE
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
GO_UP_R: 
	addi $t6, $t6, 1
	jal CLEAR_PLAYER
	addi $s0, $s0, -252
	jal DRAW_PLAYER
	
	li $v0, 32
	li $a0, 50
	syscall 
	
	bne $t6, 7, GO_UP_R
	j GO_DOWN_R
	
GO_DOWN_R:
	lw $s1, 8($s0) # CHECK RIGHT OF PLAYER
	beq $s1, $t3, MAIN_LOOP
	beq $s1, $s2, RECOIL
	lw $s1, 264($s0) # CHECK RIGHT OF PLAYER
	beq $s1, $t3, MAIN_LOOP
	beq $s1, $t1, SUCCESS
	beq $s1, $s2, RECOIL
	
	addi $t6, $t6, -1
	jal CLEAR_PLAYER
	addi $s0, $s0, 260
	jal DRAW_PLAYER
	
	li $v0, 32
	li $a0, 50
	syscall 
	
	lw $s1, 1280($s0) # CHECK BOUNDS TO THE BOTTOM OF PLAYER
	beq $s1, $t3, MAIN_LOOP
	
	bne $t6, 0, GO_DOWN_R
	j MAIN_LOOP
	
GO_UP_L: 
	lw $s1, -4($s0) # CHECK BOUNDS TO THE LEFT OF PLAYER
	beq $s1, $t3, MAIN_LOOP
	lw $s1, -256($s0) # CHECK BOUNDS TO THE TOP OF PLAYER
	beq $s1, $t3, MAIN_LOOP
	lw $s1, 252($s0) # CHECK LEFT OF PLAYER
	beq $s1, $t3, MAIN_LOOP
	beq $s1, $t5, GAIN_LIFE
	beq $s1, $t1, SUCCESS
	beq $s1, $s2, RECOIL
	lw $s1, 508($s0) # CHECK LEFT OF PLAYER
	beq $s1, $t3, MAIN_LOOP
	beq $s1, $t5, GAIN_LIFE
	beq $s1, $t1, SUCCESS
	beq $s1, $s2, RECOIL
	lw $s1, 1020($s0) # CHECK LEFT OF PLAYER
	beq $s1, $t3, MAIN_LOOP
	beq $s1, $t5, GAIN_LIFE
	beq $s1, $t1, SUCCESS
	beq $s1, $s2, RECOIL
	
	addi $t6, $t6, 1
	jal CLEAR_PLAYER
	addi $s0, $s0, -260
	jal DRAW_PLAYER_MIRRORED
	
	li $v0, 32
	li $a0, 50
	syscall 
	
	bne $t6, 7, GO_UP_L
	j GO_DOWN_L
	
GO_DOWN_L:
	lw $s1, 252($s0) # CHECK LEFT OF PLAYER
	beq $s1, $t3, MAIN_LOOP
	beq $s1, $t5, GAIN_LIFE
	beq $s1, $t1, SUCCESS
	lw $s1, 508($s0) # CHECK LEFT OF PLAYER
	beq $s1, $t3, MAIN_LOOP
	beq $s1, $t5, GAIN_LIFE
	beq $s1, $t1, SUCCESS
	lw $s1, 1020($s0) # CHECK LEFT OF PLAYER
	beq $s1, $t3, MAIN_LOOP
	beq $s1, $t5, GAIN_LIFE
	beq $s1, $t1, SUCCESS
	lw $s1, 1280($s0) # CHECK BOUNDS TO THE BOTTOM OF PLAYER
	beq $s1, $t3, MAIN_LOOP
	
	addi $t6, $t6, -1
	jal CLEAR_PLAYER
	addi $s0, $s0, 252
	jal DRAW_PLAYER_MIRRORED
	li $v0, 32
	li $a0, 50
	syscall 
	
	bne $t6, 0, GO_DOWN_L
	j MAIN_LOOP
	
JUMP_RIGHT:
	j GO_UP_R
	#j GO_DOWN_R

JUMP_LEFT:
	j GO_UP_L
	#j GO_DOWN_L
	
W_PRESSED:
	li $t6, 0
	# MOVE 6 PIXELS UP AND THEN FALL DOWN
	beq $t7, 0, JUMP_RIGHT
	j JUMP_LEFT
	
GAIN_LIFE:
	li $t8, 1 #PLAYER HAS GAINED LIFE
	addi $sp, $sp, -4
	sw $ra, ($sp)
	li $t0, BASE_ADDRESS
	jal CLEAR_PICKUP
	lw $s1, LIVES_ZERO
	beq $s1, $t5, MAIN_LOOP
	addi $s6, $s6, -36
	jal DRAW_LIFE
	lw $ra, ($sp)
	addi $sp, $sp, 4
	j MAIN_LOOP

A_PRESSED:
	lw $s1, -8($s0) # CHECK LEFT OF PLAYER
	beq $s1, $t3, MAIN_LOOP
	beq $s1, $t5, GAIN_LIFE
	beq $s1, $t1, SUCCESS
	beq $s1, $s2, RECOIL_RIGHT
	# MOVE ONE PIXEL TO THE LEFT
	li $t7, 1 # $t7 holds state of whether a was pressed (1 = a was pressed)
	jal CLEAR_PLAYER
	addi $s0, $s0, -4
	jal DRAW_PLAYER_MIRRORED
	j MAIN_LOOP
	
S_PRESSED:
	# PLAYER SCRUNCHES
	jal CLEAR_PLAYER
	beq $t7, 1, SCRUNCH_LEFT
	jal DRAW_PLAYER_SCRUNCH
	j MAIN_LOOP

SCRUNCH_LEFT:
	jal DRAW_PLAYER_SCRUNCH_MIRRORED
	j MAIN_LOOP
	
RECOIL:
	li $t6, 4
	#li $s6, LIVES_ZERO
	addi $sp, $sp, -4
	sw $ra, ($sp)
	jal LOSE_LIFE
	lw $ra, ($sp)
	addi $sp, $sp, 4
	addi $s6, $s6, 36
	j GO_UP_L
	
RECOIL_RIGHT:
	li $t6, 4
	#li $s6, LIVES_ZERO
	addi $sp, $sp, -4
	sw $ra, ($sp)
	jal LOSE_LIFE
	lw $ra, ($sp)
	addi $sp, $sp, 4
	addi $s6, $s6, 36
	j GO_UP_R

D_PRESSED:
	lw $s1, 8($s0) # CHECK RIGHT OF PLAYER
	beq $s1, $t3, MAIN_LOOP
	beq $s1, $s2, RECOIL
	# MOVE ONE PIXEL TO THE RIGHT
	li $t7, 0 # $t7 holds state of whether d was pressed (0 = d was pressed)
	jal CLEAR_PLAYER
	addi $s0, $s0, 4
	jal DRAW_PLAYER
	j MAIN_LOOP

DRAW_LEVEL:
	## NOTE: ONLY 63 ROWS (MAX FROM $t0 is 16384)
	## NOTE: each row is 256 bits
	
	# FIRST PLATFORM (50th row on GRID)
	sw $t3, 12800($t0)
	sw $t3, 12804($t0)
	sw $t3, 12808($t0)
	sw $t3, 12812($t0)
	sw $t3, 12816($t0)
	sw $t3, 12820($t0)
	sw $t3, 12824($t0)
	sw $t3, 12828($t0)
	sw $t3, 12832($t0)
	sw $t3, 12836($t0)
	sw $t3, 12840($t0)
	sw $t3, 12844($t0)
	sw $t3, 12848($t0)
	sw $t3, 12852($t0)
	sw $t3, 12856($t0)
	sw $t3, 12860($t0)
	sw $t3, 12864($t0)
	sw $t3, 12868($t0)
	sw $t3, 12872($t0)
	
	# STEP 1 (MOVING PLATFORM 1)
	sw $t3, 2980($t9)
	sw $t3, 2984($t9)
	sw $t3, 2988($t9)
	sw $t3, 2992($t9)
	sw $t3, 2996($t9)
	sw $t3, 3000($t9)
	sw $t3, 3004($t9)
	sw $t3, 3008($t9)
	sw $t3, 3012($t9)
	sw $t3, 3016($t9)
	sw $t3, 3020($t9)
	sw $t3, 3024($t9)
	sw $t3, 3028($t9)
	

	#SECOND PLATFORM (40th row)
	sw $t3, 10400($t0)
	sw $t3, 10404($t0)
	sw $t3, 10408($t0)
	sw $t3, 10412($t0)
	sw $t3, 10416($t0)
	sw $t3, 10420($t0)
	sw $t3, 10424($t0)
	sw $t3, 10428($t0)
	sw $t3, 10432($t0)
	sw $t3, 10436($t0)
	sw $t3, 10440($t0)
	sw $t3, 10444($t0)
	sw $t3, 10448($t0)
	sw $t3, 10452($t0)
	sw $t3, 10456($t0)
	sw $t3, 10460($t0)
	sw $t3, 10464($t0)
	sw $t3, 10468($t0)
	sw $t3, 10472($t0)
	sw $t3, 10476($t0)
	sw $t3, 10480($t0)
	sw $t3, 10484($t0)
	sw $t3, 10488($t0)
	sw $t3, 10492($t0)

	#STEP 2 (MOVING PLATFORM 2)
	sw $t3, 132($t9)
	sw $t3, 136($t9)
	sw $t3, 140($t9)
	sw $t3, 144($t9)
	sw $t3, 148($t9)
	sw $t3, 152($t9)
	sw $t3, 156($t9)
	sw $t3, 160($t9)
	sw $t3, 164($t9)
	sw $t3, 168($t9)
	sw $t3, 172($t9)
	sw $t3, 176($t9)
	
	# THIRD PLATFORM (30th row on GRID)
	sw $t3, 7680($t0)
	sw $t3, 7684($t0)
	sw $t3, 7688($t0)
	sw $t3, 7692($t0)
	sw $t3, 7696($t0)
	sw $t3, 7700($t0)
	sw $t3, 7704($t0)
	sw $t3, 7708($t0)
	sw $t3, 7712($t0)
	sw $t3, 7716($t0)
	sw $t3, 7720($t0)
	sw $t3, 7724($t0)
	sw $t3, 7728($t0)
	jr $ra 

DRAW_LEFT_BORDER:
	sw $t3, 0($t0)
	addi $t0, $t0, 256
	addi $s1, $s1, 1
	bne $s1, 255, DRAW_LEFT_BORDER
	jr $ra

DRAW_RIGHT_BORDER:
	sw $t3, 252($t0)
	addi $t0, $t0, 256
	addi $s1, $s1, 1
	bne $s1, 255, DRAW_RIGHT_BORDER
	jr $ra

DRAW_BORDER:
	addi $sp, $sp, -4   # adjust the stack pointer to allocate space for the return address
    	sw $ra, ($sp)       # store the return address on the stack

    	jal DRAW_LEFT_BORDER     
    	
	li $s1, 0
	li $t0, BASE_ADDRESS
	
    	jal DRAW_RIGHT_BORDER    

    	lw $ra, ($sp)       # restore the return address
    	addi $sp, $sp, 4    # adjust the stack pointer to free the space for the return address

	jr $ra
	
DRAW_PLAYER_MIRRORED:
	sw $t2, 4($s0)
	sw $t3, 0($s0) #EYE
	sw $t2, 256($s0)
	sw $t2, 260($s0)
	sw $t2, 512($s0)
	sw $t2, 768($s0)
	sw $t2, 1028($s0) #TAIL
	sw $t2, 1024($s0)
	jr $ra
	
DRAW_PLAYER:
	sw $t2, 0($s0)
	sw $t3, 4($s0) #EYE
	sw $t2, 256($s0)
	sw $t2, 260($s0)
	sw $t2, 512($s0)
	sw $t2, 768($s0)
	sw $t2, 1020($s0) #TAIL
	sw $t2, 1024($s0)
	jr $ra
	
DRAW_PLAYER_SCRUNCH:
	sw $t3, 260($s0) #EYE
	sw $t2, 256($s0)
	sw $t2, 512($s0)
	sw $t2, 516($s0)
	sw $t2, 768($s0)
	sw $t2, 1020($s0) #TAIL
	sw $t2, 1024($s0)
	jr $ra
	
DRAW_PLAYER_SCRUNCH_MIRRORED:
	sw $t3, 256($s0) #EYE
	sw $t2, 260($s0)
	sw $t2, 512($s0)
	sw $t2, 516($s0)
	sw $t2, 768($s0)
	sw $t2, 1028($s0) #TAIL
	sw $t2, 1024($s0)
	jr $ra
	
CLEAR_PLAYER:
	sw $t4, 0($s0)
	sw $t4, 4($s0)
	sw $t4, 256($s0)
	sw $t4, 260($s0)
	sw $t4, 512($s0)
	sw $t4, 516($s0)
	sw $t4, 768($s0)
	sw $t4, 772($s0)
	sw $t4, 1020($s0)
	sw $t4, 1028($s0)
	sw $t4, 1024($s0)
	jr $ra
	
DRAW_PICKUP:
	sw $t5, -360($t9)
	sw $t5, -620($t9)
	sw $t5, -616($t9)
	sw $t5, -612($t9)
	sw $t5, -864($t9)
	sw $t5, -868($t9)
	sw $t5, -872($t9)
	sw $t5, -876($t9)
	sw $t5, -880($t9)
	sw $t5, -1116($t9)
	sw $t5, -1120($t9)
	sw $t5, -1124($t9)
	sw $t5, -1128($t9)
	sw $t5, -1132($t9)
	sw $t5, -1136($t9)
	sw $t5, -1140($t9)
	sw $t5, -1376($t9)
	sw $t5, -1380($t9)
	sw $t5, -1388($t9)
	sw $t5, -1392($t9)
	jr $ra 
	
	
CLEAR_PICKUP:
	sw $t4, -360($t9)
	sw $t4, -612($t9)
	sw $t4, -616($t9)
	sw $t4, -620($t9)
	sw $t4, -864($t9)
	sw $t4, -868($t9)
	sw $t4, -872($t9)
	sw $t4, -876($t9)
	sw $t4, -880($t9)
	sw $t4, -1116($t9)
	sw $t4, -1120($t9)
	sw $t4, -1124($t9)
	sw $t4, -1128($t9)
	sw $t4, -1132($t9)
	sw $t4, -1136($t9)
	sw $t4, -1140($t9)
	sw $t4, -1376($t9)
	sw $t4, -1380($t9)
	sw $t4, -1388($t9)
	sw $t4, -1392($t9)
	jr $ra

CLEAR_STEP:
	# MOVING STEP 1
	sw $t4, 2980($t9)
	sw $t4, 2984($t9)
	sw $t4, 2988($t9)
	sw $t4, 2992($t9)
	sw $t4, 2996($t9)
	sw $t4, 3000($t9)
	sw $t4, 3004($t9)
	sw $t4, 3008($t9)
	sw $t4, 3012($t9)
	sw $t4, 3016($t9)
	sw $t4, 3020($t9)
	sw $t4, 3024($t9)
	sw $t4, 3028($t9)
	
	# MOVING STEP 2
	sw $t4, 132($t9)
	sw $t4, 136($t9)
	sw $t4, 140($t9)
	sw $t4, 144($t9)
	sw $t4, 148($t9)
	sw $t4, 152($t9)
	sw $t4, 156($t9)
	sw $t4, 160($t9)
	sw $t4, 164($t9)
	sw $t4, 168($t9)
	sw $t4, 172($t9)
	sw $t4, 176($t9)
	jr $ra
	
CLEAR_OBSTACLE:
	sw $t4, 0($t9) # EYES
	sw $t4, 4($t9) 
	sw $t4, 256($t9) 
	sw $t4, 260($t9)
	sw $t4, 516($t9)
	sw $t4, 772($t9)
	sw $t4, 1028($t9)
	sw $t4, 1272($t9)
	sw $t4, 1276($t9)
	sw $t4, 1280($t9)
	sw $t4, 1284($t9)
	sw $t4, 1288($t9)
	sw $t4, 1292($t9)
	sw $t4, 1296($t9)
	jr $ra

OBSTACLE_LEFT:
	addi $s5, $s5, -1
	lw $s1, 8($s0)
	beq $s1, $s2, RECOIL
	
	addi $sp, $sp, -4
	sw $ra, ($sp)
	jal CLEAR_OBSTACLE
	jal CLEAR_STEP
	addi $t9, $t9, -4
	jal DRAW_OBSTACLE
	jal DRAW_LEVEL
	lw $ra, ($sp)
	addi $sp, $sp, 4
	bne $t8, 1, LOAD_PICKUP_LEFT
	beq $t8, 1, OBSTACLE_2
	
OBSTACLE_2:
	beq $s5, -12, UPDATE_OBSTACLE
	
	li $v0, 32
	li $a0, 120
	syscall 
	
	li $s3, 0
	j CHECK_GRAVITY

	j MAIN_LOOP

LOAD_PICKUP_LEFT:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	addi $t9, $t9, 4
	jal CLEAR_PICKUP
	addi $t9, $t9, -4
	jal DRAW_PICKUP
	lw $ra, ($sp)
	addi $sp, $sp, 4
	j OBSTACLE_2
	
LOAD_PICKUP_RIGHT:
	addi $sp, $sp, -4
	sw $ra, ($sp)
	addi $t9, $t9, -4
	jal CLEAR_PICKUP
	addi $t9, $t9, 4
	jal DRAW_PICKUP
	lw $ra, ($sp)
	addi $sp, $sp, 4
	j OBSTACLE_2
	
UPDATE_OBSTACLE:
	li $s5, 12
	j MAIN_LOOP

OBSTACLE_RIGHT:
	addi $s5, $s5, -1
	lw $s1, 8($s0)
	beq $s1, $s2, RECOIL
	
	addi $sp, $sp, -4
	sw $ra, ($sp)
	jal CLEAR_OBSTACLE
	jal CLEAR_STEP
	addi $t9, $t9, 4
	jal DRAW_OBSTACLE_MIRRORED
	jal DRAW_LEVEL
	lw $ra, ($sp)
	addi $sp, $sp, 4
	bne $t8, 1, LOAD_PICKUP_RIGHT
	beq $t8, 1, OBSTACLE_2

MOVE_OBSTACLE:
	lw $s1, -4($s0) # CHECK LEFT OF PLAYER
	beq $s1, $t5, GAIN_LIFE
	lw $s1, 252($s0) # CHECK LEFT OF PLAYER
	beq $s1, $t5, GAIN_LIFE
	bgt $s5, 0, OBSTACLE_LEFT
	ble $s5, 0, OBSTACLE_RIGHT
	j MAIN_LOOP

DRAW_OBSTACLE:
	sw $t3, 0($t9) # EYES
	sw $s2, 4($t9) 
	sw $s2, 256($t9) 
	sw $s2, 260($t9)
	sw $s2, 516($t9)
	sw $s2, 772($t9)
	sw $s2, 1028($t9)
	sw $s2, 1284($t9)
	sw $s2, 1288($t9)
	sw $s2, 1292($t9)
	sw $s2, 1296($t9)
	jr $ra
	
DRAW_OBSTACLE_MIRRORED:
	sw $s2, 0($t9) 
	sw $t3, 4($t9) # EYES
	sw $s2, 256($t9) 
	sw $s2, 260($t9)
	sw $s2, 516($t9)
	sw $s2, 772($t9)
	sw $s2, 1028($t9)
	sw $s2, 1272($t9)
	sw $s2, 1276($t9)
	sw $s2, 1280($t9)
	sw $s2, 1284($t9)
	jr $ra
	
DRAW_FINISH:
	sw $t1, 6408($t0)
	sw $t3, 6412($t0)
	sw $t3, 6416($t0)
	sw $t3, 6420($t0)
	sw $t3, 6424($t0)
	
	sw $t1, 6428($t0)
	sw $t1, 6684($t0)
	
	sw $t3, 6680($t0)
	sw $t3, 6676($t0)
	sw $t3, 6672($t0)
	sw $t3, 6668($t0)
	
	sw $t1, 6664($t0)
	sw $t1, 6936($t0)
	
	sw $t3, 6932($t0)
	sw $t3, 6928($t0)
	
	sw $t1, 6924($t0)
	sw $t1, 7188($t0)
	sw $t1, 7184($t0)
	sw $t1, 6152($t0)
	
	sw $t3, 6156($t0)
	sw $t3, 6160($t0)
	sw $t3, 6164($t0)
	sw $t3, 6168($t0)
	sw $t1, 6172($t0)
	
	sw $t1, 5896($t0)
	
	sw $t1, 5388($t0)
	sw $t3, 5392($t0)
	sw $t1, 5136($t0)
	sw $t1, 5140($t0)
	sw $t3, 5396($t0)
	sw $t1, 5400($t0)
	
	sw $t1, 5640($t0)
	sw $t3, 5644($t0)
	sw $t3, 5648($t0)
	sw $t3, 5652($t0)
	sw $t3, 5656($t0)
	sw $t1, 5660($t0)
	
	sw $t3, 5900($t0)
	sw $t3, 5904($t0)
	sw $t3, 5908($t0)
	sw $t3, 5912($t0)
	sw $t1, 5916($t0)
	jr $ra
