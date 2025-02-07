#!/usr/bin/env sh
#standalone version
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=xHq?Qz0goaX{d" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest
