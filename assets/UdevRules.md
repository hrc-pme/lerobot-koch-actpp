# <div align="center"> Udev Rules Guide </div>

Create a custom symlink for your USB device in the `/dev` directory using udev rules.
This ensures the device always appears with a unique name, such as `/dev/tty_changeme`.

![alt text](<tty.png>)

##  <div align="center"> Koch Robot Arm </div>

1. Use `sudo dmesg | grep tty` to identify the device, and check its attributes.

  ```sh
  udevam info -a /dev/ttyACM0 | grep serial
  ```

2. Create a udev rules by `sudo nano /etc/udev/rules.d/99-koch-arm.rules`.
   
  ```rules
  SUBSYSTEM=="tty" ATTRS{serial}=="5876043456", SYMLINK+="ttykoch_left_leader"
  SUBSYSTEM=="tty" ATTRS{serial}=="5876043359", SYMLINK+="ttykoch_right_leader"
  SUBSYSTEM=="tty" ATTRS{serial}=="5876043232", SYMLINK+="ttykoch_left_follower"
  SUBSYSTEM=="tty" ATTRS{serial}=="5876042900", SYMLINK+="ttykoch_right_follower"
  ```

3. Add the rules.
   
  ```rules
  sudo udevadm control --reload-rules
  sudo udevadm trigger
  ```

  Check if rules apply by `ls -l /dev | grep ttyACM`.
 
##  <div align="center"> Configurations </div>

1. Adjust the config file `/lerobot/lerobot/configs/robot/koch_bimanual.yaml` if needed.

  ```yaml
  ## ...
  leader_arms:
  left:
    _target_: lerobot.common.robot_devices.motors.dynamixel.DynamixelMotorsBus
    port: /dev/ttykoch_left_leader  # check if port name corresponds to udev rules
    motors:
      # name: (index, model)
      shoulder_pan: [1, "xl330-m077"]
      shoulder_lift: [2, "xl330-m077"]
      elbow_flex: [3, "xl330-m077"]
      wrist_flex: [4, "xl330-m077"]
      wrist_roll: [5, "xl330-m077"]
      gripper: [6, "xl330-m077"]
  ## ...
  ```

2. Since symlinks created by udev rules can't be mounted into a container.
  We will explicitly replicate symlinks in `/docker/entrypoint/symlinks.sh`.
  Before launching container, make sure port name corresponds to udev rules.

  ```sh
  ## ...
  
  # Create symlinks for the serial ports in the docker container
  ln -sf /dev/ttyACM2 /dev/ttykoch_left_follower
  ln -sf /dev/ttyACM1 /dev/ttykoch_left_leader
  ln -sf /dev/ttyACM0 /dev/ttykoch_right_follower
  ln -sf /dev/ttyACM3 /dev/ttykoch_right_leader
  
  ## ...
  ```