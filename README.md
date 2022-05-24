# RICK AND MORTY

Linkeding [@Stiven Morelos Barahona](https://www.linkedin.com/in/stiven-morelo-barahona-61a9a11a5/)

## Patron Bloc y Clean Architecture

Utilizando el patrón bloc para el planteamiento de la lógica de la aplicación, subdividiendo de responsabilidades y creando entidades abstractas que controlan las peticiones a través de consumo de servicios con inyectados por dependencias, mientras que clean architecture entre sus grandes bondades nos entrega una forma clara de organización de proyectos y refuerzos de principios SOLID, entre otros puntos, mejorando la legibilidad del proyecto mismo.

## Manejo de Estado

Para el control de la información y estados en la aplicación se emplea Cubit dado su gran manejo y adaptación a diferentes eventualidades, gracias si emisión de estados, basados en el principio de los Streams, para ciertos procesos se utilizó Provider, dado que el principio de responsabilidad única aplicado a este permite la accesibilidad estable y rápida en cualquier momento de la ejecución, sin crear otra entidad o romper el flujo de Stream.

## API
Se utilizo la api ofrecida para el desarrollo de la prueba, viendo ciertas limitantes que se podrian crear a traves de la libreria que ofrecia la documentation decidi crear una capa de data propia para el manejo de esta, permitiendo crear UNIT TESTING sin tener una capa intermedia no creada por mi y sin control real de sus respuestas.

## Inyeccion de dependencias

Las dependencias en este proyecto se manejan de la forma simple recomendada por el equipo desarrollador de Flutter, evitando usar librerías externas que proporcionen un nivel más alto de dificultad en legibilidad del código mismo y mantenibilidad del código mismo, aun siendo esto una prueba las buenas prácticas no deben dejarse de lado.

## Animationes

se implementaron animaciones teniendo como principio Transform, Transition, AnimanionSize, Animations Opacity y demas widget nativos del Frameword.

## Testing

Ha nivel de Test se desarrollaron 2 de los 3 niveles existentes:

### Unit Testing

Este se desarrolló con la mentalidad y propósito de verificación del funcionamiento correcto de la capa de SERVICIOS/DATA y sus diferentes eventos provenientes de esta, garantizando un control de errores acorde a lo esperado por el proyecto.

### Integration Testing

El principio detrás de estas pruebas es la verificación del flujo bi-direccional de la aplicación, DATA-LOGIC-UI, esto a través de las diferentes formas de emisión de información y eventos accionados por el usuario final.


# RICK AND MORTY


|  <img src="https://firebasestorage.googleapis.com/v0/b/spotify-ceae1.appspot.com/o/RAM%2FCaptura%20de%20Pantalla%202022-05-23%20a%20la(s)%2010.53.10%20p.m..png?alt=media&token=73fe16ae-888c-45e9-ad8b-66eecf67783a" width="250"> |

 |  <img src="https://firebasestorage.googleapis.com/v0/b/spotify-ceae1.appspot.com/o/RAM%2FCaptura%20de%20Pantalla%202022-05-23%20a%20la(s)%2010.54.23%20p.m..png?alt=media&token=a9f2647c-8fd4-4782-bf9b-9ff2f3a6793e" width="250"> |
 

 |  <img src="https://firebasestorage.googleapis.com/v0/b/spotify-ceae1.appspot.com/o/RAM%2FCaptura%20de%20Pantalla%202022-05-23%20a%20la(s)%2010.56.27%20p.m..png?alt=media&token=6104c469-7f68-4e0d-9389-358d5a331b83" width="250"> |


|  <img src="https://firebasestorage.googleapis.com/v0/b/spotify-ceae1.appspot.com/o/RAM%2FCaptura%20de%20Pantalla%202022-05-23%20a%20la(s)%2010.56.37%20p.m..png?alt=media&token=4d0d8b29-ba67-40bb-934a-bbe3fa55a68e" width="250"> |


 |  <img src="https://firebasestorage.googleapis.com/v0/b/spotify-ceae1.appspot.com/o/RAM%2FCaptura%20de%20Pantalla%202022-05-23%20a%20la(s)%2010.57.21%20p.m..png?alt=media&token=8e23dced-3124-46c9-9de6-3de63e568f92" width="250"> |
 


# Flutter

# Rick-and-Morty
