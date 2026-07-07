USE [AuraPortal_BPMS_PROD];
GO

/* ============================================================
   Dashboard Gobernanza 434
   Bloque: Trámites Institucionales

   Regla general:
   - _ProcessStatus distinto de Borrador
   - En BD se traduce como:
       P.IdEstado NOT IN (7,8)

   IdEstado:
   0 = Iniciado
   1 = Terminado
   2 = Detenido
   7 = No iniciado / Borrador
   8 = Datos predeterminados
   ============================================================ */

SELECT
    1 AS Orden,
    'Trámites Institucionales' AS Bloque,
    74 AS IdClaseProceso,
    'Emisión de Criterios Técnicos sobre Humedales' AS Tramite,
    COUNT(*) AS Cantidad
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_74 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 74
  AND P.IdEstado NOT IN (7, 8)

UNION ALL

SELECT
    2,
    'Trámites Institucionales',
    167,
    'Firmas Declaraciones Juradas',
    COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_167 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 167
  AND P.IdEstado NOT IN (7, 8)

UNION ALL

SELECT
    3,
    'Trámites Institucionales',
    77,
    'Gestión de Aprobaciones',
    COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_77 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 77
  AND P.IdEstado NOT IN (7, 8)

UNION ALL

SELECT
    4,
    'Trámites Institucionales',
    177,
    'Inspecciones AFPA',
    COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_177 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 177
  AND P.IdEstado NOT IN (7, 8)

UNION ALL

SELECT
    5,
    'Trámites Institucionales',
    173,
    'Planes Reguladores',
    COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_173 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 173
  AND P.IdEstado NOT IN (7, 8)

ORDER BY Orden;
