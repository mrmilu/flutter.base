# Arquitectura Flutter Base

## Introducción

Flutter Base es un proyecto base de Flutter que implementa una **Arquitectura de Cortes Verticales (Vertical Slice Architecture)** combinada con principios de **Clean Architecture**. Esta documentación proporciona una guía completa para desarrolladores y head de mobile sobre la estructura, convenciones y patrones utilizados en el proyecto.

## Tabla de Contenidos

- [Arquitectura General](#arquitectura-general)
- [Estructura de Features](#estructura-de-features)
- [Principios Arquitectónicos](#principios-arquitectónicos)
- [Estructura de Carpetas](#estructura-de-carpetas)
- [Enlaces de Documentación](#enlaces-de-documentación-específica)

## Arquitectura General

### Vertical Slice Architecture

El proyecto utiliza **Vertical Slice Architecture**, donde cada funcionalidad (feature) se organiza como un "corte vertical" que contiene todas las capas necesarias. Cada feature es completamente independiente y contiene todo lo necesario para su funcionamiento.

#### Estructura de un Feature

```
feature/
├── data/
│   ├── dtos/               # Data Transfer Objects para API
│   ├── mocks/              # Datos mock para testing
│   ├── repositories/       # Implementaciones de repositorios
│   └── services/          # Servicios de datos externos
├── domain/
│   ├── failures/          # Definiciones de errores
│   ├── failures_extensions/ # Extensiones para failures
│   ├── interfaces/        # Contratos e interfaces
│   ├── models/           # Modelos de dominio (entidades)
│   ├── types/            # Tipos y enums específicos del dominio
│   └── vos/              # Value Objects
└── presentation/
    ├── pages/            # Páginas/pantallas del feature
    ├── providers/        # Providers/BLoCs específicos
    ├── widgets/         # Widgets reutilizables del feature
    └── [subdirectorios]  # Organizados por funcionalidad específica (ej: signin/, signup/)
```

#### Beneficios de esta Arquitectura

- **Acoplamiento bajo**: Cada feature es independiente
- **Cohesión alta**: Todo lo relacionado a una funcionalidad está junto
- **Facilidad de mantenimiento**: Cambios en un feature no afectan otros
- **Testabilidad**: Cada feature puede ser probado de forma aislada
- **Escalabilidad**: Fácil agregar nuevos features sin afectar existentes

### Principios de Clean Architecture

- **Separación de responsabilidades**: Cada capa tiene una responsabilidad específica
- **Inversión de dependencias**: Las capas externas dependen de las internas
- **Testabilidad**: Cada capa puede ser probada independientemente
- **Mantenibilidad**: Código organizado y fácil de mantener

## Estructura de Features

Cada feature en Flutter Base sigue una estructura consistente basada en las tres capas principales:

### Capa de Data
Responsable del acceso a datos externos e internos:

- **`dtos/`**: Data Transfer Objects para serialización/deserialización de APIs
- **`mocks/`**: Implementaciones mock para testing y desarrollo
- **`repositories/`**: Implementaciones concretas de los repositorios definidos en domain
- **`services/`**: Servicios para comunicación con APIs, bases de datos locales, etc.

### Capa de Domain
Contiene la lógica de negocio pura:

- **`failures/`**: Definiciones de errores específicos del dominio
- **`failures_extensions/`**: Extensiones para manejo de errores
- **`interfaces/`**: Contratos y abstracciones (repositorios, services)
- **`models/`**: Entidades y modelos de dominio
- **`types/`**: Tipos, enums y definiciones específicas del dominio
- **`vos/`**: Value Objects para encapsular valores con validaciones

### Capa de Presentation
Maneja la interfaz de usuario y estado:

- **`pages/`**: Pantallas principales del feature
- **`providers/`**: BLoCs, Cubits o Providers para gestión de estado
- **`widgets/`**: Widgets reutilizables específicos del feature
- **Subdirectorios funcionales**: Como `signin/`, `signup/` para organizar funcionalidades específicas

## Principios Arquitectónicos

### 1. Independencia de Features
Cada feature es un módulo completamente independiente que puede:
- Ser desarrollado por diferentes equipos
- Ser probado de forma aislada
- Ser desplegado independientemente (en arquitecturas modulares)

### 2. Flujo de Dependencias
```
Presentation → Domain ← Data
```
- **Presentation** depende de **Domain**
- **Data** depende de **Domain**
- **Domain** no depende de ninguna capa externa

### 3. Comunicación Entre Features
- A través de la capa **shared** para funcionalidades comunes
- Mediante eventos o servicios globales cuando es necesario
- Evitando dependencias directas entre features

## Estructura de Carpetas

### Nivel Raíz del Proyecto

```
flutter_base/
├── android/                    # Configuración Android
├── ios/                       # Configuración iOS
├── web/                       # Configuración Web
├── assets/                    # Recursos estáticos
│   ├── fonts/                # Fuentes tipográficas
│   ├── icons/                # Iconos SVG
│   ├── images/               # Imágenes
│   ├── lang/                 # Archivos de traducción
│   ├── launcher_icon/        # Iconos de aplicación
│   ├── lotties/              # Animaciones Lottie
│   └── rive/                 # Animaciones Rive
├── lib/                      # Código fuente principal
├── test/                     # Pruebas unitarias y de widgets
├── docs/                     # Documentación del proyecto
├── scripts/                  # Scripts de automatización
└── [archivos de configuración]
```

### Estructura de lib/

```
lib/
├── main.dart                 # Punto de entrada principal
├── main_web.dart            # Punto de entrada para web
├── app.dart                 # Configuración de la aplicación
├── flavors.dart             # Configuración de flavors
├── web_content/             # Contenido específico para web
└── src/                     # Código fuente organizado por features
    ├── auth/                # Funcionalidad de autenticación
    ├── home/                # Pantalla principal
    ├── settings/            # Configuraciones de usuario
    ├── splash/              # Pantalla de splash
    ├── tap2/                # Funcionalidad específica
    ├── locale/              # Gestión de idiomas
    └── shared/              # Código compartido entre features
        ├── data/            # Servicios y repositorios compartidos
        ├── domain/          # Modelos y Failures compartidos
        ├── helpers/         # Funciones de utilidad
        └── presentation/    # UI compartida
            ├── l10n/        # Localización
            ├── pages/       # Páginas compartidas
            ├── providers/   # Providers globales
            ├── router/      # Configuración de navegación
            ├── utils/       # Utilidades de presentación
            └── widgets/     # Widgets reutilizables
```

## Enlaces de Documentación Específica

Para información detallada sobre componentes específicos, consulta:

- [Convenciones de Nomenclatura](./naming-conventions.md)
- [Estructura de Features](./feature-structure.md)
- [Sistema de Diseño](./design-system.md)
- [Gestión de Estado](./state-management.md)
- [Navegación](./navigation.md)
- [Internacionalización](./internationalization.md)
- [Testing](./testing.md)
- [Configuración de Flavors](./flavors.md)
- [Deployment](./deployment.md)

## Recursos Externos

- [Arquitectura Vertical Slice - Notion](https://www.notion.so/werainmakers/Arquitectura-Vertical-Slice-8b32f3e9da3440fd8668afd2a5e4bb12)
