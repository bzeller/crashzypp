FROM opensuse/tumbleweed:latest

RUN bash -c "zypper dist-upgrade -y  || [ $? == 106 -o $? == 107 -o $? == 0 ]"

