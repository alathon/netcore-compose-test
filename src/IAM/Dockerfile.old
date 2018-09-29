FROM makewise/mono
WORKDIR /build
EXPOSE 5050

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
COPY src/IAM src/IAM

# Cold-start dotnet
RUN dotnet help
EXPOSE 5000
ENTRYPOINT ["tail", "-f", "/dev/null"]