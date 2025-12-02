# FASE 1 - Autenticación

**Status**: 📋 Pendiente
**Tiempo**: 3-4 horas
**Dependencia**: FASE 0 ✅
**Próximo**: FASE 2

## Tasks

### DataSources (Auth)
- [ ] `data/datasources/remote/firebase_auth_datasource_impl.dart`
- [ ] `data/datasources/local/auth_local_datasource_impl.dart`

### Models & Entity
- [ ] `data/models/user_model.dart` (con @JsonSerializable)
- [ ] `domain/entities/user_entity.dart` (immutable)

### Repository
- [ ] `domain/repositories/auth_repository.dart` (abstract)
- [ ] `data/repositories/auth_repository_impl.dart` (impl)

### Use Cases
- [ ] `domain/usecases/google_sign_in_usecase.dart`
- [ ] `domain/usecases/sign_out_usecase.dart`
- [ ] `domain/usecases/get_current_user_usecase.dart`

### BLoC
- [ ] `presentation/bloc/auth/auth_event.dart` (sealed)
- [ ] `presentation/bloc/auth/auth_state.dart` (sealed)
- [ ] `presentation/bloc/auth/auth_bloc.dart`

### Company Validation
- [ ] Verificar que user.company != null
- [ ] Auto-logout si no tiene empresa (después de 4s)
- [ ] Mostrar alert "Empresa no asignada"

### UI
- [ ] `presentation/pages/splash_page.dart`
- [ ] `presentation/pages/login_page.dart`
- [ ] `presentation/pages/no_company_page.dart` (error page)
- [ ] `presentation/router/app_router.dart` (GoRouter con validación)

### Testing
- [ ] Tests para AuthBloc (80%+ coverage)
- [ ] Tests para AuthRepository
- [ ] Tests para Use Cases

## Entregables

- ✅ App de login funcional
- ✅ Google Sign In working
- ✅ Token management local
- ✅ Navegación (Splash → Login → Home)

## Setup Previo

Editar `.env`:
```
SUPABASE_URL=...
SUPABASE_ANON_KEY=...
GOOGLE_WEB_CLIENT_ID=...
GOOGLE_IOS_CLIENT_ID=...
GOOGLE_ANDROID_CLIENT_ID=...
```

## Próximo: FASE 2

Ir a `FASE_2.md`
