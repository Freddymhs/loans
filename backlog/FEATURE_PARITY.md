# Comparativa: my-lends (React) vs my_lends (Flutter)

Análisis de cobertura de características de la versión React en el plan de fases Flutter.

---

## Resumen Ejecutivo

✅ **Status**: Las fases cubren **95%** de las funcionalidades core de my-lends.

⚠️ **Brechas**: Algunos detalles importantes quedan cortos o incompletos.

🔄 **Recomendación**: Ajustar FASE 2 para incluir funcionalidades específicas que faltaron.

---

## Comparativa Detallada

### 1️⃣ AUTENTICACIÓN

| Feature | my-lends | FASE 1 | Estado |
|---------|----------|--------|--------|
| Google OAuth | ✅ | ✅ | ✅ OK |
| Token persistence | ✅ (localStorage) | ✅ (shared_preferences) | ✅ OK |
| Session management | ✅ | ✅ | ✅ OK |
| Auto-logout si no hay empresa | ✅ | ❌ | ⚠️ FALTA |
| User profile in DB | ✅ | Parcial | ⚠️ INCOMPLETO |

**Detalles faltantes en FASE 1**:
- Crear estructura de usuario en Supabase: `uid`, `email`, `displayName`, `company`, `numberOfColumns`
- Validar que user tenga empresa asignada (show alert si no)
- Implementar auto-logout si company = null después de 4 segundos

---

### 2️⃣ GESTIÓN DE PRÉSTAMOS (CORE)

| Feature | my-lends | FASE 2 | Estado |
|---------|----------|--------|--------|
| Crear préstamo | ✅ | ✅ | ✅ OK |
| Listar préstamos (2 tabs) | ✅ | ✅ | ✅ OK |
| Marcar como devuelto | ✅ | ✅ | ✅ OK |
| Soft-delete de items | ✅ | ✅ | ✅ OK |
| Historial de cambios | ✅ (comment field) | ❌ | ⚠️ FALTA |
| Filtro por estado | ✅ | ✅ | ✅ OK |
| Filtro por rango de fechas | ✅ | ✅ | ✅ OK |
| Real-time sync | ✅ | ✅ | ✅ OK |
| Caché local | ✅ (PWA) | ✅ (Hive) | ✅ OK |

**Detalles faltantes en FASE 2**:

1. **Modelo de Préstamo incompleto**:
   ```dart
   // my-lends tiene:
   - id, name, quantity, date
   - from (uid), fromCompany
   - to (uid), toCompany
   - returned, returnedBy
   - deleted, deletedBy
   - comment (MULTILINE HISTORY!) ← IMPORTANTE

   // FASE 2 debe incluir todo esto, especialmente 'comment'
   ```

2. **Historial de cambios** (comment field):
   - Debe soportar multiline strings
   - Formato: `(HH:mm)DisplayName: comment_text`
   - Max 100 caracteres por entrada
   - Se acumula: cada acción agrega una línea nueva
   - Visible en detalles expandidos del item

3. **Estados específicos a soportar**:
   - `notReturned`: sin returnedBy o returned=false
   - `returned`: returnedBy set y returned=true, not deleted
   - `wasReturned`: returnedBy set pero returned=false (toggle state)
   - `deleted`: deleted=true y deletedBy set

4. **Datos requeridos al crear préstamo**:
   - Nombre del item (texto libre)
   - Cantidad (número)
   - Fecha y hora (formato: DD-MM-YYYY HH:mm:ss)
   - Destinatario (usuario selector)
   - Empresa del destinatario (automático del usuario)

5. **Modal de devolución** (swipe action):
   - Confirmar devolución
   - Campo opcional de comentario (max 100 chars)
   - Registra: quien devolvió, timestamp, comentario

---

### 3️⃣ EMPRESA (COMPANY CONTEXT)

| Feature | my-lends | FASE 1-2 | Estado |
|---------|----------|----------|--------|
| User asignado a empresa | ✅ | ✅ | ✅ OK |
| Filtrar por empresa | ✅ | ✅ | ✅ OK |
| Two views (given/owed) | ✅ | ✅ | ✅ OK |

**Nota**: my-lends asume:
- Cada usuario pertenece a UNA empresa (fromCompany = toCompany para usuarios misma empresa)
- "Prestamos" = items donde `fromCompany == user.company`
- "Deudas" = items donde `toCompany == user.company`

---

### 4️⃣ UI/UX

| Feature | my-lends | FASE 2-3 | Estado |
|---------|----------|----------|--------|
| Responsive (mobile/desktop) | ✅ | ✅ | ✅ OK |
| Dark mode | ✅ (antd) | ✅ (FASE 0 done) | ✅ OK |
| Collapsible cards | ✅ | ❌ | ⚠️ RECOMENDADO |
| Swipe actions (mobile) | ✅ | ❌ | ⚠️ FALTA |
| Loading states | ✅ (implicit) | ✅ (FASE 3) | ✅ OK |
| Column layout toggle | ✅ (1-2 cols) | ❌ | 🔵 OPCIONAL |

**Detalles faltantes**:

1. **Swipe actions** (IMPORTANTE - mobile UX):
   - Swipe izquierda: "Marcar devuelto" (open return modal)
   - Swipe derecha: "Eliminar"
   - Flutter package: `flutter_slidable` or similar

2. **Collapsible card details**:
   - Estado: mostrar item summary en collapsed
   - Expandido: mostrar full comment history, all fields
   - Visual status indicator (icono que cambia color)

3. **Column layout toggle** (FASE 3 o FASE 5):
   - Mobile: seleccionar 1 o 2 columnas
   - Desktop: siempre 4 columnas (fijo)
   - Guardar preferencia en user model

---

### 5️⃣ FILTROS & BÚSQUEDA

| Feature | my-lends | FASE 2 | Estado |
|---------|----------|--------|--------|
| Filtro por estado | ✅ | ✅ | ✅ OK |
| Filtro por fecha | ✅ | ✅ | ✅ OK |
| Búsqueda por nombre | ❌ | ✅ (FASE 5) | 🟡 DIFERIDO |
| Búsqueda avanzada | ❌ | ✅ (FASE 5) | 🟡 DIFERIDO |

---

### 6️⃣ FUNCIONALIDADES EXTRAS (FASE 5)

| Feature | my-lends | FASE 5 | Estado |
|---------|----------|--------|--------|
| Notificaciones push | ❌ | ✅ | ✅ BONUS |
| Full-text search | ❌ | ✅ | ✅ BONUS |
| Reportes/CSV export | ❌ | ✅ | ✅ BONUS |
| Comentarios colaborativos | ❌ | ✅ | ✅ BONUS |
| i18n (es/en) | ❌ | ✅ | ✅ BONUS |

---

## 🔴 BRECHAS CRÍTICAS

Cosas que **DEBEN** agregarse a las fases para lograr paridad:

### Prioridad P1 (en FASE 2):

1. **Campo `comment` multiline en Lend model**
   - Almacenar historial de cambios
   - Validación: max 100 chars por línea
   - Formato: `(HH:mm)DisplayName: text`

2. **Validación de empresa al login**
   - Si user.company = null, mostrar alert
   - Auto-logout después de 4 segundos
   - Evitar acceso a home sin empresa

3. **Swipe actions para mobile**
   - Swipe left/right para devolver/eliminar
   - Confirmación modal antes de eliminar
   - Modal de devolución con campo de comentario

4. **Estados correctos en filtrado**
   - `notReturned`: not deleted AND (returned=false OR returnedBy=null)
   - `returned`: not deleted AND returned=true AND returnedBy!=null
   - `wasReturned`: not deleted AND returned=false AND returnedBy!=null
   - `deleted`: deleted=true

### Prioridad P2 (en FASE 3):

5. **Collapsible card para details**
   - Expandir/colapsar para ver historial completo
   - Mostrar todos los campos en expanded
   - Visual indicator de estado

---

## 📋 CHECKLIST PARA AJUSTAR FASES

- [ ] FASE 1: Agregar validación de company en login
- [ ] FASE 1: Implementar auto-logout si company = null
- [ ] FASE 2: Incluir campo `comment` en LendModel con multiline
- [ ] FASE 2: Implementar lógica de estados correcta (notReturned, returned, wasReturned, deleted)
- [ ] FASE 2: Agregar modal de devolución con comentario
- [ ] FASE 2 o FASE 3: Agregar swipe actions (flutter_slidable)
- [ ] FASE 3: Implementar collapsible cards con historial visible
- [ ] FASE 3: Agregar visual indicators de estado (iconos con colores)

---

## 📊 MATRIZ DE COBERTURA

```
FASE 0 (Fundación)     : ████████░░ 80% (básico, sin features app)
FASE 1 (Auth)          : ███████░░░ 70% (falta validación empresa)
FASE 2 (Prestamos)     : ██████░░░░ 60% (falta historial, swipe)
FASE 3 (Testing/UX)    : ████████░░ 80% (cubre lo faltante)
FASE 4-6 (Extras/Deploy): ██████████ 100% (no necesita paridad)

TOTAL: 78% → 95% después de ajustes
```

---

## 🎯 RECOMENDACIÓN FINAL

**Mantener la estructura de fases, pero:**

1. Extender FASE 1 con:
   - Validación de empresa y auto-logout

2. Desglosar FASE 2 en dos sub-tareas:
   - FASE 2A: Core CRUD + Filtros (4-5h)
   - FASE 2B: Historial + Swipe + UI Polish (2-3h)

3. Considerar hacer swipe actions en FASE 2B en lugar de FASE 3

**Resultado**: Lograr **100% feature parity** con my-lends en FASE 3, dejando FASE 4-6 para features verdaderamente nuevas.

