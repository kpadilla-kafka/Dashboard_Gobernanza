USE [AuraPortal_BPMS_PROD];
GO

/* ============================================================
   Dashboard Gobernanza 434
   Bloque: Trámites Ambientales

   Procesos:
   - VUI-159.1 : Trámites Ambientales
   - VUI-172.1 : Presentación de Proyecto para Estaciones de Servicio
   - VUI-186.1 : Trámites SETENA

   Regla general:
   - Excluir procesos en estado:
       7 = No iniciado / Borrador
       8 = Datos predeterminados

   Traducción de _ProcessStatus:
       P.IdEstado NOT IN (7,8)

   Relación:
       AP__BPM_Procesos.ID = Panel_xxx._ElementID
   ============================================================

   VUI-159.1
   Campo:
       [3_Tipo de trámite - TramAmb]

   11668 = Permiso de vertido
   11669 = Permiso de perforación de pozos
   11670 = Concesión de aguas subterráneas
   11671 = Concesión de aguas superficiales

   ------------------------------------------------------------

   VUI-186.1
   Campo:
       [3_Tipo de trámite - SETENA]

   12636 = D1
   12637 = D1 - Torres
   12638 = D1 - C
   12639 = D1 - Desalinización con Declaración Jurada
   12640 = D1 - Desalinización con Pronóstico-Plan de Gestión Ambiental
   12641 = D1 - Desalinización con Estudio de Impacto Ambiental
   12642 = D4 - Forestal
   12643 = D6 - Cuadrante Urbano
   12644 = EDA - Estudio de Diagnóstico Ambiental
   12645 = SDA - Solicitud Devolución Garantía con Resolución de Archivo de Expediente
   12646 = SDC - Solicitud de Devolución Garantía Cierre Técnico
   12647 = RGA - Solicitud de Renovación de Garantía Ambiental
   12648 = CRG - Presentación Comprobante Renovación Garantía
   12649 = DDE - Devolución de Depósitos Erróneos
   ============================================================ */

-- ============================================================
-- VUI-159.1
-- ============================================================

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
  AND P.IdEstado NOT IN (7,8)
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
  AND P.IdEstado NOT IN (7,8)
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
  AND P.IdEstado NOT IN (7,8)
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
  AND P.IdEstado NOT IN (7,8)
  AND T.[3_Tipo de trámite - TramAmb] = 11671

-- ============================================================
-- VUI-172.1
-- ============================================================

UNION ALL

SELECT
    5,
    'Trámites Ambientales',
    172,
    'Presentación de Proyecto para Estaciones de Servicio',
    COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_172 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 172
  AND P.IdEstado NOT IN (7,8)

-- ============================================================
-- VUI-186.1
-- ============================================================

UNION ALL

SELECT 6,'Trámites Ambientales',186,'D1',COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID=P.ID
WHERE P.IdClaseProceso=186 AND P.IdEstado NOT IN (7,8)
AND T.[3_Tipo de trámite - SETENA]=12636

UNION ALL

SELECT 7,'Trámites Ambientales',186,'D1 - Torres',COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID=P.ID
WHERE P.IdClaseProceso=186 AND P.IdEstado NOT IN (7,8)
AND T.[3_Tipo de trámite - SETENA]=12637

UNION ALL

SELECT 8,'Trámites Ambientales',186,'D1 - C',COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID=P.ID
WHERE P.IdClaseProceso=186 AND P.IdEstado NOT IN (7,8)
AND T.[3_Tipo de trámite - SETENA]=12638

UNION ALL

SELECT 9,'Trámites Ambientales',186,'D1 - Desalinización con Declaración Jurada',COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID=P.ID
WHERE P.IdClaseProceso=186 AND P.IdEstado NOT IN (7,8)
AND T.[3_Tipo de trámite - SETENA]=12639

UNION ALL

SELECT 10,'Trámites Ambientales',186,'D1 - Desalinización con Pronóstico-Plan de Gestión Ambiental',COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID=P.ID
WHERE P.IdClaseProceso=186 AND P.IdEstado NOT IN (7,8)
AND T.[3_Tipo de trámite - SETENA]=12640

UNION ALL

SELECT 11,'Trámites Ambientales',186,'D1 - Desalinización con Estudio de Impacto Ambiental',COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID=P.ID
WHERE P.IdClaseProceso=186 AND P.IdEstado NOT IN (7,8)
AND T.[3_Tipo de trámite - SETENA]=12641

UNION ALL

SELECT 12,'Trámites Ambientales',186,'D4 - Forestal',COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID=P.ID
WHERE P.IdClaseProceso=186 AND P.IdEstado NOT IN (7,8)
AND T.[3_Tipo de trámite - SETENA]=12642

UNION ALL

SELECT 13,'Trámites Ambientales',186,'D6 - Cuadrante Urbano',COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID=P.ID
WHERE P.IdClaseProceso=186 AND P.IdEstado NOT IN (7,8)
AND T.[3_Tipo de trámite - SETENA]=12643

UNION ALL

SELECT 14,'Trámites Ambientales',186,'EDA - Estudio de Diagnóstico Ambiental',COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID=P.ID
WHERE P.IdClaseProceso=186 AND P.IdEstado NOT IN (7,8)
AND T.[3_Tipo de trámite - SETENA]=12644

UNION ALL

SELECT 15,'Trámites Ambientales',186,'SDA - Solicitud Devolución Garantía con Resolución de Archivo de Expediente',COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID=P.ID
WHERE P.IdClaseProceso=186 AND P.IdEstado NOT IN (7,8)
AND T.[3_Tipo de trámite - SETENA]=12645

UNION ALL

SELECT 16,'Trámites Ambientales',186,'SDC - Solicitud de Devolución Garantía Cierre Técnico',COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID=P.ID
WHERE P.IdClaseProceso=186 AND P.IdEstado NOT IN (7,8)
AND T.[3_Tipo de trámite - SETENA]=12646

UNION ALL

SELECT 17,'Trámites Ambientales',186,'RGA - Solicitud de Renovación de Garantía Ambiental',COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID=P.ID
WHERE P.IdClaseProceso=186 AND P.IdEstado NOT IN (7,8)
AND T.[3_Tipo de trámite - SETENA]=12647

UNION ALL

SELECT 18,'Trámites Ambientales',186,'CRG - Presentación Comprobante Renovación Garantía',COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID=P.ID
WHERE P.IdClaseProceso=186 AND P.IdEstado NOT IN (7,8)
AND T.[3_Tipo de trámite - SETENA]=12648

UNION ALL

SELECT 19,'Trámites Ambientales',186,'DDE - Devolución de Depósitos Erróneos',COUNT(*)
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID=P.ID
WHERE P.IdClaseProceso=186 AND P.IdEstado NOT IN (7,8)
AND T.[3_Tipo de trámite - SETENA]=12649

ORDER BY Orden;
