# kitten
Minimal cat implementation in asm


stupidly overoptimized replacement for `cat` command

## Limitations

* Ignores standard input pipe, only operates on the files listed in the arguments
* Cannot use stdin in file list either with '`-`' (but still can with `/dev/stdin`)
* Any argument that's not a file path, or otherwise can't be read without errors, is silently skipped.

When called on a list of valid files, it should otherwise behave identical to regular `cat` when called without option flags.
So `kitten file1 file2 file3...` will still concatenate the files to stdout. However, it doesn't do anything fancy besides that.

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
