include emu8086.inc

org 100h

.data
msg1      db  'Please input N to caculate: ', 0
msg2      db  'The answer of factor(N) is: ', 0
ans       dw  4   dup(0)      ;factor(20) = 21C3_677C_82B4_0000h，需要4个字的空间
ans_ascii db  20  dup(0)      ;factor(20) = 243,2902,0081,7664,0000，加上字符串结尾的'\0'，需要20字节的空间

.code
factor  proc  near
start:
        xor   ax, ax          ;初始化
        xor   bx, bx
        xor   cx, cx
        xor   dx, dx
        xor   si, si
        xor   di, di
input:                        ;打印提示信息并要求输入N
        lea   si, msg1
        call  print_string
        call  scan_num
        mov   ah, 2
        mov   dl, 13          ;回车
        int   21h
        mov   dl, 10          ;换行
        int   21h
        mov   ans[6], 1       ;初始化保存结果的，注意0! = 1
        cmp   cx, 0           ;cx = 0时，ans = 1
        je    num2ch
iter:                         ;迭代法，按字串行乘法与进位
word1:                        ;ans[0]放最高16位
        xchg  ans[0], ax
        mul   cx
        xchg  ans[0], ax
word2:                        ;ans[2]放次高16位
        xchg  ans[2], ax
        mul   cx
        xchg  ans[2], ax
        add   ans[0], dx      ;计算ans[0]与ans[2]进位的加法，该加法不可能产生进位
word3:                        ;ans[4]放次低16位
        xchg  ans[4], ax
        mul   cx
        xchg  ans[4], ax
        add   ans[2], dx      ;计算ans[2]与ans[4]进位的加法
        jnc   word4           ;判断ans[2]加法是否产生进位
        add   ans[0], 1       ;产生进位时ans[0]加1
word4:                        ;ans[6]放最低16位
        xchg  ans[6], ax
        mul   cx
        xchg  ans[6], ax
        add   ans[4], dx      ;计算ans[4]与ans[6]进位的加法
        jnc   iter_chk        ;判断ans[4]加法是否产生进位
        add   ans[2], 1       ;产生进位时ans[2]加1
        jnc   iter_chk        ;再判断ans[2]加法是否产生进位
        add   ans[0], 1       ;产生进位时ans[0]加1
iter_chk:                     
        loop  iter
num2ch:                       ;数转换为字符串
        mov   cx, 10          ;因为要转化为10进制数字符串，所以被除数是10
        mov   di, 18          ;ans_ascii[-2]，最后一个元素固定为'\0'
init:                                                              
        xor   bx, bx          ;转码结束判断条件初始化
        xor   si, si          ;数组下标初始化
        xor   dx, dx          ;用dx收集32位除法的余数作为下一次32位除法的高位，初始值为0
word_loop:                    ;逐字串行求余数
        mov   ax, ans[si]     ;准备被除数的低位，高位采用上一次除法的余数，初始值为0
        div   cx
        add   bx, ax          ;除法结束后计算bx = sigma(ans[si])，作为转码结束判断条件
        mov   ans[si], ax     ;更新原本的ans，作为下一次循环的被除数
        add   si, 2
        cmp   si, 6
        jle   word_loop
ch_loop:                      ;每次word_loop结束后，dl里存放着当前最低位的10进制数码，转化为ascii码并保存
        add   dl, '0'         ;转换为ascii码
        mov   ans_ascii[di], dl
        dec   di              ;自后向前存储
        cmp   bx, 0           ;bx = 0时说明已经将原2进制数各位都转码完毕
        jne   init        
output: 
        lea   si, msg2
        call  print_string
        lea   si, ans_ascii
find_ch_start:                ;寻找输出的10进制数的最高位（非0位）
        mov   al, [si]        
        inc   si
        cmp   al, 0
        je    find_ch_start
        dec   si              ;抵消一次多余的inc操作
        call  print_string
        ret
factor  endp
      
define_print_string
define_scan_num

end