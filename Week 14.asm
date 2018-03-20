include emu8086.inc

org 100h

.data
msg1      db  'Please input N to caculate: ', 0
msg2      db  'The answer of factor(N) is: ', 0
ans       dw  4   dup(0)      ;factor(20) = 21C3_677C_82B4_0000h����Ҫ4���ֵĿռ�
ans_ascii db  20  dup(0)      ;factor(20) = 243,2902,0081,7664,0000�������ַ�����β��'\0'����Ҫ20�ֽڵĿռ�

.code
factor  proc  near
start:
        xor   ax, ax          ;��ʼ��
        xor   bx, bx
        xor   cx, cx
        xor   dx, dx
        xor   si, si
        xor   di, di
input:                        ;��ӡ��ʾ��Ϣ��Ҫ������N
        lea   si, msg1
        call  print_string
        call  scan_num
        mov   ah, 2
        mov   dl, 13          ;�س�
        int   21h
        mov   dl, 10          ;����
        int   21h
        mov   ans[6], 1       ;��ʼ���������ģ�ע��0! = 1
        cmp   cx, 0           ;cx = 0ʱ��ans = 1
        je    num2ch
iter:                         ;�����������ִ��г˷����λ
word1:                        ;ans[0]�����16λ
        xchg  ans[0], ax
        mul   cx
        xchg  ans[0], ax
word2:                        ;ans[2]�Ŵθ�16λ
        xchg  ans[2], ax
        mul   cx
        xchg  ans[2], ax
        add   ans[0], dx      ;����ans[0]��ans[2]��λ�ļӷ����üӷ������ܲ�����λ
word3:                        ;ans[4]�Ŵε�16λ
        xchg  ans[4], ax
        mul   cx
        xchg  ans[4], ax
        add   ans[2], dx      ;����ans[2]��ans[4]��λ�ļӷ�
        jnc   word4           ;�ж�ans[2]�ӷ��Ƿ������λ
        add   ans[0], 1       ;������λʱans[0]��1
word4:                        ;ans[6]�����16λ
        xchg  ans[6], ax
        mul   cx
        xchg  ans[6], ax
        add   ans[4], dx      ;����ans[4]��ans[6]��λ�ļӷ�
        jnc   iter_chk        ;�ж�ans[4]�ӷ��Ƿ������λ
        add   ans[2], 1       ;������λʱans[2]��1
        jnc   iter_chk        ;���ж�ans[2]�ӷ��Ƿ������λ
        add   ans[0], 1       ;������λʱans[0]��1
iter_chk:                     
        loop  iter
num2ch:                       ;��ת��Ϊ�ַ���
        mov   cx, 10          ;��ΪҪת��Ϊ10�������ַ��������Ա�������10
        mov   di, 18          ;ans_ascii[-2]�����һ��Ԫ�ع̶�Ϊ'\0'
init:                                                              
        xor   bx, bx          ;ת������ж�������ʼ��
        xor   si, si          ;�����±��ʼ��
        xor   dx, dx          ;��dx�ռ�32λ������������Ϊ��һ��32λ�����ĸ�λ����ʼֵΪ0
word_loop:                    ;���ִ���������
        mov   ax, ans[si]     ;׼���������ĵ�λ����λ������һ�γ�������������ʼֵΪ0
        div   cx
        add   bx, ax          ;�������������bx = sigma(ans[si])����Ϊת������ж�����
        mov   ans[si], ax     ;����ԭ����ans����Ϊ��һ��ѭ���ı�����
        add   si, 2
        cmp   si, 6
        jle   word_loop
ch_loop:                      ;ÿ��word_loop������dl�����ŵ�ǰ���λ��10�������룬ת��Ϊascii�벢����
        add   dl, '0'         ;ת��Ϊascii��
        mov   ans_ascii[di], dl
        dec   di              ;�Ժ���ǰ�洢
        cmp   bx, 0           ;bx = 0ʱ˵���Ѿ���ԭ2��������λ��ת�����
        jne   init        
output: 
        lea   si, msg2
        call  print_string
        lea   si, ans_ascii
find_ch_start:                ;Ѱ�������10�����������λ����0λ��
        mov   al, [si]        
        inc   si
        cmp   al, 0
        je    find_ch_start
        dec   si              ;����һ�ζ����inc����
        call  print_string
        ret
factor  endp
      
define_print_string
define_scan_num

end