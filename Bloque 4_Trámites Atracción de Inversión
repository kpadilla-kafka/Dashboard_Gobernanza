USE [AuraPortal_BPMS_PROD];
GO

/* ============================================================
   Dashboard Gobernanza 434
   Bloque: Trámites Atracción de Inversión

   Trámite:
   - VUI-161.1 Proyecto de Inversión Fílmica y Audiovisual

   Regla:
   - Distinto de Borrador / _ProcessStatus
   - En BD se traduce como: IdEstado NOT IN (7,8)

   IdEstado:
   0 = Iniciado
   1 = Terminado
   2 = Detenido
   7 = No iniciado / Borrador
   8 = Datos predeterminados
   ============================================================ */

SELECT
    1 AS Orden,
    'Trámites Atracción de Inversión' AS Bloque,
    161 AS IdClaseProceso,
    'Proyecto de Inversión Fílmica y Audiovisual' AS Tramite,
    COUNT(*) AS Cantidad
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_161 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 161
  AND P.IdEstado NOT IN (7, 8);
