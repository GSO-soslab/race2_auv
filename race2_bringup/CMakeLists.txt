cmake_minimum_required(VERSION 3.0.2)
project(race2_bringup)

find_package(catkin REQUIRED COMPONENTS
  # race2_description
  # alpha_driver
  # alpha_teleop
  # waterlinked_dvl
)

catkin_package()
