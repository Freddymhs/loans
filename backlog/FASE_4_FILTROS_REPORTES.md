# FASE 4 - Filtros, Búsqueda y Reportes 🔍

**Status**: PLANIFICADA
**Prioridad**: 🟡 MEDIA
**Tiempo Estimado**: 8-10 horas
**Depende de**: FASE 3 (Estados y Devoluciones)
**Próximo**: FASE 5 (Polish & Testing)

---

## 📋 Descripción

Implementar sistema avanzado de filtrado, búsqueda y reportes. Permite a los usuarios:
- Filtrar préstamos por múltiples criterios
- Búsqueda por texto
- Reportes de deuda/crédito
- Análisis de actividad

---

## 🎯 Requisitos Funcionales

### 4.1 Filtros por Estado
- [x] Toggle/checkboxes para estados:
  - ☑️ Pending (no regresado)
  - ☑️ Returned (regresado)
  - ☑️ Unmarked (regresado antes, ahora desmarcado)
  - ☑️ Cancelled (cancelado)
- [x] Multi-select (puede filtrar varios estados a la vez)
- [x] Aplicar filtro en tiempo real

### 4.2 Filtros por Fecha
- [x] Rango de fechas:
  - Desde: DatePicker
  - Hasta: DatePicker
- [x] Presets:
  - Esta semana
  - Este mes
  - Último mes
  - Últimas 3 meses
  - Todo el tiempo
- [x] Aplicar en tiempo real

### 4.3 Filtros por Persona
- [x] Filtrar por:
  - Con quién (nombre/root_id)
  - Múltiples personas posibles
- [x] Dropdown searchable con usuarios vinculados
- [x] Avatar + nombre para identificación clara

### 4.4 Filtros por Empresa
- [x] Si usuario está en empresa:
  - Mostrar préstamos de toda la empresa
  - Filtrar por préstamos personales solo
- [x] Selector: "Mis préstamos" vs "Empresa"

### 4.5 Búsqueda por Texto
- [x] Buscar en:
  - Nombre del artículo
  - Nombre de persona
  - Root ID
- [x] Search field con debounce (300ms)
- [x] Case-insensitive
- [x] Partial match (palabras)

### 4.6 Ordenamiento
- [x] Opciones:
  - Fecha más reciente
  - Fecha más antigua
  - Cantidad (ascendente)
  - Cantidad (descendente)
  - Nombre (A-Z)
  - Nombre (Z-A)

### 4.7 Reportes - Vista General
- [x] Dashboard con KPIs:
  - Total prestado (en vigencia)
  - Total recibido (en vigencia)
  - Total devuelto (este mes)
  - Deuda pendiente (yo debo)
  - Crédito pendiente (me deben)
- [x] Gráficos:
  - Pie chart: Distribución de estados
  - Bar chart: Actividad por mes
  - Timeline: Últimas transacciones

### 4.8 Reportes - Por Persona
- [x] Al hacer click en persona:
  - Total prestado a esta persona
  - Total recibido de esta persona
  - Préstamos pendientes
  - Historial completo
  - Balance actual

### 4.9 Reportes - Export
- [x] Exportar a CSV:
  - Archivo con todos los préstamos
  - Filtros aplicados
- [x] Exportar a PDF:
  - Reporte visual
  - Con gráficos

### 4.10 Favoritos/Frecuentes
- [x] Marcar personas como frecuentes
- [x] Mostrar en top (en crear préstamo)
- [x] Agregar/quitar fácilmente

---

## 📁 Estructura de Carpetas

```
lib/
├── 1_domain/
│   ├── entities/
│   │   ├── loan_filter.dart (NUEVO)
│   │   ├── loan_report.dart (NUEVO)
│   │   └── user_summary.dart (NUEVO)
│   ├── repositories/
│   │   ├── loan_repository.dart (actualizar)
│   │   └── report_repository.dart (NUEVO)
│   └── usecases/
│       ├── filter_loans_usecase.dart (NUEVO)
│       ├── search_loans_usecase.dart (NUEVO)
│       ├── get_loan_reports_usecase.dart (NUEVO)
│       ├── get_user_summary_usecase.dart (NUEVO)
│       └── export_loans_usecase.dart (NUEVO)
│
├── 0_data/
│   ├── datasources/
│   │   ├── remote/
│   │   │   └── implementations/
│   │   │       └── supabase_report_remote_datasource_impl.dart (NUEVO)
│   │   └── local/
│   │       └── implementations/
│   │           └── hive_report_local_datasource_impl.dart (NUEVO)
│   ├── models/
│   │   ├── loan_filter_model.dart (NUEVO)
│   │   ├── loan_report_model.dart (NUEVO)
│   │   └── user_summary_model.dart (NUEVO)
│   └── repositories/
│       ├── loan_repository_impl.dart (actualizar con filters)
│       └── report_repository_impl.dart (NUEVO)
│
└── 2_application/
    ├── bloc/
    │   ├── loans/
    │   │   ├── loans_bloc.dart (actualizar)
    │   │   ├── loans_event.dart (actualizar)
    │   │   └── loans_state.dart (actualizar)
    │   └── reports/
    │       ├── reports_bloc.dart (NUEVO)
    │       ├── reports_event.dart (NUEVO)
    │       └── reports_state.dart (NUEVO)
    ├── screens/
    │   ├── filters_screen.dart (NUEVO)
    │   ├── reports_screen.dart (NUEVO)
    │   ├── person_summary_screen.dart (NUEVO)
    │   └── widgets/
    │       ├── filter_chips.dart (NUEVO)
    │       ├── date_range_picker.dart (NUEVO)
    │       ├── search_bar.dart (NUEVO)
    │       ├── sort_dropdown.dart (NUEVO)
    │       ├── kpi_cards.dart (NUEVO)
    │       ├── charts/
    │       │   ├── status_pie_chart.dart (NUEVO)
    │       │   ├── activity_bar_chart.dart (NUEVO)
    │       │   └── timeline_chart.dart (NUEVO)
    │       └── export_button.dart (NUEVO)
```

---

## 🏗️ Tareas Detalladas

### Tarea 4.1: Entities y Models
- [ ] Crear `loan_filter.dart`:
  ```dart
  class LoanFilter {
    final List<LoanStatus>? statuses;
    final DateTime? dateFrom;
    final DateTime? dateTo;
    final List<String>? withUsers; // userIds
    final String? searchQuery;
    final String? sortBy; // 'date_desc', 'date_asc', etc
    final bool? myLoansOnly; // Si está en empresa
  }
  ```

- [ ] Crear `loan_report.dart`:
  ```dart
  class LoanReport {
    final int totalOutgoing; // Yo presté
    final int totalIncoming; // Me prestaron
    final int pendingOutgoing; // Aún no devuelven
    final int pendingIncoming; // Aún no devuelvo
    final int thisMonthReturned;
    final Map<LoanStatus, int> statusDistribution;
    final List<MonthlyActivity> monthlyActivity;
  }
  ```

- [ ] Crear `user_summary.dart`:
  ```dart
  class UserSummary {
    final User user;
    final int totalOutgoing;
    final int totalIncoming;
    final int pending;
    final List<Loan> loans;
  }
  ```

- [ ] Crear modelos JSON-serializable para cada uno

### Tarea 4.2: Repository Interfaces
- [ ] Actualizar `loan_repository.dart`:
  ```dart
  Future<Either<Failure, List<Loan>>> filterLoans(LoanFilter filter);
  Future<Either<Failure, List<Loan>>> searchLoans(String query);
  ```

- [ ] Crear `report_repository.dart`:
  ```dart
  abstract class ReportRepository {
    Future<Either<Failure, LoanReport>> getLoanReport(String userId);
    Future<Either<Failure, UserSummary>> getUserSummary(String userId, String targetUserId);
    Future<Either<Failure, String>> exportLoans(List<Loan> loans, String format); // csv, pdf
  }
  ```

### Tarea 4.3: Use Cases
- [ ] Crear `filter_loans_usecase.dart`:
  - Validar filtros
  - Llamar a repository

- [ ] Crear `search_loans_usecase.dart`:
  - Debounce (300ms)
  - Llamar a repository

- [ ] Crear `get_loan_reports_usecase.dart`:
  - Calcular KPIs
  - Llamar a repository

- [ ] Crear `get_user_summary_usecase.dart`:
  - Info de una persona específica

- [ ] Crear `export_loans_usecase.dart`:
  - CSV: Generar archivo
  - PDF: Usar flutter_pdf
  - Share al usuario

### Tarea 4.4: Remote DataSource
- [ ] Actualizar Supabase queries para soportar filtros:
  ```dart
  Future<List<Loan>> getFilteredLoans(LoanFilter filter) async {
    var query = client.from('loans').select();

    if (filter.statuses != null) {
      query = query.inFilter('status', filter.statuses!.map((s) => s.toString()).toList());
    }

    if (filter.dateFrom != null) {
      query = query.gte('created_at', filter.dateFrom!.toIso8601String());
    }

    if (filter.dateTo != null) {
      query = query.lte('created_at', filter.dateTo!.toIso8601String());
    }

    if (filter.searchQuery != null) {
      query = query.or('item_name.ilike.%${filter.searchQuery}%,from_user_id.ilike.%${filter.searchQuery}%');
    }

    return query.order('created_at', ascending: false);
  }
  ```

### Tarea 4.5: Cálculo de Reportes
- [ ] En repository:
  ```dart
  Future<LoanReport> calculateReport(String userId) async {
    final loans = await getLoansByUser(userId);

    return LoanReport(
      totalOutgoing: loans.where((l) => l.fromUserId == userId).length,
      totalIncoming: loans.where((l) => l.toUserId == userId).length,
      pendingOutgoing: loans.where((l) =>
        l.fromUserId == userId && l.status != LoanStatus.returned).length,
      // ... más cálculos
    );
  }
  ```

### Tarea 4.6: BLoCs
- [ ] Actualizar `loans_bloc.dart`:
  - Evento: `FilterLoansPressed(LoanFilter filter)`
  - Evento: `SearchLoansPressed(String query)`
  - Estados con filtered loans

- [ ] Crear `reports_bloc.dart`:
  - Evento: `LoadReportPressed(String userId)`
  - Evento: `LoadUserSummaryPressed(String targetUserId)`
  - Estados: Loading, Loaded, Error

### Tarea 4.7: Screens
- [ ] Crear `filters_screen.dart`:
  - Chips para estados
  - Date range picker
  - Multi-select personas
  - Sort dropdown
  - Aplicar/Reset filtros
  - Preview de resultados

- [ ] Crear `reports_screen.dart`:
  - KPI cards (4-5 números)
  - Pie chart de estados
  - Bar chart de actividad
  - Tabla de últimos préstamos
  - Botón export

- [ ] Crear `person_summary_screen.dart`:
  - Info de la persona
  - Estadísticas personales
  - Lista de préstamos con esta persona
  - Balance total

### Tarea 4.8: Widgets
- [ ] Crear `filter_chips.dart`:
  - Chips para cada estado
  - On/off toggle
  - Multi-select

- [ ] Crear `date_range_picker.dart`:
  - Presets (semana, mes, etc)
  - Custom date picker
  - Validación

- [ ] Crear `search_bar.dart`:
  - TextField con debounce
  - Clear button
  - Sugerencias

- [ ] Crear `sort_dropdown.dart`:
  - Dropdown con opciones
  - Selection indicador

- [ ] Crear `kpi_cards.dart`:
  - Card para cada métrica
  - Número grande + label
  - Color según valor

- [ ] Crear charts:
  - `status_pie_chart.dart` (usar fl_chart package)
  - `activity_bar_chart.dart`
  - `timeline_chart.dart`

- [ ] Crear `export_button.dart`:
  - Menu: CSV, PDF
  - Share después de generar

### Tarea 4.9: Dependencias Externas
- [ ] Agregar a pubspec.yaml:
  ```yaml
  fl_chart: ^0.67.0  # Gráficos
  pdf: ^3.10.0       # Generar PDF
  path_provider: ^2.1.0  # Guardar archivos
  share_plus: ^7.2.0  # Compartir
  csv: ^5.0.2        # Generar CSV
  ```

- [ ] Actualizar `pubspec.yaml`
- [ ] `flutter pub get`

### Tarea 4.10: Integration con Home Screen
- [ ] Botón "Filtros" en loans_home_screen
- [ ] Botón "Reportes" en bottom nav o drawer
- [ ] Búsqueda en top bar
- [ ] Aplicar filtros a lista actual

### Tarea 4.11: Tests
- [ ] Unit tests para filtering logic
- [ ] Unit tests para report calculations
- [ ] Widget tests para filter screens
- [ ] Widget tests para charts
- [ ] Escenarios:
  - Filtrar por estado
  - Filtrar por rango de fechas
  - Search case-insensitive
  - Export genera archivo

---

## 📊 Ejemplos de Cálculos

### KPI: Total Prestado
```dart
final outgoing = loans
  .where((l) => l.fromUserId == userId && !l.isDeleted)
  .length;
```

### KPI: Pendiente de Cobrar
```dart
final pendingOut = loans
  .where((l) => l.fromUserId == userId &&
    [LoanStatus.pending, LoanStatus.active, LoanStatus.unmarked].contains(l.status) &&
    !l.isDeleted)
  .length;
```

### Distribución de Estados
```dart
final distribution = <LoanStatus, int>{};
for (final status in LoanStatus.values) {
  distribution[status] = loans.where((l) => l.status == status).length;
}
```

---

## 🎨 UI Mockups (Descripción)

### Filters Screen
```
┌─────────────────────────────┐
│      Filtrar Préstamos       │
├─────────────────────────────┤
│ Estados:                    │
│ ☑️ Pendiente  ☐ Devuelto    │
│ ☑️ Activo     ☐ Cancelado   │
│                             │
│ Fecha:                      │
│ De: [___] Hasta: [___]      │
│ [Esta semana][Este mes]     │
│                             │
│ Con quién:                  │
│ [Seleccionar personas...]   │
│ - Carolina Huaylla          │
│ - Jaime Huaylla             │
│                             │
│ Buscar: [_________________] │
│                             │
│ Ordenar: [Por fecha ▼]      │
│                             │
│ [Aplicar Filtros] [Reset]   │
└─────────────────────────────┘
```

### Reports Screen
```
┌─────────────────────────────┐
│       Mi Dashboard          │
├─────────────────────────────┤
│ 📤 Prestado: 45 | 💰 $1200  │
│ 📥 Recibido: 32 | 💰 $980   │
│                             │
│ 📊 Distribución de Estados  │
│ [Pie Chart aquí]            │
│                             │
│ 📈 Actividad Mensual        │
│ [Bar Chart aquí]            │
│                             │
│ ⏰ Últimas Transacciones     │
│ - Jaime: 10 papitas (2h)    │
│ - Carolina: 5L Jugo (1d)    │
│                             │
│ [Exportar CSV] [Exportar PDF]│
└─────────────────────────────┘
```

---

## ✅ Criterios de Aceptación

- [x] Filtros funcionan correctamente
- [x] Búsqueda es case-insensitive
- [x] Reportes calculan KPIs correctamente
- [x] Gráficos se muestran sin errores
- [x] Export genera archivo válido
- [x] UI responsiva en diferentes tamaños
- [x] Performance: filters aplicados en < 500ms
- [x] Tests unitarios pasan
- [x] Sin regresiones en funcionalidad anterior

---

## 🚀 Próxima Fase

FASE 5: Polish, Testing y Deployment

---

**Actualizado**: Diciembre 2025
**Responsable**: Dev Team
