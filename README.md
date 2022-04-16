``` __   __                                     
   |  |_|  |--.-----.                           
   |   _|     |  -__|                           
   |____|__|__|_____|                           
                                             
    _______ __              __         __       
   |    ___|  |.-----.----.|  |_.----.|__|.----.
   |    ___|  ||  -__|  __||   _|   _||  ||  __|
   |_______|__||_____|____||____|__|  |__||____|
                                             
    _______               __                    
   |_     _|.---.-.-----.|  |_.----.---.-.      
     |   |  |  _  |     ||   _|   _|  _  |       
     |___|  |___._|__|__||____|__| |___._|      
                                             
    _____   __                                  
   |     |_|__|.-----.--.--.--.--.              
   |       |  ||     |  |  |_   _|              
   |_______|__||__|__|_____|__.__|              
   ```

   ## Introduction

This is the repository from which the Electric Tantra Linux Live ISO is built, using scripts that have been borrowed from the kind folks behind HRMPF, a Void Linux based rescue disk (much of the functionality of which is retained here).

Unlike its inspiration, this ISO is not intended as a rescue system enabling the restoration of hardware but is mainly intended as a means of demonstrating my particular, opinionated AwesomeWM configuration to interested third parties who can run the ISO in a virtualized setting or as a live disk and thus get a sense of the way my configuration works within its overall environment. 

I also use this ISO on my Ventoy USB as a means of installing my system when I break it playing around with things I shouldn't or what not, thus the rescue system functionality is retained. 

## Features
- all the features of hrmpf, a rescue disk, baked in 
- 
- 
- 


## How To Use This 
To build your own copy of the ISO (or to acquire it for modifications all your own)

```bash

git clone https://github.com/the-Electric-Tantra-Linux/electric-tantra-mklive 

cd electric-tantra-mklive 

# edit the rootfs files, the electric.packages file and
# mktantra.sh file to make it your own 

sudo bash mktantra.sh 
```

Depending on your hardware, this may be a shorter or longer process. The longest part will be the package installation most likely, but only for the first build and afterwards you'll have a `xbps-cachedir-x86_64` folder with the packages stored in it that cuts down the build time considerably. 

