# bs

bs is a simple starter program demonstrating how to write a 16-bit x86 assembly
bootloader! It runs on [bootOS](https://github.com/nanochess/bootOS/), which
provides some basic system calls (but not too much to make it "boring").

## Prerequisites

bs requires some well-known software to run:

* nasm
* QEMU
* make
* gdb (for debugging)

## Assembling

You can assemble bs by using nasm:

    make bs.bin

and run bs using QEMU:

    make run

once bootOS loads, you can run the output program under bs:

    $bs
    Hello, world!
    $

### Build features

Building creates an assembly listing under `bs.lst`. This can be used to look
for code which takes up too many bytes for size optimization. The build also
produces `bs.elf`, which is used by GDB for debugging symbols, as described
below.

## Debugging

You can debug by opening two separate terminals. In one terminal, run `make
debug` to start QEMU in debug mode. In the other terminal, run `make gdbdebug`
to start GDB along with some helpful default scripts. Switch back to the first
terminal and run bs as described above. The second terminal will stop on the
entry point of the bs program, allowing you to step through its execution.

The helper file `gdb-real-mode` provides the following scripts:

* `r2p`
* `int_addr`
* `break_int`
* `break_int_if_ah`
* `break_int_if_ax`
* `stepo`
* `step_until_iret`
* `step_until_ret`
* `step_until_int`
* `find_in_mem`
* `step_until_code`

Documentation for these commands can be found by using `gdb`'s `help` command.

## License

Copyright (c) 2020 Keyhan Vakil

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
