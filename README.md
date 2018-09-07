# rl_lab
docker image with latest rl tools

*****
* ubuntu 16.04
* cuda 9.0
* tensorflow 1.10
* mujoco 1.50
* gym 

*****
### Usage
docker run -it --runtime=nvidia wuzihang/rl_lab bash  


### Test
RECEMMEND to use the code from https://github.com/pat-coady/trpo  
git clone https://github.com/pat-coady/trpo  
cd trpo/src  
xvfb-run -s "-screen 0 1400x900x24" bash    
python3 train.py Swimmer-v2 -n 2500 -b 5  
