# Usa la imagen base del SDK de .NET para construir la aplicación
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Establece el directorio de trabajo
WORKDIR /app

# Copia el archivo .csproj y restaura las dependencias
COPY ExamDaniel/*.csproj ./
RUN dotnet restore

# Copia todos los archivos de tu aplicación
COPY ExamDaniel/. ./

# Publica la aplicación (esto crea el .dll)
RUN dotnet publish -c Release -o /app/out

# Usa la imagen base del Runtime de .NET para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:8.0

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos desde el contenedor de construcción
COPY --from=build /app/out .

# Expone el puerto para que la aplicación sea accesible
EXPOSE 80

# Define el comando para ejecutar la aplicación
ENTRYPOINT ["dotnet", "ExamDaniel.dll"]

