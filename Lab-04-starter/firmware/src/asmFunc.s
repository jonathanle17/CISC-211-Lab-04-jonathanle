/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
 
/* define and initialize global variables that C can access */

.global balance,transaction,eat_out,stay_in,eat_ice_cream,we_have_a_problem
.type balance,%gnu_unique_object
.type transaction,%gnu_unique_object
.type eat_out,%gnu_unique_object
.type stay_in,%gnu_unique_object
.type eat_ice_cream,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
balance:           .word     0  /* input/output value */
transaction:       .word     0  /* output value */
eat_out:           .word     0  /* output value */
stay_in:           .word     0  /* output value */
eat_ice_cream:     .word     0  /* output value */
we_have_a_problem: .word     0  /* output value */

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: the integer value returned to the C function
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    LDR r1,=balance
    LDR r2,[r1]
    ADD r0,r0,r2
.endif
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/
    mov r5,0 /* register for 0 */
    mov r12,1000 /* register for 1000 */
    
    LDR r3,=eat_out /* reset eat_out to 0 */
    STR r5,[r3]
    
    LDR r6,=stay_in /* reset stay_in to 0 */
    STR r5,[r6]
    
    LDR r7,=eat_ice_cream /* reset eat_ice_cream to 0 */
    STR r5,[r7]
    
    LDR r8,=we_have_a_problem /* reset _we_have_a_problem */
    STR r5,[r8]
    
    LDR r9,=transaction /* copies r0 to transaction */
    LDR r0,[r9]
    
    cmp r12,r0 /* transaction>1000? */
    bmi not_valid /* if yes */ 
    cmn r12,r0 /* transaction<-1000? */
    bmi not_valid /* if yes */
    ADDS r12,r0,r2 /* r12 is tmpBalance if conditions met */
    bvs not_valid /* if overflow */
    b calc_temp 
    
    
not_valid:
    STR r5,[r9] /* transaction 0 */
    mov r5,1 
    STR r5,[r8] /* we_have_a_problem 1 */
    LDR r0,[r1] /* r0 balance */
    b done

calc_temp:
    STR r12,[r1] /* balance=tmpBalance */
    cmn r12,r5
    mov r5,1
    beq eat_ice_cream_1 /* if balance=0 */
    bpl eat_out_1 /* if balance>0 */
    bmi stay_in_1 /* if balance<0 */
    
eat_ice_cream_1:
    STR r5,[r7] /* eat_ice_cream=1 */
    LDR r0,[r1] 
    b done
    
eat_out_1:
    STR r5,[r3] /* eat_out=1 */
    LDR r0,[r1]
    b done
    
stay_in_1:
    STR r5,[r6] /* stay_in */
    LDR r0,[r1]
    b done
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




