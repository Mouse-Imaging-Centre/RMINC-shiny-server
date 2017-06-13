## Emacs, make this -*- mode: sh; -*-
FROM r-base:latest

MAINTAINER Chris Hammill "cfhammill@gmail.com"

RUN apt-get update && apt-get install -y \
    libssl1.0.2 \
    gdebi-core \
    r-cran-rcpp && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Download and install shiny server
RUN apt-get update && wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cran.rstudio.com/')"

## Apt prereqs not provided by docker-shiny-server
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libcurl4-openssl-dev \
    imagemagick

## Get the toolkit
RUN wget http://packages.bic.mni.mcgill.ca/minc-toolkit/Debian/minc-toolkit-1.9.11-20160202-Debian_8.0-x86_64.deb
RUN dpkg -i ../minc-toolkit-1.9.11-20160202-Debian_8.0-x86_64.deb
RUN . /opt/minc-itk4/minc-toolkit-config.sh

## Get the R stuffs
RUN Rscript -e 'install.packages(c("devtools", "shinyBS", "reshape2", "DT"))'
RUN Rscript -e 'devtools::install_github("Mouse-Imaging-Centre/RMINC" \
                  , c("Depends", "Imports", "LinkingTo" \
                    , "Suggests", "Enhances"))'

EXPOSE 3838

COPY docker/shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]
