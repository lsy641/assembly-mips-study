.data
#����һ���������ĸ��Ӧ���ַ�����˳���ţ������ַ������Ƕ���������Ҫ��¼ÿ��Ԫ�ص�ƫ�������������ֲ��á�
h_letter: .asciiz
        "Alpha ","Bravo ","China ","Delta ","Echo ","Foxtrot ",
        "Golf ","Hotel ","India ","Juliet ","Kilo ","Lima ",
        "Mary ","November ","Oscar ","Paper ","Quebec ","Research ",
        "Sierra ","Tango ","Uniform ","Victor ","Whisky ","X-ray ",
        "Yankee ","Zulu "
h_offset: .word
        0,7,14,21,28,34,43,49,56,63,71,77,83,89,99,106,113,121,131,139,
        146,155,163,171,178,186
l_letter: .asciiz
        "alpha ","bravo ","china ","delta ","echo ","foxtrot ",
        "golf ","hotel ","india ","juliet ","kilo ","lima ",
        "mary ","november ","oscar ","paper ","quebec ","research ",
        "sierra ","tango ","uniform ","victor ","whisky ","x-ray ",
        "yankee ","zulu "
l_offset:.word
         0,7,14,21,28,34,43,49,56,63,71,77,83,89,99,106,113,121,131,
         139,146,155,163,171,178,186
number:.asciiz
        "zero ", "First ", "Second ", "Third ", "Fourth ","Fifth ",
         "Sixth ", "Seventh ","Eighth ","Ninth "
n_offset:.word         
        0,6,13,21,28,36,43,50,59,67
        .text
        .globl main
main:
#ϵͳ���� ����һ���ַ�
        li $v0,12        
        syscall
#�ж�����ַ���ʲô����
#�յ��ʺŽ���
        beq $v0,63,exit
#�Ǵ�д��ĸ��
        sub $t0,$v0,65
        slt $t0,$t0,$0
        sub $t1,$v0,90
        slt $t1,$0,$t1
        or $t2,$t0,$t1
        beqz $t2,is_h_letter
#��Сд��ĸ��
        sub $t0,$v0,97
        slt $t0,$t0,$0
        sub $t1,$v0,122
        slt $t1,$0,$t1
        or $t2,$t0,$t1
        beqz $t2,is_l_letter
#��������
        sub $t0,$v0,48
        slt $t0,$t0,$0
        sub $t1,$v0,57
        slt $t1,$0,$t1
        or $t2,$t0,$t1
        beqz $t2,is_number
#ʣ�µ�Ӧ�ö��ǲ��ϸ��
        j orther
is_h_letter:
#�ҵ���Ӧƫ����
        sub $t0,$v0,65
        sll $t0, $t0, 2
        la $s0,h_offset
        add $s0,$s0,$t0
        lw $s1,($s0)
#����ƫ�����ҵ���Ӧ�ַ���
        la $a0,h_letter
        add $a0,$s1,$a0
        li $v0,4
        syscall
        j main
is_l_letter:
#�ҵ���Ӧƫ����
        sub $t0,$v0,97
        sll $t0,$t0,2
        la $s0,l_offset
        add $s0,$s0,$t0
        lw $t1,($s0)
#����ƫ�����ҵ���Ӧ�ַ���
        la $s1,l_letter
        add $a0,$s1,$t1
        li $v0,4
        syscall
        j main
is_number:
#�ҵ���Ӧƫ����
        sub $t0,$v0,48
        sll $t0,$t0,2
        la $s0,n_offset
        add $s0,$t0,$s0
        lw $t1,($s0)
#����ƫ�����ҵ���Ӧ�ַ���
        la $a0,number
        add $a0,$a0,$t1
        li $v0,4
        syscall        
        j main
orther:
#ע���ʱϵͳ��������ַ�ָ��
        and $a0, $0, $0
        add $a0, $a0, 42 # '*'
        li $v0,11
        syscall
        j main
exit:
#�˳�
        li $v0, 10 # exit
        syscall

