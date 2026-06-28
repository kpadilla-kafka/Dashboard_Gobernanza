USE [AuraPortal_BPMS_PROD];
GO

/* ============================================================
   Dashboard Gobernanza 434
   Bloque: Trámites Zonas Francas

   Reglas:
   - Excluir borradores: AP__BPM_Procesos.IdEstado <> 7
   - Proceso 2   -> Panel_2
   - Proceso 134 -> Panel_134
   - Proceso 197 -> Panel_197, separado por:
                   [3_Tipo de trámite Migración]

   IdEstado:
   0 = Iniciado
   1 = Terminado
   2 = Detenido
   7 = No iniciado / Borrador
   8 = Datos predeterminados

   Tipos Migración:
   13164 = Residencias Temporales Dependientes
   13165 = Residencias Temporales Ejecutivos
   13166 = Estancias
   ============================================================ */

SELECT
    1 AS Orden,
    'Trámites Zonas Francas' AS Bloque,
    2 AS IdClaseProceso,
    'Solicitud de Ingreso al Régimen de Zonas Francas' AS Tramite,
    COUNT(*) AS Cantidad
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_2 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 2
  AND P.IdEstado NOT IN (7, 8)

UNION ALL

SELECT
    2 AS Orden,
    'Trámites Zonas Francas' AS Bloque,
    134 AS IdClaseProceso,
    'Solicitud de Ingreso al Régimen de Zonas Francas - 20 Bis' AS Tramite,
    COUNT(*) AS Cantidad
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_134 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 134
  AND P.IdEstado NOT IN (7, 8)

UNION ALL

SELECT
    3 AS Orden,
    'Trámites Zonas Francas' AS Bloque,
    197 AS IdClaseProceso,
    'Solicitud de Estancias Categoría A: Empresas bajo el Régimen de Zona Franca' AS Tramite,
    COUNT(*) AS Cantidad
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_197 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 197
  AND P.IdEstado NOT IN (7, 8)
  AND T.[3_Tipo de trámite Migración] = 13166

UNION ALL

SELECT
    4 AS Orden,
    'Trámites Zonas Francas' AS Bloque,
    197 AS IdClaseProceso,
    'Solicitud de Ejecutivos Categoría A: Empresas bajo el Régimen de Zona Franca' AS Tramite,
    COUNT(*) AS Cantidad
FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN dbo.Panel_197 T WITH (NOLOCK)
    ON T._ElementID = P.ID
WHERE P.IdClaseProceso = 197
  AND P.IdEstado NOT IN (7, 8)
  AND ISNULL(T.[3_Tipo de trámite Migración], 0) <> 13166

ORDER BY Orden;
