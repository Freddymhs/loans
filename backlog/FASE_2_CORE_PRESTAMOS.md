# FASE 2 - Core de Préstamos (CRUD + Backend Real) 📦

**Status**: PLANIFICADA
**Prioridad**: 🔴 CRÍTICA
**Tiempo Estimado**: 10-12 horas
**Depende de**: FASE 1 (Autenticación)
**Próximo**: FASE 3

---

## 📋 Descripción

Implementar CRUD completo de préstamos con conexión real a Supabase, reemplazando los mocks actuales.
Enfoque: **Quién presta es responsable de anotar** (lógica core del negocio).

---

## 🎯 Requisitos Funcionales

### 2.1 Crear Préstamo
- [x] Form para crear nuevo préstamo:
  - Nombre del artículo
  - Cantidad
  - Descripción (opcional)
  - Seleccionar usuario receptor (del listado de usuarios vinculados)
- [x] Validación de campos
- [x] **El prestamista (from_user) SIEMPRE es el usuario logueado**
- [x] Guardar en Supabase con:
  - `created_by` = usuario actual
  - `from_user_id` = usuario actual
  - `to_user_id` = seleccionado
  - `from_company_id` = empresa actual
  - `to_company_id` = empresa del receptor (si aplica)
  - `status` = "pending"
  - `created_at` = ahora
- [x] Optimistic UI update
- [x] Mostrar toast de éxito/error

### 2.2 Listar Préstamos
- [x] Filtrar por:
  - **Enviados** (yo presté): `from_user_id == current_user`
  - **Recibidos** (me prestaron): `to_user_id == current_user`
- [x] Mostrar todos los préstamos de la empresa (si está en empresa)
- [x] Ordenar por fecha (descendente)
- [x] Mostrar:
  - Artículo, cantidad
  - De quién a quién
  - Fecha
  - Estado (pending/active/returned)

### 2.3 Ver Detalle de Préstamo
- [x] Pantalla detalle con:
  - Información completa
  - Historial de cambios
  - Comentarios (si aplica)
  - Botones de acción (según rol/estado)

### 2.4 Actualizar Préstamo
- [x] Edición limitada:
  - Solo si `status == "pending"`
  - Solo quien lo creó puede editar
  - Campos editables: nombre, cantidad, descripción
- [x] Guardar cambios en Supabase
- [x] Registrar en loan_history

### 2.5 Eliminar Préstamo
- [x] Soft delete (`is_deleted = true, deleted_at, deleted_by`)
- [x] Solo quien lo creó puede eliminar
- [x] Registrar en loan_history
- [x] Mostrar confirmación

---

## 📁 Estructura de Carpetas

```
lib/
├── 1_domain/
│   ├── entities/
│   │   ├── loan_entity.dart (actualizar con auditoria)
│   │   └── loan_history_entity.dart (NUEVO)
│   ├── repositories/
│   │   └── loan_repository.dart (actualizar)
│   └── usecases/
│       ├── get_loans_usecase.dart (actualizar)
│       ├── create_loan_usecase.dart (actualizar)
│       ├── update_loan_usecase.dart (actualizar)
│       ├── delete_loan_usecase.dart (actualizar)
│       ├── get_loan_detail_usecase.dart (NUEVO)
│       └── get_loan_history_usecase.dart (NUEVO)
│
├── 0_data/
│   ├── datasources/
│   │   ├── remote/
│   │   │   ├── loan_remote_datasource.dart (actualizar)
│   │   │   └── implementations/
│   │   │       └── supabase_loan_remote_datasource_impl.dart (actualizar)
│   │   └── local/
│   │       ├── loan_local_datasource.dart (actualizar)
│   │       └── implementations/
│   │           └── hive_loan_local_datasource_impl.dart (NUEVO)
│   ├── models/
│   │   ├── loan_model.dart (actualizar)
│   │   └── loan_history_model.dart (NUEVO)
│   └── repositories/
│       └── loan_repository_impl.dart (actualizar)
│
└── 2_application/
    ├── bloc/
    │   └── loans/
    │       ├── loans_bloc.dart (actualizar)
    │       ├── loans_event.dart (actualizar)
    │       └── loans_state.dart (actualizar)
    └── screens/
        ├── loan_form_screen.dart (NUEVO)
        ├── loan_detail_screen.dart (NUEVO)
        └── widgets/
            ├── loan_form_widget.dart (NUEVO)
            ├── loan_detail_widget.dart (NUEVO)
            └── loan_history_widget.dart (NUEVO)
```

---

## 🏗️ Tareas Detalladas

### Tarea 2.1: Actualizar Entities
- [ ] Actualizar `loan_entity.dart`:
  - Agregar campos de auditoría: `createdBy`, `returnedBy`, `deletedBy`, `unmarkedBy`
  - Agregar timestamps: `createdAt`, `returnedAt`, `deletedAt`, `unmarkedAt`
  - Agregar `isDeleted` flag
- [ ] Crear `loan_history_entity.dart`:
  - `id`, `loanId`, `action`, `previousStatus`, `newStatus`, `actionBy`, `actionAt`, `comment`

### Tarea 2.2: Actualizar Models
- [ ] Actualizar `loan_model.dart`:
  - Mapeo completo desde/hacia LoanEntity
  - Serialización JSON completa
  - Manejo de nullable fields
- [ ] Crear `loan_history_model.dart` con `@JsonSerializable`

### Tarea 2.3: Repository Interface
- [ ] Actualizar `loan_repository.dart`:
  ```dart
  abstract class LoanRepository {
    Future<Either<Failure, List<Loan>>> getLoansByUser(String userId, LoanType type);
    Future<Either<Failure, List<Loan>>> getLoansByCompany(String companyId);
    Future<Either<Failure, Loan>> createLoan(CreateLoanParams params);
    Future<Either<Failure, Loan>> updateLoan(String loanId, UpdateLoanParams params);
    Future<Either<Failure, void>> deleteLoan(String loanId);
    Future<Either<Failure, Loan>> getLoanDetail(String loanId);
    Future<Either<Failure, List<LoanHistory>>> getLoanHistory(String loanId);
  }
  ```

### Tarea 2.4: Remote DataSource Implementation
- [ ] Reemplazar mocks en `supabase_loan_remote_datasource_impl.dart`:
  - `getLoansByUser()` - Query Supabase:
    ```sql
    SELECT * FROM loans
    WHERE (from_user_id = ? OR to_user_id = ?)
      AND is_deleted = false
    ORDER BY created_at DESC
    ```
  - `getLoansByCompany()` - Query por empresa:
    ```sql
    SELECT * FROM loans
    WHERE from_company_id = ? OR to_company_id = ?
      AND is_deleted = false
    ORDER BY created_at DESC
    ```
  - `createLoan()` - INSERT + registrar en loan_history
  - `updateLoan()` - UPDATE + registrar en loan_history
  - `deleteLoan()` - Soft delete + registrar en loan_history
  - `getLoanDetail()` - SELECT por ID
  - `getLoanHistory()` - SELECT del historial
  - Error handling: Exception → throw exception (logger)

### Tarea 2.5: Local DataSource Implementation
- [ ] Crear `hive_loan_local_datasource_impl.dart`:
  - `saveLoan()` - Guardar en Hive
  - `getLoan()` - Recuperar
  - `deleteLoan()` - Borrar
  - `getAllLoans()` - Listar
  - Con timestamp de validez (caché 24h)

### Tarea 2.6: Repository Implementation
- [ ] Actualizar `loan_repository_impl.dart`:
  - Implementar fallback: Remote → Local (si error)
  - Actualizar caché local en cada operación
  - Mapeo correcto de exceptions a failures
  - Logging de todas las operaciones

### Tarea 2.7: Use Cases
- [ ] Actualizar `get_loans_usecase.dart`:
  - Parámetro: userId + type (outgoing/incoming)
  - Llamar a repository
- [ ] Actualizar `create_loan_usecase.dart`:
  - Validar parámetros
  - Validación de cantidad > 0
  - Validación de receptor diferente a prestamista
- [ ] Actualizar `update_loan_usecase.dart`:
  - Solo si status == pending
  - Solo por quien lo creó
- [ ] Actualizar `delete_loan_usecase.dart`:
  - Solo por quien lo creó
- [ ] Crear `get_loan_detail_usecase.dart`
- [ ] Crear `get_loan_history_usecase.dart`

### Tarea 2.8: BLoC
- [ ] Actualizar `loans_bloc.dart`:
  - Eventos: LoadLoans, CreateLoan, UpdateLoan, DeleteLoan, GetLoanDetail
  - Estados: Loading, Loaded, Error, Empty
  - Refresh automático después de mutations
  - Manejo correcto de loading states
- [ ] Actualizar `loans_event.dart`
- [ ] Actualizar `loans_state.dart`

### Tarea 2.9: Forms & Screens
- [ ] Crear `loan_form_screen.dart`:
  - Form para crear/editar
  - Campos: nombre, cantidad, descripción
  - Selector de receptor (dropdown con usuarios disponibles)
  - Validación en tiempo real
  - Botón submit
- [ ] Crear `loan_form_widget.dart` - Componente reutilizable
- [ ] Crear `loan_detail_screen.dart`
- [ ] Crear `loan_detail_widget.dart` - Info del préstamo

### Tarea 2.10: BLoC Tests
- [ ] Unit tests para loans_bloc
- [ ] Unit tests para usecases
- [ ] Unit tests para repositories

### Tarea 2.11: Widget Tests
- [ ] Tests para loan_form_screen
- [ ] Tests para loan_form_widget
- [ ] Tests para loans_list (actualizar)

---

## 🔌 Conexión Real a Supabase

### Configuración en `supabase_config.dart`
```dart
class SupabaseConfig {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
```

### Queries Ejemplo
```dart
// Create
await client.from('loans').insert({
  'item_name': 'Papitas',
  'quantity': 10,
  'from_user_id': currentUserId,
  'to_user_id': toUserId,
  'from_company_id': companyId,
  'status': 'pending',
  'created_by': currentUserId,
  'created_at': DateTime.now().toIso8601String(),
}).select();

// Read
final loans = await client
  .from('loans')
  .select()
  .eq('from_user_id', userId)
  .eq('is_deleted', false)
  .order('created_at', ascending: false);

// Update
await client
  .from('loans')
  .update({'quantity': 20})
  .eq('id', loanId)
  .select();

// Delete (soft)
await client
  .from('loans')
  .update({
    'is_deleted': true,
    'deleted_at': DateTime.now().toIso8601String(),
    'deleted_by': currentUserId,
  })
  .eq('id', loanId);
```

---

## 📊 Estados del Préstamo

```
pending   → Creado, sin activar aún
   ↓
active    → Marcado como entregado
   ↓
returned  → Devuelto por receptor
   ↓
unmarked  → Alguien desmarcó la devolución
   ↓
cancelled → Cancelado/Eliminado
```

---

## ✅ Criterios de Aceptación

- [x] CRUD funciona 100% con Supabase real
- [x] Crear préstamo registra al usuario logueado como prestamista
- [x] Listar préstamos filtra correctamente por tipo (enviados/recibidos)
- [x] Edición solo para status "pending"
- [x] Eliminación es soft delete
- [x] Caché local funciona (fallback si sin conexión)
- [x] Auditoría completa en loan_history
- [x] Tests unitarios pasan
- [x] Manejo de errores correcto
- [x] Logging de operaciones

---

## 🚀 Próxima Fase

FASE 3: Estados y Devoluciones (mark as returned, unmark, etc)

---

**Actualizado**: Diciembre 2025
**Responsable**: Dev Team
