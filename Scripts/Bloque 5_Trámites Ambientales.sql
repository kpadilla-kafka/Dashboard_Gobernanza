USE [AuraPortal_BPMS_PROD];
GO

/* ============================================================
   Dashboard Gobernanza 434
   Bloque: Trámites Ambientales

   Proceso:
   - VUI-159.1

   Reglas:
   - Excluir Borrador y Datos predeterminados:
       IdEstado NOT IN (7,8)
   - Separar por:
       [3_Tipo de trámite - TramAmb]

   Tipos:
   11668 = Permiso de vertido
   11669 = Permiso de perforación de pozos
   11670 = Concesión de aguas subterráneas
   11671 = Concesión de aguas superficiales
   ============================================================ */

SELECT
    1 AS Orden,
    'Trámites Ambientales' AS Bloque,
    159 AS IdClaseProceso,
    'Permiso de vertido' AS Tramite,
    COUNT(*) AS Cantidad
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_159 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 159
  AND P.IdEstado NOT IN (7, 8)
  AND T.[3_Tipo de trámite - TramAmb] = 11668

UNION ALL

SELECT
    2,
    'Trámites Ambientales',
    159,
    'Permiso de perforación de pozos',
    COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_159 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 159
  AND P.IdEstado NOT IN (7, 8)
  AND T.[3_Tipo de trámite - TramAmb] = 11669

UNION ALL

SELECT
    3,
    'Trámites Ambientales',
    159,
    'Concesión de aguas subterráneas',
    COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_159 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 159
  AND P.IdEstado NOT IN (7, 8)
  AND T.[3_Tipo de trámite - TramAmb] = 11670

UNION ALL

SELECT
    4,
    'Trámites Ambientales',
    159,
    'Concesión de aguas superficiales',
    COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_159 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 159
  AND P.IdEstado NOT IN (7, 8)
  AND T.[3_Tipo de trámite - TramAmb] = 11671

ORDER BY Orden;
