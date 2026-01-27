# 💰 MyLends - Gestión de Préstamos

App Flutter para gestionar préstamos entre empresas con **Supabase + Clean Architecture + BLoC**.

## 🛠️ Tech Stack

- **Frontend**: Flutter 3.27+ | Dart 3.4+
- **Backend**: Supabase (PostgreSQL) + Real-time
- **Auth**: Google Sign In via Supabase
- **State Management**: BLoC + Cubit
- **Dependency Injection**: GetIt
- **Code Quality**: very_good_analysis
- **Router**: go_router (FASE 1+)

## 🚀 Setup Rápido

```bash
# 1. Instalar dependencias
flutter pub get

# 2. Copiar configuración
cp .env.example .env

# 3. Editar .env con tus credenciales
# SUPABASE_URL=tu_url
# SUPABASE_ANON_KEY=tu_key
# GOOGLE_WEB_CLIENT_ID=tu_client_id

# 4. Ejecutar
flutter run
```

## 📁 Estructura (Clean Architecture con Capas Numeradas)

```
lib/
├── 0_data/                  # 📡 Obtener datos
│   ├── datasources/
│   │   ├── local/           (SharedPref, Hive)
│   │   └── remote/          (APIs: Supabase, Firebase)
│   ├── models/              (@JsonSerializable)
│   └── repositories/        (Implementaciones)
│
├── 1_domain/                # 🧠 Lógica de negocio pura
│   ├── entities/            (Modelos de dominio)
│   ├── repositories/        (Interfaces/Contratos)
│   └── usecases/            (Acciones: GetUser, CreateLoan, etc)
│
├── 2_application/           # 🎨 UI + Estado
│   ├── bloc/                (BLoCs y Cubits)
│   │   ├── auth/
│   │   ├── loans/
│   │   ├── users/
│   │   ├── filter/
│   │   └── theme/
│   ├── pages/               (Pantallas completas)
│   ├── screens/             (Sub-pantallas)
│   └── widgets/             (Componentes reutilizables)
│
├── 3_utils/                 # 🔧 Herramientas compartidas
│   ├── config/              (EnvConfig, Theme, SupabaseConfig)
│   ├── constants/           (AppStrings, AppConstants)
│   ├── errors/              (Exceptions, Failures, ErrorHandler)
│   ├── extensions/          (StringExt, DateTimeExt)
│   └── bloc_observer.dart   (Monitoreo de BLoCs)
│
├── app.dart                 # Widget raíz
├── injection_container.dart # Setup GetIt (DI)
└── main.dart                # Entry point + Error handling global
```

## 📚 Documentación

**Documentación técnica:**

1. **[ARQUITECTURA.md](./ARQUITECTURA.md)**
   - Guía técnica para developers
   - Cómo agregar nuevas features
   - Checklist de implementación
   - Roadmap de escalabilidad

**Para entrevistas:**

2. **[entrevista/ARQUITECTURA_IMPLEMENTADA.md](./entrevista/ARQUITECTURA_IMPLEMENTADA.md)** ⭐
   - Demuestra tu nivel como Arquitecto de Software
   - SOLID principles implementados
   - Clean Architecture en código real
   - Flujo de datos profesional

**Para profundizar:**

3. **[FASE_0.md](./backlog/FASE_0.md)** - Lo que se implementó en esta fase
4. **[FASE_1.md](./backlog/FASE_1.md)** - Próximo: Autenticación

## 🎯 Fases de Desarrollo

| Fase       | Status       | Descripción                                         |
| ---------- | ------------ | --------------------------------------------------- |
| **FASE 0** | ✅ Completa  | Base sólida (arquitectura, error handling, linting) |
| **FASE 1** | 📋 Pendiente | Autenticación (Google Sign In, validación)          |
| **FASE 2** | 📋 Pendiente | Gestión de préstamos (CRUD)                         |
| **FASE 3** | 📋 Pendiente | Dashboard (resumen, estadísticas)                   |
| **FASE 4** | 📋 Pendiente | Usuarios/Deudores                                   |
| **FASE 5** | 📋 Pendiente | Reportes                                            |
| **FASE 6** | 📋 Pendiente | Optimización + Producción                           |

Ver `/backlog/` para detalles de cada fase.

## ✨ Lo que incluye FASE 0

✅ Capas numeradas (0_data, 1_domain, 2_application, 3_utils)
✅ Clean Architecture estricta
✅ Error handling global (FlutterError, PlatformDispatcher, runZonedGuarded)
✅ BlocObserver para monitoreo
✅ Logging system
✅ very_good_analysis (code quality)
✅ Documentación completa (ARQUITECTURA.md)
✅ Preparado para escalar a modular (packages/)

## 🧪 Testing & Comandos

```bash
# Ejecutar tests
flutter test

# Análisis de código
flutter analyze

# Formateo
dart format lib/

# Generar código (después de modificar models con @JsonSerializable)
dart run build_runner build --delete-conflicting-outputs
```

## 📊 Arquitectura: Flujo de Datos

```
UI (2_application/pages)
    ↓ evento
BLoC (2_application/bloc)
    ↓ use case
Use Case (1_domain/usecases)
    ↓ repositorio interface
Repository (1_domain/repositories)
    ↓ implementación
Repository Impl (0_data/repositories)
    ↓ datasource
DataSource (0_data/datasources)
    ↓ HTTP/BD/Cache
API / Base de Datos
```

## 🤝 Contributing

Antes de agregar features:

1. Lee [ARQUITECTURA.md](./ARQUITECTURA.md) (sección "Ejemplos Prácticos")
2. Sigue el patrón de 4 capas
3. Crea un PR describiendo qué capa toca
4. Asegúrate de pasar `flutter analyze`

## 📞 Contacto

- **Arquitecto**: fmarcosdev
- **Status**: En desarrollo (FASE 0 ✅)
- **Issues**: Revisa `/backlog/`

---

---

**Status**: FASE 0 ✅ | Próximo: FASE 1 - Autenticación
