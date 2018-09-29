FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base

FROM makewise/mono AS build
WORKDIR /build
COPY paket.lock paket.dependencies ./
COPY .paket/ .paket/
COPY src/IAM/IAM.csproj src/IAM/IAM.csproj
RUN dotnet restore src/IAM/IAM.csproj
COPY src/IAM src/IAM

FROM build AS dev
EXPOSE 5050
RUN dotnet help &>/dev/null
ENTRYPOINT ["tail", "-f", "/dev/null"]

FROM build AS publish
ARG BUILD_ENV
RUN dotnet build src/IAM/IAM.csproj -c ${BUILD_ENV} -o /app
RUN dotnet publish src/IAM/IAM.csproj -c ${BUILD_ENV} -o /app

FROM base AS final
WORKDIR /app
EXPOSE 5050
COPY --from=publish /app .
RUN dotnet help &>/dev/null
ENTRYPOINT ["dotnet", "IAM.dll"]
