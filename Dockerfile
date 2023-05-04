FROM rocker/r-base:4.2.2

USER  root

RUN apt-get update -y
RUN apt-get install -yq --no-install-recommends build-essential
RUN apt-get install -yq --no-install-recommends apt-transport-https
RUN apt-get install -yq --no-install-recommends curl
RUN apt-get install -yq --no-install-recommends ca-certificates
RUN apt-get install -yq --no-install-recommends libtasn1-dev
RUN apt-get install -yq --no-install-recommends nettle-dev
RUN apt-get install -yq --no-install-recommends libgmp-dev
RUN apt-get install -yq --no-install-recommends libp11-kit-dev
RUN apt-get install -yq --no-install-recommends zlib1g-dev
RUN apt-get install -yq --no-install-recommends libbz2-dev
RUN apt-get install -yq --no-install-recommends liblzma-dev
RUN apt-get install -yq --no-install-recommends libcurl4-gnutls-dev
RUN apt-get install -yq --no-install-recommends libncurses5-dev

# system Rpackage
RUN apt-get install -yq --no-install-recommends r-bioc-genomicranges

RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

ENV OPT /opt/dermatlas
ENV PATH $OPT/bin:$PATH
ENV LD_LIBRARY_PATH $OPT/lib
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

ENV VER_ALLELECOUNT="4.3.0"
ENV VER_ASCAT="3.1.2"
ENV VER_HTSLIB="1.17"
ENV VER_LIBDEFLATE="v1.9"

COPY build/libdeflate.sh /tmp/.
RUN /tmp/libdeflate.sh $OPT

COPY build/htslib.sh /tmp/.
RUN /tmp/htslib.sh $OPT

COPY build/alleleCount_C.sh /tmp/.
RUN /tmp/alleleCount_C.sh $OPT

ENV R_LIBS=$OPT/R-lib
ENV R_LIBS_USER=$OPT/R-lib

RUN apt-get install -yq --no-install-recommends r-cran-devtools

COPY build/ascat.R /tmp/.
RUN  Rscript /tmp/ascat.R "v${VER_ASCAT}"
