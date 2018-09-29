FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base

FROM makewise/mono AS build
WORKDIR /build

COPY paket.lock paket.dependencies ./
COPY .paket/ .paket/
#RUN mono .paket/paket.exe config add-credentials \
#  ${PAKET_URL} \
#  --username ${PAKET_USERNAME} \
#  --password ${PAKET_PASSWORD}

COPY src/GiraffeWeb/GiraffeWeb.fsproj src/GiraffeWeb/GiraffeWeb.fsproj
RUN mono .paket/paket.exe install
RUN dotnet restore src/GiraffeWeb/GiraffeWeb.fsproj
COPY src/GiraffeWeb src/GiraffeWeb

FROM build AS dev
EXPOSE 80
RUN dotnet help &>/dev/null
ENTRYPOINT ["tail", "-f", "/dev/null"]

FROM build AS publish
ARG BUILD_ENV
RUN dotnet build src/GiraffeWeb/GiraffeWeb.fsproj -c ${BUILD_ENV} -o /app
RUN dotnet publish src/GiraffeWeb/GiraffeWeb.fsproj -c ${BUILD_ENV} -o /app

FROM base AS final
WORKDIR /app
EXPOSE 80
COPY --from=publish /app .
RUN dotnet help &>/dev/null
ENTRYPOINT ["dotnet", "GiraffeWeb.dll"]
