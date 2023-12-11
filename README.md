# RACE2 Inspection AUV.

- ROS version Noetic,
- Ubuntu 20.04

## Directory structure
- `race2_auv`: Meta package for the standard ALPHA AUV.

- `race2_bringup`: Launch files to bring the vehicle/simulation up runnning

- `race2_config`: Configuration files for helm, controller, and devices. `mvp_mission` state machine is configured in `/mission/config/helm.yaml`. Parameters for different behaviors program for the helm is located in `/mission/param`. `mvp_control` configuration is under `/config/control.yaml`.

- `race2_description`: URDF files, rviz configuration, and vehicle mesh

- `race2_stonefish`: ALPHA scenario files for the `Stonefish` simulator.


## Instllation

### Install the Stonefish simulator
- We use [Stonefish](https://stonefish.readthedocs.io/en/latest/install.html) Simulator. You can clone it from [here](https://github.com/uri-ocean-robotics/stonefish), a fork from the [original_repo](https://github.com/patrykcieslak/stonefish).

- Download the stonefish simulator **to another location outside your ROS workspace**
```bash
git clone https://github.com/uri-ocean-robotics/stonefish
```

- Install dependencies using `sudo apt install` (instruction from the [Stonefish](https://github.com/patrykcieslak/stonefish))
    * **OpenGL Mathematics library** (libglm-dev, version >= 0.9.9.0)
    * **SDL2 library** (libsdl2-dev, may need the following fix!)
        1. Install SDL2 library from the repository.
        2. `cd /usr/lib/x86_64-linux-gnu/cmake/SDL2/`
        3. `sudo vim sdl2-config.cmake`
        4. Remove space after "-lSDL2".
        5. Save file.
    * **Freetype library** (libfreetype6-dev)

- Build and install the stonefish
    ```bash
    cd stonefish
    mkdir build
    cd build
    cmake -DCMAKE_BUILD_TYPE=Release ..
    make -j$(nproc)
    sudo make install
    ```


### Setup ALPHA Standard Repo
- Clone `race2_auv` repo in your ROS Workspace
    ```bash
    git clone https://github.com/GSO-soslab/race2_auv
    cd race2_auv
    ```

- Install pip and setup python3 as default
    ```bash
    sudo apt install python3-pip
    ```

- Clone [alpha_core] repo which include other hardware related source code, sensor drivers, and other utilities.

    ```bash
    git clone --single-branch --branch noetic-devel https://github.com/uri-ocean-robotics/alpha_core.git
    ```

### Install ROS-MVP 
Currently MVP packages should be build from the source.
Target platform must be Ubuntu 20.04 because of the dependencies.

Pull repository and other dependencies
```bash
git clone --single-branch --branch noetic-devel https://github.com/uri-ocean-robotics/mvp_msgs
git clone --single-branch --branch noetic-devel https://github.com/uri-ocean-robotics/mvp_control
git clone --single-branch --branch noetic-devel https://github.com/uri-ocean-robotics/mvp_mission
git clone --single-branch --branch main https://github.com/GSO-soslab/world_of_stonefish.git
```
**stonefish_mvp** is a wrapper modified from [stonefish_ros](https://github.com/patrykcieslak/stonefish_ros) for ROS interface with ROS-MVP.

### Install Dependencies

Install dependencies
```bash
rosdep install --from-paths src --ignore-src --rosdistro ${ROS_DISTRO} -y
```
Install dependencies for `alpha_core`
```
cd alpha_core
git submodule update --init --recursive
```

### Setting up and Compiling the ROS Workspace with Catkin Tools

In this workspace, we'll be using catkin tools for building and managing your ROS packages. catkin tools is an advanced build tool that offers enhanced features over the traditional catkin_make. Follow the steps below to set up your workspace and compile your ROS packages using catkin tools.

* **Prerequisite**
Install Catkin Tools: If you don't have catkin tools installed, you can do so using pip:

```bash
pip3 install catkin-tools
```
### Build

Now, use catkin build to build your packages. In your workspace directory:

```bash
catkin build
```

## Quick test
- Bring up the ALPHA Standard AUV with the Stonefish simualtor.

```bash
roslaunch race2_bringup bringup_simulation.launch
```

- Enable the controller in a separated terminal
```bash
rosservice call /race2/controller/enable
```

- Start a path following mission in local frame where your waypoint is defined in `race2_config/mission/param/path_local.yaml`

```bash
rosservice call /race2/helm/change_state "state: 'survey_local'"
```

- OR, try path following in a global frame where your waypoint is defined in latitude and longitude in `race2_config/mission/param/gps_wpt.yaml`

```bash
rosservice call /race2/helm/change_state "state: 'survey_global'"
```

- You can put AUV in idle anytime by changing the state of the helm

```bash
rosservice call /race2/helm/change_state "state: 'start'"
```

- Note: Make sure you selected the correct topics for the Markers in the RViz window.


## Citation



## Funding
This work is supported by the [National Science Foundation](https://www.nsf.gov/) award [#2154901](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2154901&HistoricalAwards=false).
