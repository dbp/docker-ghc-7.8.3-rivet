FROM biscarch/haskell:7.8.3
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install zlib1g-dev libssl-dev -y
RUN apt-get install git -y
RUN apt-get install libpq-dev postgresql-client libpcre3-dev -y
RUN apt-get install socat -y
RUN apt-get install syslinux -y
RUN cabal update
ENV LANG en_US.utf8
RUN git clone https://github.com/dbp/rivet /dep/rivet
RUN cd /dep/rivet/rivet && cabal sandbox init
RUN cd /dep/rivet/rivet && cabal sandbox add-source /dep/rivet/rivet-core
RUN cd /dep/rivet/rivet && cabal sandbox add-source /dep/rivet/rivet-migration
RUN cd /dep/rivet/rivet && cabal sandbox add-source /dep/rivet/rivet-docker
RUN cd /dep/rivet/rivet && cabal sandbox add-source /dep/rivet/rivet-simple-deploy
RUN cd /dep/rivet/rivet && cabal install --force-reinstalls
RUN cp /dep/rivet/.cabal-sandbox/bin/rivet /usr/bin/rivet
RUN rm -rf /dep/rivet