USE [AuraPortal_BPMS_PROD];
GO

/* ============================================================
   Dashboard Gobernanza 434
   Bloque: Trámites Registros

   Regla general:
   - _ProcessStatus distinto de Borrador
   - En BD se traduce como:
       P.IdEstado NOT IN (7,8)

   Procesos:
   - 106 = Registro IAGT (Data Completa)
   - 199 = MINSA-MAG, separado por texto:
           [3_Tipo de trámite MINSA-MAG]
   - 208 = Fichas de Emergencia para el Transporte Terrestre
           de Mercancías Peligrosas

   Valores texto:
   - CANNABIS
   - CANAMO
   ============================================================ */

SELECT
    1 AS Orden,
    'Trámites Registros' AS Bloque,
    106 AS IdClaseProceso,
    'Registro IAGT (Data Completa)' AS Tramite,
    COUNT(*) AS Cantidad
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_106 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 106
  AND P.IdEstado NOT IN (7, 8)

UNION ALL

SELECT
    2,
    'Trámites Registros',
    199,
    'Licencias de Cannabis para uso medicinal y terapéutico',
    COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_199 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 199
  AND P.IdEstado NOT IN (7, 8)
  AND UPPER(LTRIM(RTRIM(ISNULL(T.[3_Tipo de trámite MINSA-MAG], '')))) = 'CANNABIS'

UNION ALL

SELECT
    3,
    'Trámites Registros',
    199,
    'Autorizaciones de Cáñamo para uso alimentario e industrial',
    COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_199 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 199
  AND P.IdEstado NOT IN (7, 8)
  AND UPPER(LTRIM(RTRIM(ISNULL(T.[3_Tipo de trámite MINSA-MAG], '')))) = 'CANAMO'

UNION ALL

SELECT
    4,
    'Trámites Registros',
    208,
    'Fichas de Emergencia para el Transporte Terrestre de Mercancías Peligrosas',
    COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_208 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 208
  AND P.IdEstado NOT IN (7, 8)

ORDER BY Orden;
