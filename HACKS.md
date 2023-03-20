# Hacks used to get this working
This list is not complete.

* The `bits` directory had the contents of `../arm-nilrt-linux-gnueabi/bits/` symlinked into it.
* DriverStation.h had this added:
```c
#include <stddef.h>
```
