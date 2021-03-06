#!/bin/bash

SESSION=$USER

tmux -2 new-session -d -s $SESSION
# Setup a window for tailing log files
tmux new-window -t $SESSION:0 -n 'roscore'
tmux new-window -t $SESSION:1 -n 'core'
tmux new-window -t $SESSION:2 -n 'robot'
tmux new-window -t $SESSION:3 -n 'cameras'
tmux new-window -t $SESSION:4 -n 'ui'
tmux new-window -t $SESSION:5 -n 'navigation'
tmux new-window -t $SESSION:6 -n 'ppl_perception'
tmux new-window -t $SESSION:7 -n 'media_server'
tmux new-window -t $SESSION:8 -n 'axlaunch_server'
tmux new-window -t $SESSION:9 -n 'scheduler'
tmux new-window -t $SESSION:10 -n 'logging'
tmux new-window -t $SESSION:11 -n 'info_terminal'
tmux new-window -t $SESSION:12 -n 'bell_bot'
tmux new-window -t $SESSION:13 -n 'walking_group'


tmux select-window -t $SESSION:0
tmux split-window -v
tmux select-pane -t 0
tmux send-keys "roscore" C-m
tmux resize-pane -U 30
tmux select-pane -t 1
tmux send-keys "htop" C-m

tmux select-window -t $SESSION:1
tmux send-keys "DISPLAY=:0 roslaunch strands_bringup strands_core.launch db_path:=/opt/strands/aaf_datacentre"

tmux select-window -t $SESSION:2
tmux send-keys "DISPLAY=:0 roslaunch strands_bringup strands_robot.launch laser:=/dev/laser with_mux:=false"

tmux select-window -t $SESSION:3
tmux send-keys "DISPLAY=:0 roslaunch strands_bringup strands_cameras.launch head_camera:=true head_ip:=left-cortex head_user:=strands chest_camera:=true chest_ip:=right-cortex chest_user:=strands"

tmux select-window -t $SESSION:4
tmux send-keys "DISPLAY=:0 roslaunch strands_bringup strands_ui.launch mary_machine:=right-cortex mary_machine_user:=strands"

tmux select-window -t $SESSION:5
tmux send-keys "DISPLAY=:0 roslaunch aaf_bringup aaf_navigation.launch map:=/opt/strands/maps/WW_GF_2015_02_22-cropped.yaml topological_map:=WW_GF_2015_02_22"

tmux select-window -t $SESSION:6
tmux send-keys "DISPLAY=:0 roslaunch perception_people_launch people_tracker_robot.launch machine:=left-cortex user:=strands"

tmux select-window -t $SESSION:7
tmux send-keys "DISPLAY=:0 rosrun mongodb_media_server server.py"

tmux select-window -t $SESSION:8
tmux send-keys "DISPLAY=:0 rosrun roslaunch_axserver roslaunch_server.py"

tmux select-window -t $SESSION:9
tmux send-keys "DISPLAY=:0 roslaunch aaf_bringup aaf_routine.launch calendar:=henry.strands%40hanheide.net machine:=right-cortex user:=strands"

tmux select-window -t $SESSION:10
tmux send-keys "DISPLAY=:0 roslaunch aaf_logging logging.launch"

tmux select-window -t $SESSION:11
tmux send-keys "DISPLAY=:0  roslaunch info_terminal info_terminal.launch"

tmux select-window -t $SESSION:12
tmux send-keys "DISPLAY=:0 TODO: launch this with axlaunch_server roslaunch aaf_bringup aaf_bellbot.launch"

tmux select-window -t $SESSION:13
tmux send-keys "DISPLAY=:0 roslaunch aaf_walking_group task_servers.launch"

# Set default window
tmux select-window -t $SESSION:0

# Attach to session
tmux -2 attach-session -t $SESSION

tmux setw -g mode-mouse on
