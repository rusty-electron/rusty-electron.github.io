---
layout: post
title: basics of arm assembly
date: 2021-09-26 02:35 +0530
tags: embedded
---

Before working with ARM assembly, you need to have the arm compiler toolchain installed. If you are on debian-based distros, you can run `sudo apt install gcc-5-arm-linux-gnueabi`, arch users can install the package `arm-none-eabi-gcc` using `pacman`.

Now open up your favourite text editor and type out the following boilerplate code:

```nasm
.global _start
.section .text

_start:

.section .data
```

Some notes about the above given template:
* comments start with `#` sign
* the `.global _start` means that the `_start` symbol is a global symbol and therefore, it is accessible in other files and the buildchain can access it.
* `.section .text` specifies that the text under this line is code that is to be executed. This section is readable and executable (but not writable obviously).
* `.section .data` means that data lies below this line. It is readable and writable (but not executable).

### testing a simple instruction

```nasm
.global _start
.section .text

_start:
    mov r0, #4

.section .data
```

Here we demonstrate the `mov` instruction that is used here to move the immediate value `4` (immediate values start with a # sign in ARM assembly) to the r0 register.

Let's save it as `001.asm`.

### compiling and executing

We need to assemble this file so we use the `arm-none-eabi-as` tool in arch (or `arm-linux-gnueabi-as` in debian) to turn this into an intermediate object file that will be converted into executable ELF binary by arm `gcc`.

```sh
$ arm-none-eabi-as 001.asm -o 001.o
$ file 001.o
001.o: ELF 32-bit LSB relocatable, ARM, EABI5 version 1 (SYSV), not stripped
```

Now we pass the object file through the linker.

```sh
$ arm-none-eabi-gcc 001.o -o 001.elf -nostdlib
$ file 001.elf
001.elf: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), statically linked, not stripped
```

Note that we passed the `-nostdlib` flag to the linker, this is because if we don't do that the linker includes the standard libc and when that happens the `_start` symbol gets redefined and calls the `main` function that is not defined in our code.

### running the executable

Now you are probably not working on a machine with ARM architecture (as of 2021) so you need to install `qemu` which is "[*a free and open-source hypervisor*](https://www.qemu.org/)". Arch users can `sudo pacman -S qemu-arch-extra`.

```sh
$ qemu-arm ./001.elf
Illegal instruction (core dumped)
```

So our program crashed when we tried executing it and this is because it didn't exit properly, instead it ran the `mov` instruction and continued to executed the code below it. We can use `xxd 001.elf` to see that there is a lot of content in the .elf file after the `mov` instruction.

In order to make sure that the program exits properly, we need to make use of [*system calls*](https://en.wikipedia.org/wiki/System_call).

When we usualy write a program, it runs in the user-mode as opposed to kernel mode. A user-mode application process can't end itself so it has to make use of a software interrupt to ask to kernel to end the user-mode process.

In arm assembly, we use the register r7 to specify what the kernel should do and the registers r0-r4 to specify the how it should be done (i.e. the configurations).

#### syscall table

Visit this [link](https://chromium.googlesource.com/chromiumos/docs/+/HEAD/constants/syscalls.md#arm-32_bit_EABI) to view the syscall table for arm 32-bit.

See the row where it reads `exit`. We will now use the info given in this row to make our `exit` syscall.

### exit

```nasm
.global _start
.section .text

_start:
    mov r7, #0x1
    mov r0, #13

    swi 0

.section .data
```

As given in the table, we need to load the hex value of `0x1` into the register r7 and we can load the return value (any arbitrary number) in r0.

Let us now try executing this code.

```sh
$ arm-none-eabi-as 001.asm -o 001.o
$ arm-none-eabi-gcc 001.o -o 001.elf -nostdlib
$ qemu-arm 001.elf
$ echo $?
13
```

So no errors this time and the return value is what we specified in our assembly code.

### writing to STDOUT

I order to write data to the screen, once again we need to refer to the [syscall table](https://chromium.googlesource.com/chromiumos/docs/+/HEAD/constants/syscalls.md#arm-32_bit_EABI) and this time the `write` syscall is of interest to us. In Linux, we have three types of file descriptors:

* STDIN - file descriptor 0
* STDOUT - file descriptor 1
* STDERR - file descriptor 2

As we are going to print text on the screen, the file descriptor 1 - `STDOUT` is where we should write our data.

```nasm
.global _start
.section .text

_start:
    mov r7, #0x4
    mov r0, #1
    ldr r1, =message
    mov r2, #13

    swi 0

    mov r7, #0x01
    mov r0, #42

    swi 0

.section .data
    message:
    .ascii "Hello, World\n"
```

According to the table, we move the value `0x4` into the r7 register because we are going to use system call 4, next we load 1 into r0 register and we do this because we are going to write to the file descriptor 1. We then edit to the data section and define the `message` symbol that is of type *ascii* and the message is `Hello, World\n`. The `ldr` instruction can be used to load a memory address to a register so we use this instruction to load the address of `message` to the r1 register. The last data that the `write` system call needs is the length of the message string which is 13 in this case so we load it into the register r2.

We also add the instructions for an `exit` syscall at the end as without it the program will crash (as seen previously) after printing our message. 

We can now try to assemble, compile and run our program to see that it prints the message and exits successfully.

```sh
$ arm-none-eabi-as 001.asm -o 001.o
$ arm-none-eabi-gcc 001.o -o 001.elf -nostdlib
$ qemu-arm 001.elf
Hello, World
```

Neat!

> I prepared this article as a text version of a [video](https://www.youtube.com/watch?v=FV6P5eRmMh8) created by [@lowlevellearning](https://www.youtube.com/c/LowLevelLearning/) on youtube, therefore the credit for the content goes to him. Do check out his channel, he makes amazing content on embedded systems and I have learnt a lot from his videos and streams.