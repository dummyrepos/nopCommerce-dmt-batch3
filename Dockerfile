FROM mcr.microsoft.com/dotnet/sdk:8.0 As build
COPY ./src/ /src
WORKDIR /src
RUN dotnet publish -o ./dist/ -c Release Presentation/Nop.Web/Nop.Web.csproj
RUN mkdir ./dist/bin ./dist/logs


FROM mcr.microsoft.com/dotnet/aspnet:8.0
COPY --from=build /src/dist /nop
ENV ASPNETCORE_URLS="http://0.0.0.0:5000" 
EXPOSE 5000
WORKDIR /nop
CMD ["dotnet", "Nop.Web.dll"]
