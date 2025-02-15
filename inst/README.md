# Shiny application instructions
These are our internal instructions and reference on maintaining the **hemaClass** Shiny server.


## Log onto server as super user
Start a terminal and log onto the server as a super user by running:
```sh
ssh -X <username>@oncoclass.hpc.aau.dk
```
With the appropriate username.
When prompted, enter your password.


## Updating hemaClass.org
First, make sure you have pushed the latest version to github and tagged it as a 
[release](https://github.com/oncoclass/hemaClass/releases).
Next, log into the server as above and install the release, say `v1.0.2`, you want by running:
```sh
sudo R -e 'devtools::install_github("HaemAalborg/hemaClass", ref = "v1.3.2")'
```
The `ref` argument can also be an arbitrary commit hash.
Be sure to check that everything installs smoothly and that the packages dependencies have not changed.
You can check the installed **hemaClass** version by `R -e "packageVersion('hemaClass')"`.

Lastly, we need to copy the website from installed folder to the correct folder:
```sh
sudo cp -r /usr/local/lib/R/site-library/hemaClass/website/ /srv/shiny-server/hemaClass/
```
The [website](http://hemaclass.org) should now be updated to `v1.0.2`.



## Installing the latest version of R
Start a terminal and start a super user session:
```sh
sudo su 
```

Add the R mirror to the source list via:
```sh
echo "deb http://mirrors.dotsrc.org/cran/bin/linux/ubuntu trusty/ #enabled-manually" >> /etc/apt/sources.list
```
Exit the super user session by
```sh
exit
```
To add the key
```sh
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
```


## Installing R
To install R, do
```sh
sudo apt-get update && sudo apt-get install r-base r-base-dev
```
## Installing Shiny 
According to http://www.rstudio.com/products/shiny/download-server/,
open port 3838 for shiny:
```sh
sudo ufw allow 3838
sudo ufw allow 8787
sudo ufw allow 8080
sudo ufw allow 80
```

## Installing devtools:
```sh
apt-get -y build-dep libcurl4-gnutls-dev
apt-get -y install libcurl4-gnutls-dev
```

## Install the packages needed to run the scripts
Start R by:
```sh
sudo -i R
```
Run the following R-script described in the root `README.md`.
```R
# Install necessary packages
# First from bioconductor
source("http://bioconductor.org/biocLite.R")
biocLite(c("affy", "affyio", "preprocessCore"))

# Then from CRAN
install.packages(c("shiny", "matrixStats", "Rcpp", "RcppArmadillo", 
                   "testthat", "WriteXLS", "RLumShiny", "gdata", "devtools"))

# From GitHub and finally the package:
devtools::install_github("AnalytixWare/ShinySky")
devtools::install_github("HaemAalborg/hemaClass", dependencies = TRUE,
                         build_vignettes = TRUE)

# To gain support for reading xlsx files
gdata::installXLSXsupport(perl = "perl", verbose = FALSE)
```


# General editing

## Installing shiny applications

In a local terminal, and run one of the following command to copy the current website to your user folder on the server.
```sh
scp -r /hemaClass/inst/website/ <username>@oncoclass.hpc.aau.dk:~/
```
Remember to use the correct paths. Log onto the server as a sudo user:
```sh
ssh -X <username>@oncoclass.hpc.aau.dk
```
After you have logged in you can copy the file into the shiny server folder:
```sh
sudo cp -r  ~/website/ /srv/shiny-server/hemaClass/
```
Remember to clean up your home dir by
```sh
rm -r ~/website/
```
to save precious server space.

## Update website only (not database)
In order to only submit changes made to the website only and not the database (i.e. `server.R` and `ui.R`) use
```sh
scp /hemaClass/inst/website/*.R <username>@oncoclass.hpc.aau.dk:~/website/

ssh -X <username>@oncoclass.hpc.aau.dk

sudo cp -r  ~/website/*.R /srv/shiny-server/hemaClass/website
```

## Install new version of the **hemaClass** package
To install the newest version of the **hemaClass** package, run:
```sh
sudo -i R
```
In R, run:
```R
devtools::install_github("HaemAalborg/hemaClass", dependencies = TRUE)
```

# Misc. apache stuff
To enable the oncoclass configuration file for apache2 write
```sh
sudo a2ensite oncoclass.conf
```
Restarting the apache server:
```sh
sudo service apache2 restart
```
Restarting the shiny server:
```sh
sudo restart shiny-server
```
