	.include "/home/ps_1337/assembly/m328pdef.inc"

SBI DDRD, 7 ; SET PIN 13 as OUPUT WHICH IS OUTPUT F
CBI DDRD, 0 ; DIGITAL PIN 2 AS INPUT WHICH IS INPUT P OR MSB
CBI DDRD, 1 ; DIGITAL PIN 3 AS INPUT WHICH IS INPUT Q
CBI DDRD, 2 ; DIGITAL PIN 4 AS INPUT WHICH IS INPUT R OR LSB

start:
ldi r16,PIND ; R16= 0000 0RQP
BST r16, 0; P grabbed 
BLT r17, 0; P pushed in r17
BST r16, 1; Q grabbed 
BLT r18, 0; Q pushed in r18
BST r16, 2; R grabbed 
BLT r19, 0; R pushed in r19

OR r19,r18;
OR r19,r17 ;
mov r20,r19 ; r20 is first expression
BLT r19, 0; R pushed in r19 again

COM r18
COM r19
OR r19,18
OR r19,r17;
mov r21,r19; second expression in r21
BLT r19, 0; R pushed in r19 again
BST r16, 1; Q grabbed 
BLT r18, 0; Q pushed in r18 again

COM r17
OR r18,r17
OR r18,r19
mov r22,r18 ; third expression stored in r22

BLT r18, 0; Q pushed in r18 again
BST r16, 0; P grabbed 
BLT r17, 0; P pushed in r17

com r17
com r19
or r17,r19
or r17,r18
mov r23,r17 ; fourth expressionin r23

AND r23,r22
AND r23,r21
AND r23,r20

BST r23, 0; result grabbed
ldi r23,0xFF
BLT r23, 0; result pushed in r23
COM r23; for POS 0 gives HIGH
out PORTD, r23

rjmp loop ; runs in a loop 
