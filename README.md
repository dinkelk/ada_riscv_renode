# Ada RISC-V Demo for Renode

This little example runs an Ada "blinky" program cross compiled for the RISC-V and runs it on an emulated core using [Renode](https://renode.readthedocs.io/en/latest/index.html).

### How to Compile and Run

This demo is compiled and run in a Docker container.

 1. Start by downloading [Docker Desktop](https://www.docker.com/products/docker-desktop/).
 2. Next, clone this repository:

  ```
  $ git clone https://github.com/dinkelk/ada_riscv_renode.git 
  ```

 3. Start the container:

  ```
  $ cd ada_riscv_renode/docker
  $ ./create_container.sh
  $ ./login_container.sh
  ```

 4. You should now be logged into a shell within the container. This repository is shared with the container at `~/ada_riscv_renode`. To compile the blinky code run the following from within the container:

  ```
  $ cd ~/ada_riscv_renode
  $ alr -n build
  ```

 5. Finally, run the compiled program using Renode.

  ```
  $ cd ~/ada_riscv_renode
  $ renode src/blinky/vexriscv.resc
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
  17:39:05.5079 [NOISY] gpio_out.led0: LED state changed to True
  17:39:05.9473 [NOISY] gpio_out.led0: LED state changed to False
  ```
