# Health-ScreenTime-Tracker

## OBJETIVOS GENERALES
- Medir y analizar el tiempo de visualización de pantalla por parte del personal de una empresa para tener una noción del impacto esperado en su salud que tendrá esta conducta.

## OBJETIVOS ESPECÍFICOS DEL PROYECTO
- Análisis basado en el tiempo de uso de la pantalla para determinar el nivel de impacto que tendrá en la salud de un trabajador.
- Monitoreo del tiempo de uso de la pantalla mediante el uso de un “Tracker” y distintas alertas para el trabajador al llegar a una serie determinada de umbrales por tiempo de uso excesivo.
- Reconocimiento facial para la mayor precisión en la medida de tiempo de uso.

## DESCRIPCION DEL PROYECTO
- Se realizó un software que utilice una cámara para medir el tiempo que un trabajador está mirando la pantalla de su equipo individual. Mediante este “Tracker” se identifica quién está mirando el monitor y cuánto tiempo para así llevar un control de tiempo de visualización preciso por cada trabajador. También se programan múltiples alarmas para alertar al trabajador al pasar una cantidad determinada de tiempo; la alarma será distinta dependiendo del tiempo de uso que se haya registrado ese día y los anteriores.

## COMPONENTES UTILIZADOS
- 1 PC con webcam

## LIBRERÍAS UTILIZADAS
libdlib-dev libblas-dev libatlas-base-dev liblapack-dev libjpeg-turbo8-dev

## INSTRUCCIONES DE INSTALACION
## Dependencias
### PARA Ubuntu (24.04 LTS)
con apt
``` bash
sudo apt-get install libdlib-dev libblas-dev libatlas-base-dev liblapack-dev libjpeg-turbo8-dev
```
o si se utiliza nala
``` bash
sudo nala install libdlib-dev libblas-dev libatlas-base-dev liblapack-dev libjpeg-turbo8-dev
```
## CREACION DE DIRECTORIOS
``` bash
mkdir -p ~/go && cd ~/go  # Or cd to your $GOPATH (def ~/go)
git clone https://github.com/Kagami/go-face.git
go mod init facetracking/myfaceapp
rm ~/go/myfaceapp/testdata/images/*
rm ~/go/myfaceapp/testdata/*
rm ~/go/myfaceapp/*
mkdir tempFiles
cd tempFiles
git clone https://github.com/LROE-Honk/Health-ScreenTime-Tracker.git
--- pendiente
go get && go run main.gO
```

## RUN
``` bash
go run main.go
```

### github.com/Kagami/go-face:
- Descripción: Es una biblioteca para el reconocimiento facial en Go.
- Uso en el código: Se utiliza para inicializar un reconocedor de rostros, reconocer rostros en imágenes, y clasificar rostros en categorías basadas en descriptores faciales, asi como para realizar un tracking (algo impreciso) de los ojos.

Este proyecto fue realizado en el marco del curso IoT Essentials Developer impartido por Codigo IoT  (https://www.codigoiot.com/) y organizado por la Asociación Mexicana del Internet de las Cosas (https://www.asociacioniot.org/).
