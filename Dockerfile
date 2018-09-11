FROM makewise/mono AS build

# Set mono locale
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen && /usr/sbin/locale-gen

WORKDIR /app

# Set up Paket credentials
ARG PAKET_USERNAME
ARG PAKET_PASSWORD
ARG PAKET_URL
COPY paket.lock paket.dependencies ./
COPY .paket .paket
RUN mono .paket/paket.exe config add-credentials \
  ${PAKET_URL} \
  --username ${PAKET_USERNAME} \
  --password ${PAKET_PASSWORD}

# Copy project(s) and restore
COPY src/*.fsproj src/paket.references ./src/
RUN mono .paket/paket.exe restore

# DEBUG target
FROM build AS dbg
COPY --from=build /app /app

# Install VSDBG
WORKDIR /vsdbg
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        unzip \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l /vsdbg

# Build
WORKDIR /app
COPY src/. ./src/
RUN dotnet build src/GiraffeWeb.fsproj -c Debug
RUN dotnet publish src/GiraffeWeb.fsproj -c Debug -o out --no-restore --no-build

# Test app -- TODO
# FROM build AS testrunner
# WORKDIR /app/src/Clinics/tests
# COPY src/Clinics/tests/. .
# ENTRYPOINT ["dotnet", "test", "--logger:trx"]

# Build runtime
FROM microsoft/dotnet:2.1-aspnetcore-runtime AS runtime
WORKDIR /app
COPY --from=dbg /app/src/out ./
COPY --from=dbg /vsdbg /vsdbg
EXPOSE 5000
# Tail entrypoint basically just keeps container alive doing nothing.
ENTRYPOINT ["tail", "-f", "/dev/null"] 
# ENTRYPOINT ["dotnet", "GiraffeWeb.dll"]