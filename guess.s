#        
#
#
#Guessing problem.
#Write a program which accepts a number, between 0 and 128, from player 1 and then accepts guesses from player 2. 
#If player 2’s guess is above or below player 1's number, print out a message, "too high" or "too low" respectively. 
#
#---------------------------------------------Guessing Program -----------------------------------------------------


.data
nextline: .asciiz "\n" 
pone: .asciiz "\nPlayer 1! Enter the number between 0 and 128\n"
ptwo: .asciiz "\nPlayer 2! Guess the number entered by player 1 between 0-128\n" 
correctline: .asciiz "\nYour guess is correct\n" 
highline: .asciiz "\ntoo high\n"
lowline: .asciiz "\ntoo low\n" 
ivalid: .asciiz "\nInvalid Input or out of range...Please enter again\n"
outrange: .asciiz "\nYour guess entry is out of range or invalid, Guess again\n"
optline: .asciiz "\nEnter 1 to guess again or any other key to exit\n " 
exitline: .asciiz "\nEnd of Guessing Game\n"
.text 
main:

#load boundary values 0 &128
li $t1,128
li $t2,1 # loaded to check for options to exit or guess again

l1: 
#print player one line 
la $a0,pone
li $v0,4 
syscall

#read from player one  
li $v0,5
syscall

#move the read value from $v0 into different register $s0 (s0 register for p1 input)
move $s0,$v0 

#compares the player 1 inputs if they lie in between 0 & 128 ,excludes 0,128 
bge $s0,$t1,ivalid1
blez $s0,ivalid1 
j valid 

#invalid entry loops here
ivalid1:
la $a0,ivalid
li $v0,4 
syscall
j l1 

valid: 

#ask player 2 to guess the number 
l2:
la $a0,ptwo 
li $v0,4 
syscall 

#read from player 2 
li $v0,5
syscall

#s1 register for p2 input 

move $s1,$v0 

#checks if player 2 input is in range 0-128 
bge $s1,$t1,ivalid2
blez $s1,ivalid2  
j valid2

#out of range input loops here
ivalid2:
#print guess is out of range
la $a0,outrange
li $v0,4 
syscall 
j l2 


valid2: 

beq $s1,$s0,correct
blt $s1,$s0,low 
bgt $s1,$s0,high 

correct: 
la $a0,correctline
li $v0,4 
syscall 
j exit

low: 
la $a0,lowline
li $v0,4 
syscall 

#print options to exit or guess again 
la $a0,optline
li $v0,4
syscall 

#read the entry 
li $v0,5
syscall 

#if input is 1 , gives user chance to guess again 
beq $v0,$t2,l2  

j exit

high:
la $a0,highline
li $v0,4 
syscall 
#print options to exit or guess again 
la $a0,optline
li $v0,4
syscall 

#read the entry 
li $v0,5
syscall 

#if input is 1 , gives user chance to guess again 
beq $v0,$t2,l2  
j exit

exit: 
#program termination line
la $a0,exitline
li $v0,4 
syscall 

li $v0,10
syscall
.end 