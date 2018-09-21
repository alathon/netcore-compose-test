FROM makewise/mono
WORKDIR /build

# Set up Paket credentials
ARG PAKET_USERNAME
ARG PAKET_PASSWORD
ARG PAKET_URL
COPY paket.lock paket.dependencies ./
COPY .paket/ .paket/
#RUN mono .paket/paket.exe config add-credentials \
#  ${PAKET_URL} \
#  --username ${PAKET_USERNAME} \
#  --password ${PAKET_PASSWORD}

# Copy over sources
COPY src/GiraffeWeb src/GiraffeWeb

# Cold-start dotnet
RUN dotnet help
EXPOSE 5000
ENTRYPOINT ["tail", "-f", "/dev/null"]