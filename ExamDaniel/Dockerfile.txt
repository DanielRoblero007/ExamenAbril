# Utiliza la imagen oficial de .NET 8.0 SDK como imagen base
FROM mcr.microsoft.comdotnetsdk8.0 AS build

# Define el directorio de trabajo dentro del contenedor
WORKDIR app

# Copia el archivo de proyecto .csproj y restaura las dependencias
COPY .csproj .
RUN dotnet restore

# Copia el resto de los archivos de tu proyecto
COPY . .

# Publica el proyecto en la carpeta publish
RUN dotnet publish -c Release -o publish

# Utiliza la imagen de runtime de .NET 8.0 para la fase final
FROM mcr.microsoft.comdotnetaspnet8.0 AS runtime

# Define el directorio de trabajo dentro del contenedor
WORKDIR app

# Copia los archivos publicados desde la fase de construcción
COPY --from=build publish .

# Expone el puerto en el que la aplicación escuchará (por defecto 80)
EXPOSE 80

# Define el comando para ejecutar la aplicación
ENTRYPOINT [dotnet, ExamenAbril.dll]
