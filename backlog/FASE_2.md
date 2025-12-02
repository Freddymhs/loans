# FASE 2 - Gestión de Préstamos

**Status**: 📋 Pendiente
**Tiempo**: 4-5 horas
**Dependencia**: FASE 1 ✅
**Próximo**: FASE 3

## Tasks

### Models & Entity
- [ ] `data/models/lend_model.dart` (con @JsonSerializable)
  - Fields: id, name, quantity, date (DD-MM-YYYY HH:mm:ss)
  - from (uid), fromCompany, to (uid), toCompany
  - returned, returnedBy, deleted, deletedBy
  - **comment (multiline history)** - IMPORTANTE
- [ ] `domain/entities/lend_entity.dart` (immutable)

### DataSources
- [ ] `data/datasources/remote/supabase_lends_datasource_impl.dart`
- [ ] `data/datasources/local/lends_local_datasource_impl.dart` (Hive cache)

### Repository
- [ ] `domain/repositories/lends_repository.dart` (abstract)
- [ ] `data/repositories/lends_repository_impl.dart` (impl)

### Use Cases
- [ ] `domain/usecases/get_lends_usecase.dart`
- [ ] `domain/usecases/create_lend_usecase.dart`
- [ ] `domain/usecases/mark_returned_usecase.dart` (con comentario)
- [ ] `domain/usecases/delete_lend_usecase.dart` (soft-delete)
- [ ] `domain/usecases/apply_filters_usecase.dart`
  - Filtros: notReturned, returned, wasReturned, deleted
  - By date range
  - By company (automático)

### BLoCs
- [ ] `presentation/bloc/lends/lends_bloc.dart` + Event + State
- [ ] `presentation/bloc/filter/filter_bloc.dart` + Event + State
- [ ] `presentation/bloc/users/users_bloc.dart` (para selector)

### UI
- [ ] `presentation/pages/home_page.dart` (con TabBar: Prestamos/Deudas)
- [ ] `presentation/screens/loans_screen.dart`
- [ ] `presentation/screens/debts_screen.dart`
- [ ] `presentation/widgets/loan_card.dart`
  - Collapsible para ver historial completo
  - Visual status indicator (icono + color)
  - Mostrar campo comment expandido
- [ ] `presentation/widgets/add_loan_modal.dart`
- [ ] `presentation/widgets/return_loan_modal.dart` (con campo comentario, max 100 chars)
- [ ] `presentation/widgets/filter_panel.dart`
- [ ] `presentation/widgets/date_range_picker.dart`
- [ ] `presentation/widgets/user_selector.dart`
- [ ] **Swipe actions** (flutter_slidable package)
  - Swipe left: "Marcar devuelto" → abre modal
  - Swipe right: "Eliminar" → confirmación
  - Mobile: swipe, Desktop: buttons

### Real-time
- [ ] Supabase Real-time subscriptions
- [ ] StreamBuilder para actualizaciones automáticas

### Testing
- [ ] Tests para LendsBloc (80%+ coverage)
- [ ] Tests para LendsRepository
- [ ] Tests para Use Cases

### Dependencies to add

```yaml
flutter_slidable: ^3.0.0  # Swipe actions
```

## Entregables

- ✅ CRUD de préstamos completo (crear, leer, actualizar, eliminar)
- ✅ Real-time updates funcionando
- ✅ Filtros por estado (notReturned, returned, wasReturned, deleted)
- ✅ Filtros por fecha (date range picker)
- ✅ Dos vistas (Loans vs Debts) con TabBar
- ✅ Caché local con Hive
- ✅ Historial de cambios en campo `comment` multiline
- ✅ Modal de devolución con comentario (max 100 chars)
- ✅ Swipe actions (mobile) + buttons (desktop)
- ✅ Collapsible cards con historial visible
- ✅ Visual status indicators (icono + color por estado)

## Próximo: FASE 3

Ir a `FASE_3.md`
