.data
fail_t: .asciiz "\nFail!\n"
success_t:.asciiz "\nSuccess! Location: "
enter:.asciiz "\n"
buff: .space 100
.text
.globl main

main:
#ϵͳ���ö����ַ����ʹ���ѯ�ַ�
        la $a0,buff
        li $a1,100
        li $v0,8
        syscall
#�����ظ�����
repeat:
        li $v0,12
        syscall
#ѭ�������ַ���
        li $s0,0
        la $s1,buff
        li $s2, 0
        li $t3,63
loop:
        add $t0,$s0,$s1
        lb $t1,($t0)
#�Ƿ��ʺţ�
        beq $v0,$t3,exit
#�Ƿ��ѵ��ַ���ĩβ��
        beq $t1,$s2,fail
#�Ƿ�ǰ�ַ�ƥ��ɹ���
        beq $v0,$t1,success
        add $s0,$s0,1
        j loop
#�����ʺŽ���
exit:
        li $v0,10
        syscall
#���ҵ�ĩβʧ��
fail:
        la $a0 fail_t
        li $v0,4
        syscall
        j repeat
#ƥ��ɹ�
success:
        la $a0 success_t
        li $v0,4
        syscall
        add $a0,$s0,1
        li $v0,1
        syscall
        la $a0 enter
        li $v0,4
        syscall
        j repeat
