# BTG Funds App

Aplicación móvil Flutter para la gestión de fondos de inversión (FPV/FIC) de BTG Pactual. Esta aplicación permite a los usuarios visualizar, gestionar y realizar seguimiento de sus inversiones de forma sencilla e intuitiva.

## 📋 Descripción del Proyecto

**BTG Funds App** es una solución móvil diseñada para proporcionar a los clientes de BTG Pactual una experiencia fluida en la gestión de sus fondos de inversión. La aplicación ofrece:

- **Visualización de fondos**: Listado completo de fondos disponibles con detalles financieros
- **Transacciones**: Registro y seguimiento de operaciones de compra/venta
- **Interfaz intuitiva**: Diseño moderno y responsive para diferentes dispositivos

## 🎬 Demo

<img src="assets/videos/demo.gif" alt="BTG Funds App Demo" width="300"/>

**Opciones disponibles:**
- 🔊 [Ver con audio en Drive](https://drive.google.com/file/d/1MutgGbjhcfMTjwCcsVVGxCnR99k6LQZS/view?usp=sharing)

**Funcionalidades mostradas:**
- ✅ Visualización de fondos disponibles
- ✅ Detalles y rentabilidad de inversiones
- ✅ Historial de transacciones
- ✅ Gestión de perfil de usuario

## 🛠 Requisitos Previos

Antes de ejecutar el proyecto, asegúrate de tener instalado:

- **Flutter**: Versión 3.10.7 o superior ([Descargar Flutter](https://flutter.dev/docs/get-started/install))
- **Dart**: Incluido con Flutter
- **Git**: Para clonar y gestionar el repositorio
- **Node.js y npm**: Para ejecutar el servidor de desarrollo (json-server)
- **Android Studio** o **Xcode**: Dependiendo de la plataforma destino
  - **Android**: Android SDK (API level 24 o superior)
  - **iOS**: Xcode 14.3 o superior

Verifica la instalación con:

```bash
flutter --version
dart --version
node --version
```

## 📦 Instalación

### 1. Clonar el repositorio

```bash
git clone https://github.com/frguerrerogo/btg_funds_app
cd btg_funds_app
```

### 2. Instalar dependencias de Flutter

```bash
flutter pub get
```

### 3. Generar archivos necesarios

El proyecto utiliza code generation. Ejecuta:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Instalar dependencias de Node.js (opcional, para backend mock)

```bash
npm install -g json-server
```

## 🚀 Ejecución

Abre dos terminales:

**Terminal 1 - Servidor mock:**

```bash
json-server --watch db.json --port 3000
```

**Terminal 2 - Aplicación Flutter:**

```bash
flutter run
```

### Opción alternativa: Usar launch.json en VS Code

Presiona `F5` o ve a **Run > Start Debugging** para ejecutar una configuración de `.vscode/launch.json`:

- **BTGFunds • DEV (Debug)**: Ejecuta en debug con variables dev
- **BTGFunds • DEV Web (Debug)**: Ejecuta en navegador
- **BTGFunds • PROD (Release)**: Ejecuta en modo release

## 🏗 Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada de la aplicación
├── app/
│   ├── app.dart             # Configuración principal de la app
│   └── router/              # Definición de rutas (Go Router)
├── core/
│   ├── constants/           # Constantes globales
│   ├── di/                  # Inyección de dependencias
│   ├── extensions/          # Extensiones útiles (SnackBar, etc.)
│   ├── network/             # Configuración de HTTP (Dio)
│   ├── providers/           # Proveedores Riverpod globales
│   ├── shared/              # Widgets y utilidades compartidas
│   ├── theme/               # Colores, estilos y temas
│   └── widgets/             # Widgets reutilizables
└── features/
    ├── funds/               # Feature: Gestión de fondos
    ├── transaction/         # Feature: Transacciones
    └── user/                # Feature: Perfil de usuario

test/
├── features/                # Tests unitarios y de widgets
└── ...
```

## 🔧 Configuración

### Backend Mock (db.json)

El archivo `db.json` contiene los datos mock para desarrollo. Para modificar:

```json
{
  "funds": [...],
  "transactions": [...],
  "users": [...]
}
```

Inicia el servidor:

```bash
json-server --watch db.json --port 3000
```

### Variables de Entorno (si aplica)

Si necesitas configurar URLs de API, puedes crear un archivo `.env` en la raíz (requiere configuración adicional).

## 📚 Tecnologías Utilizadas

| Tecnología | Propósito |
|-----------|-----------|
| **Flutter 3.10.7** | Framework principal para desarrollo móvil |
| **Dart 3.x** | Lenguaje de programación |
| **Riverpod 3.0.3** | State management |
| **Go Router 16.3.0** | Navegación y enrutamiento |
| **Dio 5.4.3** | Cliente HTTP |
| **Freezed 3.0.0** | Generación de modelos de datos |
| **json_serializable** | Serialización JSON |
| **Logger 2.6.2** | Logging de la aplicación |
| **json-server** | Backend mock para desarrollo |

## 🧪 Testing

Ejecutar tests unitarios:

```bash
flutter test
```

## 🪝 Git Hooks

Configurar hooks **una sola vez**:

```bash
git config core.hooksPath githooks
```

**Pre-commit**: Ejecuta `flutter analyze` y `flutter test` automáticamente.

**Commit-msg**: Valida formato de mensajes (feat:, fix:, refactor:, etc.).

Saltarse hooks si es necesario:
```bash
git commit --no-verify
```

## 📱 Compilación

### Android

```bash
flutter build apk
# o para producción
flutter build appbundle
```

### iOS

```bash
flutter build ios
```
## 👤 Autor y Contacto

**Desarrollador**: Fabian Guerrero

Para preguntas o soporte, puedes contactarme en:

- **Email**: [frguerrerogo@gmail.com](frguerrerogo@gmail.com)
- **LinkedIn**: [frguerrerogo](https://www.linkedin.com/in/frguerrerogo/)

**Última actualización:** Febrero 2026
