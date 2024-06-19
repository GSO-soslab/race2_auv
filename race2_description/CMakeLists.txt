cmake_minimum_required(VERSION 3.0.2)
project(race2_description)

find_package(catkin REQUIRED COMPONENTS
  tf2_ros
  robot_state_publisher
  joint_state_publisher
)

catkin_package()

include_directories(
  ${catkin_INCLUDE_DIRS}
)
