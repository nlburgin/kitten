# kitten
Minimal cat implementation in asm


stupidly overoptimized replacement for `cat` command

## Limitations

* Does not take stdin
* Any argument that's not a file we can read is silently skipped.

When called on a list of valid files, should behave identical to regular cat
