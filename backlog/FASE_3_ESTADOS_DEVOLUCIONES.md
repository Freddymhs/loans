# FASE 3 - Estados y Devoluciones 🔄

**Status**: PLANIFICADA
**Prioridad**: 🟠 ALTA
**Tiempo Estimado**: 8-10 horas
**Depende de**: FASE 2 (Core de Préstamos)
**Próximo**: FASE 4

---

## 📋 Descripción

Implementar la lógica de devoluciones y cambios de estado. **Responsabilidad compartida**:
- **Prestamista** puede marcar como devuelto
- **Receptor** puede marcar como devuelto
- Ambos pueden desmarcar si hubo error
- Todo queda auditado

---

## 🎯 Requisitos Funcionales

### 3.1 Marcar como Devuelto
- [x] Solo disponible para status = "pending" o "active"
- [x] Puede hacerlo:
  - El prestamista (from_user)
  - El receptor (to_user)
- [x] Cambiar status → "returned"
- [x] Registrar:
  - `returned_at` = ahora
  - `returned_by` = usuario actual
- [x] Registrar en loan_history
- [x] Mensaje con quién lo devolvió

### 3.2 Desmarcar Devolución (Undo)
- [x] Solo disponible para status = "returned"
- [x] Puede hacerlo:
  - El prestamista (from_user)
  - El receptor (to_user)
  - O quien lo marcó como devuelto
- [x] Cambiar status → "unmarked"
- [x] Registrar:
  - `unmarked_at` = ahora
  - `unmarked_by` = usuario actual
  - Anterior status restaurado o "pending"
- [x] Registrar en loan_history
- [x] Motivo/comentario (opcional)

### 3.3 Reabrir Préstamo
- [x] Cambiar status "unmarked" o "returned" → "active"
- [x] Solo por prestamista o quien lo creó
- [x] Para marcar que sigue en vigencia

### 3.4 Cancelar Préstamo
- [x] Cambiar status → "cancelled"
- [x] Solo por prestamista
- [x] Soft delete + registrar acción
- [ ] Diferente de "deleted" (usuario lo canceló vs sistema lo borró)

### 3.5 Cambiar Estado Manualmente
- [x] Admin/developer: endpoint especial para cambiar estado manualmente
- [x] Registrar cambio con motivo
- [x] Solo para testing/mantenimiento

---

## 📁 Estructura de Carpetas

```
lib/
├── 1_domain/
│   ├── entities/
│   │   └── loan_status.dart (actualizar enum)
│   └── usecases/
│       ├── mark_loan_as_returned_usecase.dart (actualizar)
│       ├── unmark_loan_as_returned_usecase.dart (actualizar)
│       ├── reopen_loan_usecase.dart (NUEVO)
│       └── cancel_loan_usecase.dart (NUEVO)
│
├── 0_data/
│   ├── datasources/
│   │   └── remote/
│   │       └── implementations/
│   │           └── supabase_loan_remote_datasource_impl.dart (actualizar)
│   └── repositories/
│       └── loan_repository_impl.dart (actualizar)
│
└── 2_application/
    ├── bloc/
    │   └── loans/
    │       ├── loans_event.dart (actualizar)
    │       └── loans_state.dart (actualizar)
    └── screens/
        └── widgets/
            ├── loan_action_buttons.dart (NUEVO)
            └── loan_status_badge.dart (actualizar)
```

---

## 🏗️ Tareas Detalladas

### Tarea 3.1: Actualizar Enum de Status
- [ ] Actualizar `loan_status.dart` (o crear en entities):
  ```dart
  enum LoanStatus {
    pending,      // Creado pero no activado
    active,       // En vigencia
    returned,     // Devuelto (completado)
    unmarked,     // Desmarcado de devuelto
    cancelled,    // Cancelado por prestamista
  }
  ```

### Tarea 3.2: Use Cases para Cambios de Estado
- [ ] Actualizar `mark_loan_as_returned_usecase.dart`:
  - Validar: status IN [pending, active, unmarked]
  - Validar: user IN [from_user, to_user]
  - Llamar a repository
  - Retornar updated loan o failure

- [ ] Actualizar `unmark_loan_as_returned_usecase.dart`:
  - Validar: status == returned
  - Validar: user IN [from_user, to_user, returned_by]
  - Cambiar status → unmarked
  - Llamar a repository

- [ ] Crear `reopen_loan_usecase.dart`:
  - Validar: status IN [unmarked, returned]
  - Validar: user == from_user (solo prestamista)
  - Cambiar status → active

- [ ] Crear `cancel_loan_usecase.dart`:
  - Validar: status != cancelled
  - Validar: user == from_user
  - Cambiar status → cancelled
  - Soft delete (is_deleted = true, deleted_by = user)

### Tarea 3.3: Remote DataSource
- [ ] Actualizar `supabase_loan_remote_datasource_impl.dart`:
  - Agregar método `markAsReturned(String loanId, String userId)`:
    ```dart
    await client.from('loans').update({
      'status': 'returned',
      'returned_at': DateTime.now().toIso8601String(),
      'returned_by': userId,
    }).eq('id', loanId).select();
    ```

  - Agregar método `unmarkAsReturned(String loanId, String userId, String? reason)`:
    ```dart
    await client.from('loans').update({
      'status': 'unmarked',
      'unmarked_at': DateTime.now().toIso8601String(),
      'unmarked_by': userId,
    }).eq('id', loanId).select();

    // Registrar en history
    await client.from('loan_history').insert({
      'loan_id': loanId,
      'action': 'unmarked',
      'previous_status': 'returned',
      'new_status': 'unmarked',
      'action_by': userId,
      'comment': reason,
    });
    ```

  - Agregar método `cancelLoan()` (similar a soft delete)

### Tarea 3.4: Repository Implementation
- [ ] Actualizar `loan_repository_impl.dart`:
  - Implementar métodos para cada estado
  - Manejo de errores
  - Update de caché local

### Tarea 3.5: BLoC Events & States
- [ ] Actualizar `loans_event.dart`:
  ```dart
  event MarkLoanAsReturnedPressed(String loanId)
  event UnmarkLoanAsReturnedPressed(String loanId, String? reason)
  event ReopenLoanPressed(String loanId)
  event CancelLoanPressed(String loanId)
  ```

- [ ] Actualizar `loans_state.dart`:
  ```dart
  LoanUpdateInProgress
  LoanUpdateSuccess(Loan loan)
  LoanUpdateFailure(String message)
  ```

### Tarea 3.6: BLoC Handler
- [ ] Actualizar `loans_bloc.dart`:
  ```dart
  on<MarkLoanAsReturnedPressed>((event, emit) async {
    emit(LoanUpdateInProgress());
    final result = await markLoanAsReturnedUseCase(MarkLoanAsReturnedParams(
      loanId: event.loanId,
      userId: getCurrentUserId(),
    ));
    result.fold(
      (failure) => emit(LoanUpdateFailure(failure.message)),
      (loan) {
        emit(LoanUpdateSuccess(loan));
        emit(LoansLoaded(...)); // Reload list
      },
    );
  });
  ```

### Tarea 3.7: UI - Action Buttons
- [ ] Crear `loan_action_buttons.dart`:
  - Mostrar botones según:
    - Status del préstamo
    - Rol del usuario (prestamista vs receptor)
  - Botones:
    - "Marcar como devuelto" (si no devuelto)
    - "Desmarcar devolución" (si devuelto)
    - "Reabrir" (si unmarked)
    - "Cancelar" (si no cancelado y es prestamista)
  - Confirmación antes de acciones

- [ ] Crear `loan_status_badge.dart`:
  - Mostrar estado visual:
    - 🟡 pending
    - 🟢 active
    - ✅ returned
    - ⚠️ unmarked
    - ❌ cancelled
  - Texto descriptivo

### Tarea 3.8: Detalle de Préstamo
- [ ] Actualizar `loan_detail_widget.dart`:
  - Mostrar status actual
  - Mostrar historial de cambios (quién, cuándo, qué)
  - Mostrar botones de acción disponibles
  - Timeline visual

### Tarea 3.9: Notificaciones (Opcional)
- [ ] Agregar notificación local cuando:
  - Marcan tu préstamo como devuelto
  - Desmarcan tu préstamo
  - Alguien actúa sobre tu préstamo

### Tarea 3.10: Tests
- [ ] Unit tests para cada use case
- [ ] Unit tests para repository
- [ ] Widget tests para action buttons
- [ ] Escenarios:
  - Marcar como devuelto siendo prestamista
  - Marcar como devuelto siendo receptor
  - Desmarcar siendo receptor (pero no fue quien marcó)
  - Cancelar siendo receptor (debe fallar)

---

## 🔄 Flujo de Estados (Visual)

```
[PENDING] ←─────────────────────────────────────┐
   │                                             │
   ├─ Mark as returned ──→ [RETURNED]           │
   │                             │               │
   │                      Unmark ├──→ [UNMARKED] ┤
   │                             │       │       │
   └─────────────────────────────┴───←──┴───────→ Mark as returned
   │
   └─ Cancel (by lender) ──→ [CANCELLED]

[ACTIVE] same as pending

[RETURNED]
   │
   ├─ Unmark ──→ [UNMARKED]
   └─ (soft delete → deleted)

[CANCELLED]
   └─ (soft delete, no undo)
```

---

## 📊 Auditoría Completa

Cada cambio de estado debe registrarse en `loan_history`:

```json
{
  "id": "uuid",
  "loan_id": "uuid",
  "action": "marked_as_returned",
  "previous_status": "pending",
  "new_status": "returned",
  "action_by": "user_id",
  "action_at": "2025-12-03T15:30:00Z",
  "comment": null
}
```

---

## ✅ Criterios de Aceptación

- [x] Estados se pueden cambiar según reglas
- [x] Solo usuarios autorizados pueden actuar
- [x] Cada cambio se registra en loan_history
- [x] UI muestra botones correctos según estado
- [x] Confirmación antes de acciones importantes
- [x] Mensajes de éxito/error claros
- [x] Status badge visual correcto
- [x] Tests unitarios pasan
- [x] Sin regresiones en funcionalidad anterior

---

## 🚀 Próxima Fase

FASE 4: Filtros, Búsqueda y Reportes

---

**Actualizado**: Diciembre 2025
**Responsable**: Dev Team
