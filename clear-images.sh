#!/bin/bash
sudo docker rmi -f $( sudo docker images -q )
