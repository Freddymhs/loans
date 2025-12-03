# FASE 1 - Autenticación & Gestión de Usuarios 🔐

**Status**: PLANIFICADA
**Prioridad**: 🔴 CRÍTICA - Bloqueante para todo lo demás
**Tiempo Estimado**: 8-10 horas
**Próximo**: FASE 2

---

## 📋 Descripción

Implementar sistema de autenticación con Supabase (Google OAuth) y gestión de usuarios con soporte para:
- Login/Signup con Google
- Perfil de usuario con Root ID único
- Selección/creación de empresa durante onboarding
- Persistencia de sesión local

---

## 🎯 Requisitos Funcionales

### 1.1 Autenticación (Google OAuth)
- [x] Integración con Supabase Auth
- [x] Sign in con Google
- [x] Sign up con Google (nuevo usuario)
- [x] Sign out / Logout
- [x] Refresh token automático
- [x] Recuperación de contraseña (si aplica)

### 1.2 Onboarding de Usuario
- [x] Pantalla de selección de Root ID (único, no repetible)
- [x] Validación de Root ID:
  - No vacío
  - Único en la base de datos
  - Formato válido (alfanumérico)
- [x] Pantalla de selección/creación de empresa:
  - **Opción A**: Crear nueva empresa
  - **Opción B**: Unirse a empresa existente (escribir nombre exacto)
- [x] Validación de pertenencia a una sola empresa a la vez
- [x] Guardar selección en users table

### 1.3 Gestión de Perfil
- [x] Pantalla de perfil de usuario
- [x] Ver información (email, nombre, root ID, empresa actual)
- [x] Editar nombre display
- [x] Ver empresa actual
- [x] Opción para cambiar de empresa (si tiene múltiples)
- [x] Logout

### 1.4 Persistencia de Sesión
- [x] Token guardado localmente (SharedPreferences/Hive)
- [x] Auto-login al abrir app
- [x] Validación de token al iniciar

---

## 📁 Estructura de Carpetas

```
lib/
├── 1_domain/
│   ├── entities/
│   │   ├── user_entity.dart (actualizar)
│   │   └── company_entity.dart (NUEVO)
│   ├── repositories/
│   │   ├── auth_repository.dart (actualizar)
│   │   └── user_repository.dart (NUEVO)
│   └── usecases/
│       ├── login_usecase.dart (NUEVO)
│       ├── logout_usecase.dart (NUEVO)
│       ├── get_current_user_usecase.dart (NUEVO)
│       ├── create_user_onboarding_usecase.dart (NUEVO)
│       ├── create_company_usecase.dart (NUEVO)
│       └── join_company_usecase.dart (NUEVO)
│
├── 0_data/
│   ├── datasources/
│   │   ├── remote/
│   │   │   ├── auth_remote_datasource.dart (NUEVO)
│   │   │   ├── user_remote_datasource.dart (NUEVO)
│   │   │   └── implementations/
│   │   │       ├── supabase_auth_remote_datasource_impl.dart (NUEVO)
│   │   │       └── supabase_user_remote_datasource_impl.dart (NUEVO)
│   │   └── local/
│   │       └── token_local_datasource.dart (NUEVO - para cached tokens)
│   ├── models/
│   │   ├── user_model.dart (NUEVO)
│   │   └── company_model.dart (NUEVO)
│   └── repositories/
│       ├── auth_repository_impl.dart (NUEVO)
│       └── user_repository_impl.dart (NUEVO)
│
├── 2_application/
│   ├── bloc/
│   │   ├── auth/
│   │   │   ├── auth_bloc.dart (NUEVO)
│   │   │   ├── auth_event.dart (NUEVO)
│   │   │   └── auth_state.dart (NUEVO)
│   │   └── user/
│   │       ├── user_bloc.dart (NUEVO)
│   │       ├── user_event.dart (NUEVO)
│   │       └── user_state.dart (NUEVO)
│   └── screens/
│       ├── auth/
│       │   ├── splash_screen.dart (NUEVO)
│       │   ├── login_screen.dart (NUEVO)
│       │   ├── onboarding_root_screen.dart (NUEVO)
│       │   ├── onboarding_company_screen.dart (NUEVO)
│       │   └── profile_screen.dart (NUEVO)
│       └── widgets/
│           ├── auth_widgets/
│           │   ├── google_sign_in_button.dart (NUEVO)
│           │   ├── root_input_field.dart (NUEVO)
│           │   └── company_selector.dart (NUEVO)
│           └── profile_widgets/
│               ├── user_info_card.dart (NUEVO)
│               └── company_info_card.dart (NUEVO)
```

---

## 🏗️ Tareas Detalladas

### Tarea 1.1: Entities & Models
- [ ] Actualizar `user_entity.dart`:
  - Agregar: `rootId`, `companyId`, `createdAt`
- [ ] Crear `company_entity.dart`:
  - `id`, `name`, `createdBy`, `createdAt`, `members`
- [ ] Crear `user_model.dart` con `@JsonSerializable`
- [ ] Crear `company_model.dart` con `@JsonSerializable`

### Tarea 1.2: Repository Interfaces
- [ ] Actualizar `auth_repository.dart`:
  ```dart
  abstract class AuthRepository {
    Future<Either<Failure, User>> loginWithGoogle();
    Future<Either<Failure, void>> logout();
    Future<Either<Failure, User>> getCurrentUser();
    Future<Either<Failure, bool>> isSessionActive();
  }
  ```
- [ ] Crear `user_repository.dart`:
  ```dart
  abstract class UserRepository {
    Future<Either<Failure, void>> createUserOnboarding(String rootId);
    Future<Either<Failure, bool>> isRootIdAvailable(String rootId);
    Future<Either<Failure, Company>> createCompany(String name);
    Future<Either<Failure, Company>> getCompanyByName(String name);
    Future<Either<Failure, void>> joinCompany(String companyName);
    Future<Either<Failure, User>> getUser(String userId);
  }
  ```

### Tarea 1.3: Remote DataSources
- [ ] Crear `auth_remote_datasource.dart` (interface)
- [ ] Implementar `supabase_auth_remote_datasource_impl.dart`:
  - Google sign in/up
  - Session management
  - Token refresh
- [ ] Crear `user_remote_datasource.dart` (interface)
- [ ] Implementar `supabase_user_remote_datasource_impl.dart`:
  - CRUD de usuarios
  - CRUD de empresas
  - Validaciones de Root ID
  - Join company logic

### Tarea 1.4: Local DataSources
- [ ] Crear `token_local_datasource.dart`:
  - Guardar token localmente
  - Recuperar token
  - Limpiar token al logout

### Tarea 1.5: Repository Implementations
- [ ] Implementar `auth_repository_impl.dart`
- [ ] Implementar `user_repository_impl.dart`

### Tarea 1.6: Use Cases
- [ ] `login_usecase.dart`
- [ ] `logout_usecase.dart`
- [ ] `get_current_user_usecase.dart`
- [ ] `create_user_onboarding_usecase.dart`
- [ ] `create_company_usecase.dart`
- [ ] `join_company_usecase.dart`

### Tarea 1.7: BLoCs
- [ ] Crear `auth_bloc.dart` + events + states
- [ ] Crear `user_bloc.dart` + events + states

### Tarea 1.8: UI Screens
- [ ] `splash_screen.dart` - Check auth status
- [ ] `login_screen.dart` - Google sign in button
- [ ] `onboarding_root_screen.dart` - Input Root ID
- [ ] `onboarding_company_screen.dart` - Select/Create company
- [ ] `profile_screen.dart` - Ver/editar perfil

### Tarea 1.9: Widgets
- [ ] `google_sign_in_button.dart`
- [ ] `root_input_field.dart` con validación
- [ ] `company_selector.dart`
- [ ] `user_info_card.dart`
- [ ] `company_info_card.dart`

### Tarea 1.10: Dependency Injection
- [ ] Actualizar `injection_container.dart`:
  - Registrar AuthBloc
  - Registrar UserBloc
  - Registrar repositories
  - Registrar datasources

### Tarea 1.11: App Navigation
- [ ] Crear `auth_guard.dart` - Middleware para proteger rutas
- [ ] Actualizar `app.dart`:
  - BlocListener para cambios de auth
  - Navigation basada en auth state

### Tarea 1.12: Testing
- [ ] Unit tests para repositories
- [ ] Unit tests para usecases
- [ ] Widget tests para screens

---

## 🔄 Flujo de Autenticación

```
1. App inicia
   ↓
2. SplashScreen verifica sesión
   ├─ ¿Token válido? → Home
   └─ ¿Sin token? → LoginScreen

3. LoginScreen - Google Sign In
   ↓
4. Nuevo usuario? → OnboardingRootScreen
   ↓
5. OnboardingCompanyScreen
   ├─ Crear empresa → Crear
   └─ Unir empresa → Validar nombre exacto

6. Guardado en users table
   ↓
7. Redirect → Home Screen
```

---

## 📊 Tablas Supabase Necesarias

```sql
-- Ya creadas en FASE 0:
CREATE TABLE users (
  id UUID PRIMARY KEY,
  auth_id UUID REFERENCES auth.users(id),
  email TEXT,
  display_name TEXT,
  root_id TEXT UNIQUE,
  company_id UUID,
  created_at TIMESTAMP,
  is_active BOOLEAN
);

CREATE TABLE companies (
  id UUID PRIMARY KEY,
  created_by UUID REFERENCES users(id),
  name TEXT UNIQUE,
  created_at TIMESTAMP
);

CREATE TABLE company_members (
  id UUID PRIMARY KEY,
  company_id UUID REFERENCES companies(id),
  user_id UUID REFERENCES users(id),
  role TEXT,
  UNIQUE(company_id, user_id)
);
```

---

## ✅ Criterios de Aceptación

- [x] Usuario puede hacer login con Google
- [x] Nuevo usuario hace onboarding (Root ID + Empresa)
- [x] Root ID es único y validado
- [x] Usuario pertenece a una empresa (o crea una)
- [x] Sesión persiste localmente
- [x] Logout limpia sesión
- [x] Profile screen muestra datos correctos
- [x] Auth guard protege rutas
- [x] Tests unitarios pasen

---

## 🚀 Próxima Fase

FASE 2: Core de Préstamos (CRUD + DataSources reales)

---

**Actualizado**: Diciembre 2025
**Responsable**: Dev Team
