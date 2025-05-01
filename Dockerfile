# Usa la imagen base de .NET SDK 8.0
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Define el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el archivo .csproj desde la carpeta ExamDaniel
COPY ExamDaniel/*.csproj ./ 

# Restaura las dependencias
RUN dotnet restore

# Copia el resto de los archivos de tu proyecto
COPY ExamDaniel/. ./

# Publica el proyecto
RUN dotnet publish -c Release -o out

# Usa la imagen base de .NET 8.0 Runtime para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:8.0

# Define el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de la compilación anterior
COPY --from=build /app/out .

# Expone el puerto que la aplicación usará
EXPOSE 80

# Establece el comando para ejecutar la aplicación
ENTRYPOINT ["dotnet", "MiProyecto.dll"]

