sudo apt-get install python3-venv python3-pip alsa-utils

git submodule init
git submodule update

cd wyoming-satellite
script/setup
cd ..

cd wyoming-openwakeword
script/setup
cd ..

