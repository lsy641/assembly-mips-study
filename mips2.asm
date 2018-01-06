.data
fail_t: .asciiz "\nFail!\n"
success_t:.asciiz "\nSuccess! Location: "
enter:.asciiz "\n"
buff: .space 100
.text
.globl main

main:
#系统调用读入字符串和待查询字符
        la $a0,buff
        li $a1,100
        li $v0,8
        syscall
#可以重复查找
repeat:
        li $v0,12
        syscall
#循环遍历字符串
        li $s0,0
        la $s1,buff
        li $s2, 0
        li $t3,63
loop:
        add $t0,$s0,$s1
        lb $t1,($t0)
#是否问号？
        beq $v0,$t3,exit
#是否已到字符串末尾？
        beq $t1,$s2,fail
#是否当前字符匹配成功？
        beq $v0,$t1,success
        add $s0,$s0,1
        j loop
#读入问号结束
exit:
        li $v0,10
        syscall
#查找到末尾失败
fail:
        la $a0 fail_t
        li $v0,4
        syscall
        j repeat
#匹配成功
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
