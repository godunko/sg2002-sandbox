# Ada on Milk-V Duo 256M/SG2002

## Requirements

Hardware:
1. [Milk-V Duo 256M](https://milkv.io/duo) board
2. Some USB-UART (TTL/3.3V) board to connect to console
3. USB Type-C cable to connect Milk-V board to the computer

Software:
1. [Alire](https://alire.ada.dev/) manager
2. [sg_boot](https://github.com/orangecms/sg_boot) application

## Connections

Some connections need to be done to connect to serial console and to activate firmware download through USB.

Milk-V board pinout can be found on [Wiki](https://milkv.io/docs/duo/getting-started/duo256m)

| Milk-V board pin | GPIO Line | Function Line | Comments |
| :--------------: | :-------: | :-----------: | :------- |
| 16 | GP12 | UART TX |
| 17 | GP13 | UART RX |
| 31 | GP26 | | Need to be connected to 3.3V, pin 36 to activate USB downloading |

## Build

Run `make` to build application binary file. File is stored in the `bin/bl2.bin` file.

## Download to board

To download binary file to the board connect it to USB and run `sg_boot` application.

```
    sg_boot run bin/bl2.bin
```

On console you will see

```
C.SCS/0/0.WD.URPL.USBI.USBK.USBD.BS/USB.PS.USBB.USBL.PE.BS.USBK.USBL.BE.J.

--------------------
--  Ada on Board  --
--------------------

Hello, Milk-V Duo 256M/SC2002/RISC-V!
```

First line is output of the on chip bootloader, and below is output of the Ada application.

Happy hacking!
