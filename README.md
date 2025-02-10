# <div align="center"> lerobot-koch-actpp </div>

This repository is built on the [lerobot](https://github.com/hrc-pme/lerobot/tree/33724a273dfa3a62b845cbbb030b21b71fc5d12b) framework to establish a software environment for the Koch arm and its peripheral devices.

##  <div align="center"> 🌱 Environment 🌱 </div>

* Arm: Bimanual Koch Robot Arm. (2 leaders, 2 followers)
* Camera: Intel® RealSense™ Depth Camera D415. (3~5 cams)
* Computer: x86 Linux host with docker installed.
* GPU: GPU is required and must be compatible with CUDA 12.4.


##  <div align="center"> 🛠️ Usage 🛠️ </div>

1. Clone this repository and initialize submodules.
   
   ```bash
   git clone https://github.com/hrc-pme/lerobot-koch-actpp.git
   cd lerobot-koch-actpp
   git submodule update --init --recursive
   ```

2. Follow [UdevRules.md](/assets/UdevRules.md) to setup koch robot arm port.

3. onfigure the correct ports for the Koch arm in `/docker/entrypoint/symlinks.sh`.

   ```sh
    ln -sf /dev/ttyACM4 /dev/ttykoch_left_follower
    ln -sf /dev/ttyACM0 /dev/ttykoch_left_leader
    ln -sf /dev/ttyACM2 /dev/ttykoch_right_follower
    ln -sf /dev/ttyACM1 /dev/ttykoch_right_leader
   ```

4. (Optional) Setup your huggingface token in `.env` file.
   
   ```bash
   cd /docker/entrypoint
   cp .env.example .env
   ```

>[!TIP]
We recommend setup your huggingface token to visualize data analysis.
However, you can skip this by removing`/docker/gpu/token.sh` in  `docker/gpu/compose.yml` `entrypoint` block.

5. Start the container.

   ```bash
   ./gpu_run.sh raw
   ```

---

### ✨ Container Startup Option

We provide 5 modes: `raw`, `arm-sync`, `armv-rec`, `actpp-train`, `actpp-deploy`.

* `raw`: Startup the environment without running any node.
* `arm-sync`: Synchronize Koch robot arms and find usable cameras.
* `armv-rec`: Synchronize and record arms/visual data. 
* `actpp-train`: Locally train your custom dataset with ACT model.
* `actpp-deploy`: Locally deplooy your custom model on Koch and cameras.

>[!NOTE]
You can adjust parameters in corresponding sctipt of each mode under `/docker/gpu/entrypoint`.

