# Ada RISC-V Examples for Renode

This repository contains a set of minimal examples that run an Ada, cross compiled for the RISC-V, on an emulated core using [Renode](https://renode.readthedocs.io/en/latest/index.html).

## How to Get Started

The examples can be compiled and run in a Docker container. First, let's set that up:

 1. Start by downloading [Docker Desktop](https://www.docker.com/products/docker-desktop/).
 2. Next, clone this repository:

  ```
  $ git clone https://github.com/dinkelk/ada_riscv_renode.git 
  ```

 3. Start the container and log in:

  ```
  $ cd ada_riscv_renode/docker
  $ ./create_container.sh
  $ ./login_container.sh
  ```

You should now be logged into a shell within the container. This repository is shared with the container at `~/ada_riscv_renode`.

## Compiling the Examples

To compile all the example programs, run the following from within the container:

  ```
  $ cd ~/ada_riscv_renode
  $ alr -n build
  ```

This will build all the examples in their respective source directories, ie. `src/<example_name>/bin/<example_program>`.

## Running the Examples

After you have compiled the examples, you can run them on Renode using the instructions below.

### Running Blinky

From within the container, invoke renode:

  ```
  $ cd ~/ada_riscv_renode/src/blinky
  $ renode vexriscv.resc
  17:39:02.4980 [WARNING] Couldn't start UI - falling back to console mode
  17:39:02.9129 [INFO] Loaded monitor commands from: /opt/renode/scripts/monitor.py
  Renode, version 1.14.0.29506 (81da46c1-202308081623)
  (monitor) i $CWD/vexriscv.resc
  17:39:03.1309 [INFO] Including script: /home/user/ada_riscv_renode/src/vexriscv.resc
  17:39:03.1433 [INFO] System bus created.
  17:39:03.7678 [INFO] sysbus: Loading segment of 1515 bytes length at 0x10000.
  17:39:03.7813 [INFO] sysbus: Loading segment of 33 bytes length at 0x115EC.
  17:39:03.7965 [INFO] cpu: Setting PC value to 0x1013C.
  17:39:03.8216 [INFO] vexriscv-machine: GDB server with all CPUs started on port :3333
  Starting emulation...
  17:39:03.8305 [INFO] vexriscv-machine: Machine started.
  17:39:03.8835 [NOISY] gpio_out.led0: LED state changed to True
  (vexriscv-machine) 17:39:04.3264 [NOISY] gpio_out.led0: LED state changed to False
  17:39:04.7051 [NOISY] gpio_out.led0: LED state changed to True
  17:39:05.0953 [NOISY] gpio_out.led0: LED state changed to False
  ```

You will see the LED state changing back and forth by the Ada program.

### Running UART

From within the container, invoke renode:

 ```
 $ cd ~/ada_riscv_renode/src/uart
 $ renode vexriscv.resc
 22:30:18.6848 [WARNING] Couldn't start UI - falling back to console mode
 22:30:19.1693 [INFO] Loaded monitor commands from: /opt/renode/scripts/monitor.py
 Renode, version 1.14.0.29506 (81da46c1-202308081623)
 (monitor) i $CWD/vexriscv.resc
 22:30:19.4028 [INFO] Including script: /home/user/ada_riscv_renode/src/uart/vexriscv.resc
 22:30:19.4171 [INFO] System bus created.
 22:30:20.4249 [INFO] sysbus: Loading segment of 572 bytes length at 0x10000.
 22:30:20.4368 [INFO] sysbus: Loading segment of 2 bytes length at 0x1123C.
 22:30:20.4541 [INFO] cpu: Setting PC value to 0x10140.
 22:30:20.4841 [INFO] vexriscv-machine: GDB server with all CPUs started on port :3335
 Starting emulation...
 22:30:20.5935 [INFO] vexriscv-machine: Machine started.
 ```

This example connects the RISC-V's UART to a socket in the docker container. To talk to the RISC-V via this socket, log into the container with a separate shell and run:

 ```
 $ cd ~/ada_riscv_renode/src/uart
 $ ./uart_connect.sh
 Hello, World!
 Hello, World!
 ```

Anything you type (followed by ENTER) is sent over a socket to the RISC-V's UART. The Ada program then repeats back what it receives over the RISC-V UART to the docker container's socket, which appears as an echo in the terminal.
