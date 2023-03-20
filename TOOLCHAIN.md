#  Setting up a toolchain

**TODO: Write an all-in-one installer for this**

## Downloads

There are a few steps before getting to the Swift-specific bit:
1. **Go download the latest WPILib.** You can get the latest [on their GitHub Releases page](https://github.com/wpilibsuite/allwpilib/releases/).
2. **Go download the Swift armv7 toolchain.** Clone the project from [the project's GitHub page](https://github.com/colemancda/swift-armv7/tree/main), and then run `build.sh`.

You won't be using the generated toolchain JSON file, but you will need the tools in that directory.

## Toolchain JSON file

Set up a JSON file with this format (call it `roborio-toolchain.json`):

```json
{
   "version":1,
   "sdk":"[WPILIB_INSTALL_DIR]/2023/roborio/arm-nilrt-linux-gnueabi/sysroot",
   "toolchain-bin-dir":"[SWIFT_ARMV7_INSTALL_DIR]/build/swift-5.7.1-RELEASE-armv7-debian11.xctoolchain/usr/bin",
   "target":"armv7-unknown-linux-gnueabi",
   "dynamic-library-extension":"so",
   "extra-cc-flags":[
      "-fPIC",
      "-isystem[WPILIB_INSTALL_DIR]/2023/roborio/arm-nilrt-linux-gnueabi/sysroot/usr/include/c++/12",
   ],
   "extra-swiftc-flags":[
      "-target", "armv7-unknown-linux-gnueabihf",
      "-use-ld=lld",
      "-Xlinker", "-L[SWIFT_ARMV7_INSTALL_DIR]/bullseye-armv7",
      "-Xlinker", "-L[SWIFT_ARMV7_INSTALL_DIR]/bullseye-armv7/lib",
      "-Xlinker", "-L[SWIFT_ARMV7_INSTALL_DIR]/bullseye-armv7/usr/lib",
      "-Xlinker", "-L[SWIFT_ARMV7_INSTALL_DIR]/bullseye-armv7/usr/lib/swift",
      "-Xlinker", "-L[SWIFT_ARMV7_INSTALL_DIR]/bullseye-armv7/usr/lib/swift/linux",
      "-Xlinker", "-L[SWIFT_ARMV7_INSTALL_DIR]/bullseye-armv7/usr/lib/swift/linux/armv7",
      "-Xlinker", "--build-id=sha1",
      "-I[SWIFT_ARMV7_INSTALL_DIR]/bullseye-armv7/usr/lib/swift",
      "-resource-dir", "[SWIFT_ARMV7_INSTALL_DIR]/bullseye-armv7/usr/lib/swift",
      "-resource-dir", "[SWIFT_ARMV7_INSTALL_DIR]/build/swift-linux-armv7-install/usr/lib/swift",
      "-Xclang-linker", "-B[SWIFT_ARMV7_INSTALL_DIR]/bullseye-armv7/usr/lib",
      "-sdk", "[SWIFT_ARMV7_INSTALL_DIR]/bullseye-armv7"
   ],
   "extra-cpp-flags":[]
}
```

* `[WPILIB_INSTALL_DIR]` should be the `wpilib` directory in your home directory (or elsewhere if you told the WPILib installer to put it somewhere else.)
* `[SWIFT_ARMV7_INSTALL_DIR]` should be the directory where you cloned (and then built) the Swift armv7 toolchain.

## Building for the RIO

Great! Now you're ready to build for the RoboRIO with Swift! To build this libary, open a terminal to the root of the project, then run the following command:

```bash
swift build --destination '[LOCATION_OF_TOOLCHAIN.JSON]'
```

* `[LOCATION_OF_TOOLCHAIN.JSON]` should be the path to the toolchain JSON file you saved earlier.

Great! You should see something like this:

```
Building for debugging...
~/SwiftRIOHAL/Sources/CRIOHAL/Implementation/athena/Notifier.cpp:48:50: warning: braces around scalar initializer [-Wbraced-scalar-init]
static std::atomic_flag notifierAtexitRegistered{ATOMIC_FLAG_INIT};
                                                 ^~~~~~~~~~~~~~~~
~/wpilib/2023/roborio/arm-nilrt-linux-gnueabi/sysroot/usr/include/c++/12/bits/atomic_base.h:193:26: note: expanded from macro 'ATOMIC_FLAG_INIT'
#define ATOMIC_FLAG_INIT { 0 }
                         ^~~~~
1 warning generated.
[72/72] Emitting module SwiftRIOHAL
Build complete! (4.19s)
```
