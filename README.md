# CS382 Project 1 - Pringle

*Pringle* is a variadic function that can take in an infinite number of parameters. This is accomplished by storing the extra parameters onto the stack in virtual memory. Written in ARM Assembly, *Pringle* is a reimplementation of C's `printf()` function.

To use the tester do (in the respective directory):

```
qemu-aarch64 -L /usr/aarch64-linux-gnu tester -h
```
