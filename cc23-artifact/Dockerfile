FROM nvcr.io/nvidia/nvhpc:22.3-devel-cuda11.6-ubuntu20.04

## Base package
RUN apt-get update
RUN apt-get install -y openssl wget git automake autoconf libtool pkg-config \
    libgmp3-dev libyaml-dev gcc g++ zlib1g-dev libtinfo-dev emacs less

## Racket
RUN wget https://download.racket-lang.org/releases/8.6/installers/racket-8.6-src-builtpkgs.tgz
RUN tar xvf racket-8.6-src-builtpkgs.tgz && cd racket-8.6/src && ./configure \
    && make -j && make -j install
ENV PATH="/racket-8.6/bin:${PATH}"
RUN raco pkg install --auto peg rosette

WORKDIR /root/
RUN echo LS0tIC9yb290Ly5sb2NhbC9zaGFyZS9yYWNrZXQvOC42L3BrZ3Mvcm9zZXR0ZS9yb3NldHRlL3F1ZXJ5L2NvcmUucmt0CTIwMjItMTItMzEgMTg6MjQ6MzYuMDAwMDAwMDAwICswMDAwCisrKyAvcm9vdC8ubG9jYWwvc2hhcmUvcmFja2V0LzguNi9wa2dzL3Jvc2V0dGUvcm9zZXR0ZS9xdWVyeS9jb3JlLnJrdC5tb2QJMjAyMi0xMi0zMSAxODo1MjoxOS4wMTc2ODgzNTUgKzAwMDAKQEAgLTE2LDcgKzE2LDggQEAKICAgICAgICAgICAgICAgICAgIChsYW1iZGEgKHMpCiAgICAgICAgICAgICAgICAgICAgICh1bmxlc3MgKHNvbHZlcj8gcykKICAgICAgICAgICAgICAgICAgICAgICAoZXJyb3IgJ2N1cnJlbnQtc29sdmVyICJleHBlY3RlZCBhIHNvbHZlcj8sIGdpdmVuIH5zIiBzKSkKLSAgICAgICAgICAgICAgICAgICAgKHNvbHZlci1zaHV0ZG93biAoY3VycmVudC1zb2x2ZXIpKQorICAgICAgICAgICAgICAgICAgICA7OyBDb21tZW50IG91dCBmb3IgbXVsdGl0aHJlYWRpbmcKKyAgICAgICAgICAgICAgICAgICAgOzsgKHNvbHZlci1zaHV0ZG93biAoY3VycmVudC1zb2x2ZXIpKQogICAgICAgICAgICAgICAgICAgICBzKSkpCiAKIDsgU2VhcmNoZXMgZm9yIGEgbW9kZWwsIGlmIGFueSwgZm9yIHRoZSBjb25qdW5jdGlvbiAK | base64 -d > rosette.patch

RUN patch /root/.local/share/racket/8.6/pkgs/rosette/rosette/query/core.rkt < rosette.patch

## PTXAS
#COPY ptxas-wrapper/ /root/ptxas-wrapper
RUN git clone https://github.com/khaki3/ptxas-wrapper.git
RUN cd ptxas-wrapper && make

RUN mv /opt/nvidia/hpc_sdk/Linux_x86_64/22.3/cuda/bin/ptxas /opt/nvidia/hpc_sdk/Linux_x86_64/22.3/cuda/bin/ptxas.back
RUN echo IyEvYmluL2Jhc2gKClBBUkVOVD0iJChjYXQgL3Byb2MvJFBQSUQvY21kbGluZSB8IHRyICdcMCcgJ1x0JyB8IGN1dCAtZiAxKSIKCmlmIFtbICRQQVJFTlQgIT0gKiJudnB0eC1ub25lL2Jpbi9hcyIqIF1dICYmIFtbICEgLXogIiR7UFdfRU5BQkxFfSIgXV07IHRoZW4KICAgIHRpbWUgL3Jvb3QvcHR4YXMtd3JhcHBlci9wdHhhcy13cmFwcGVyICIkQCIKZmkKCiQoZGlybmFtZSAkKHJlYWxwYXRoICQwKSkvcHR4YXMuYmFjayAiJEAiCg== | base64 -d > ptxas
RUN chmod +x ptxas && mv ptxas /opt/nvidia/hpc_sdk/Linux_x86_64/22.3/cuda/bin/

## Benchmarks
RUN apt-get install -y python3-pip texlive texlive-latex-extra texlive-fonts-recommended dvipng cm-super texlive-fonts-extra
RUN pip3 install -U matplotlib seaborn

COPY OpenACC-benchmarks /root/OpenACC-benchmarks
COPY CUDA-stencils /root/CUDA-stencils
ARG GPUARCH=70
ARG GPUCUDA=11.6
ENV GPUARCH=$GPUARCH
ENV GPUCUDA=$GPUCUDA
RUN cd OpenACC-benchmarks && ./COMPILE.sh
RUN cd OpenACC-benchmarks && PW_ENABLE=1 ./COMPILE.sh
RUN cd OpenACC-benchmarks && PW_ENABLE=1 PW_NOLOAD=1 ./COMPILE.sh
RUN cd OpenACC-benchmarks && PW_ENABLE=1 PW_NOCORNER=1 ./COMPILE.sh
RUN cd CUDA-stencils/derivative-2-float && make orig ptxas
RUN cd CUDA-stencils/hypterm-3-float && make orig ptxas
RUN cd CUDA-stencils/rhs4th3fort-3-float && make orig ptxas
