USE [AuraPortal_BPMS_PROD];
GO

/* ============================================================
   Dashboard Gobernanza 434
   Bloque: Trámites Construcción

   Proceso:
   - VUI-226.1 Colegio Federado de Ingenieros y de Arquitectos de Costa Rica

   Regla general:
   - _ProcessStatus distinto de Borrador
   - En BD:
       P.IdEstado NOT IN (7,8)

   Campo clasificador:
   - T.[3_Tipo de trámite - CFIA]

   Tipos CFIA:
   14798 = APC
   14799 = APC - M
   14800 = APC - R
   14801 = APT
   ============================================================ */

SELECT
    1 AS Orden,
    'Trámites Construcción' AS Bloque,
    226 AS IdClaseProceso,
    'APC - ADMINISTRADOR DE PROYECTOS DE CONSTRUCCIÓN' AS Tramite,
    COUNT(*) AS Cantidad
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_226 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 226
  AND P.IdEstado NOT IN (7, 8)
  AND T.[3_Tipo de trámite - CFIA] = 14798

UNION ALL

SELECT
    2,
    'Trámites Construcción',
    226,
    'APC-M - ADMINISTRADOR DE PROYECTOS DE CONSTRUCCIÓN – MUNICIPAL',
    COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_226 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 226
  AND P.IdEstado NOT IN (7, 8)
  AND T.[3_Tipo de trámite - CFIA] = 14799

UNION ALL

SELECT
    3,
    'Trámites Construcción',
    226,
    'APC-R - ADMINISTRADOR DE PROYECTOS DE CONSTRUCCIÓN – REQUISITOS',
    COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_226 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 226
  AND P.IdEstado NOT IN (7, 8)
  AND T.[3_Tipo de trámite - CFIA] = 14800

UNION ALL

SELECT
    4,
    'Trámites Construcción',
    226,
    'APT - ADMINISTRADOR DE PROYECTOS DE TOPOGRAFÍA',
    COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_226 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 226
  AND P.IdEstado NOT IN (7, 8)
  AND T.[3_Tipo de trámite - CFIA] = 14801

ORDER BY Orden;
