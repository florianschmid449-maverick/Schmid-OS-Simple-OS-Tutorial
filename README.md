# Schmid-OS-Simple-OS-Tutorial
A step-by-step tutorial on building and running a minimal 16-bit x86 bootloader in Assembly. Learn how to use NASM and QEMU to boot a custom OS that prints ASCII art directly from the BIOS.

Below is a complete README.md template you can use for your GitHub repository to explain how to compile and run your bootloader code.

![Alt text](https://raw.githubusercontent.com/florianschmid449-maverick/Schmid-OS-Simple-OS-Tutorial/refs/heads/main/Screenshot_2026-07-13_17-26-20.png)

# Schmid OS: Minimal x86 Bootloader

This repository contains a very basic, single-sector 16-bit bootloader written in x86 Assembly. When booted, it clears the screen and uses BIOS interrupts to print a centered ASCII art owl along with the OS name and contact information. 

This project is a great starting point for anyone looking to learn about bare-metal programming, BIOS interrupts, and how computers boot.

## Features
* **Bare Metal execution:** Runs without an underlying operating system, loaded directly into memory at `0x7c00` by the BIOS.
* **BIOS Interrupts:** Uses standard BIOS routines (`int 0x10`) for VGA text output (teletype mode).
* **Boot Sector Compliant:** Pads the binary to exactly 512 bytes and includes the standard `0xaa55` boot signature.

## Prerequisites

To compile and run this code, you will need an assembler and an emulator.

*   **NASM (Netwide Assembler):** Used to compile the assembly code into a raw binary format.
*   **QEMU:** A machine emulator used to boot our compiled binary as if it were a real floppy disk or hard drive.

### Installing Dependencies

**On Ubuntu/Debian:**
```bash
sudo apt update
sudo apt install nasm qemu-system-x86



On macOS (using Homebrew):

Bash
brew install nasm qemu
On Windows:
You can install NASM and QEMU via Chocolatey or download the binaries directly from their respective websites. Alternatively, you can use WSL (Windows Subsystem for Linux) and run the Ubuntu commands above.


How to Build and Run1. Save the CodeEnsure your assembly code is saved in a file named boot.asm.  2. Compile the BootloaderOpen your terminal, navigate to the directory containing boot.asm, and run the following command to compile the assembly file into a flat binary file:Bashnasm -f bin boot.asm -o boot.bin
-f bin: Tells NASM to output a raw binary file (no executables headers like ELF or PE).-o boot.bin: The name of our compiled output file.3. Boot the EmulatorNow, run the binary using QEMU by telling it to treat our 512-byte binary as a floppy disk:Bashqemu-system-x86_64 -fda boot.bin
(Note: You can also use qemu-system-i386)A new window will pop up showing the QEMU emulator booting your code. You should see the screen clear, followed by a centered ASCII owl and the text "Schmid OS"[cite: 1].How It WorksOrigin Point: The code starts with [org 0x7c00], which tells the assembler to calculate all memory offsets assuming the BIOS loads this code at the address 0x7c00 in RAM[cite: 1].Video Mode Setup: It sets the AH register to 0x00 and AL to 0x03, then calls int 0x10 to reset the screen to a standard 80x25 text mode[cite: 1].Printing: It loops through a byte array (os_text), utilizing the BIOS scrolling teletype function (AH = 0x0e) to print each character until it hits a null terminator (0)[cite: 1].Boot Signature: The times 510-($-$$) db 0 directive fills the remaining space in the 512-byte sector with zeros. The final two bytes, dw 0xaa55, form the magic number the BIOS looks for to confirm this is a bootable device[cite: 1].




