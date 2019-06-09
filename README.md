# kitten
Minimal cat implementation in asm


stupidly overoptimized replacement for `cat` command

## Limitations

* Does not take stdin
* Any argument that's not a file we can read is silently skipped.

When called on a list of valid files, should behave identical to regular cat

## System Requirements
Any X86_64 Linux system

## Build requirements
* NASM
* GNU ld

## Build instructions
```
nasm -f elf64 kitten.asm
ld -o kitten kitten.o
```
