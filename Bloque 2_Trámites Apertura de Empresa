DECLARE @FechaInicio DATETIME = NULL; -- Ejemplo: '2025-01-01'
DECLARE @FechaFin    DATETIME = NULL; -- Ejemplo: '2025-12-31'

/*=========================================================
  BLOQUE: Trámites Apertura de Empresa

  Notas generales:
  - @FechaInicio y @FechaFin son opcionales.
  - Cuando van NULL, el reporte trae todo el histórico.
  - Para el proceso 20:
      12739 = Permiso Sanitario de Funcionamiento
      12740 = Permiso de Habilitación
  - Para el proceso 73:
      4728 = Renovación
      4727 = Modificación
      4726 = Cancelación
      12739 = PSF
      12740 = Habilitación
  - Para el proceso 119:
      13971 = Primera vez
      8925  = Renovación
      8924  = Modificación
      8926  = Reporte Operacional
=========================================================*/

SELECT
    'Trámites Apertura de Empresa' AS Bloque,
    1 AS Orden,
    21 AS IdClaseProceso,
    'Certificado Veterinario de Operación (CVO)' AS NombreTramite,
    COUNT(P.ID) AS Cantidad
FROM AP__BPM_Procesos P WITH (NOLOCK)
WHERE P.IdClaseProceso = 21
  AND P.IdEstado IN (0,1,2)
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

SELECT
    'Trámites Apertura de Empresa',
    2,
    36,
    'Patente Comercial',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_36 P36 WITH (NOLOCK)
    ON P36._ElementID = P.ID
WHERE P.IdClaseProceso = 36
  AND P.IdEstado IN (0,1,2)
  AND P36.[3_Tipo de trámite] = 2054
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

SELECT
    'Trámites Apertura de Empresa',
    3,
    36,
    'Patente Comercial Cambio de Ubicación',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_36 P36 WITH (NOLOCK)
    ON P36._ElementID = P.ID
WHERE P.IdClaseProceso = 36
  AND P.IdEstado IN (0,1,2)
  AND P36.[3_Tipo de trámite] = 2059
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

SELECT
    'Trámites Apertura de Empresa',
    4,
    36,
    'Patente Comercial Cambio de Actividad',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_36 P36 WITH (NOLOCK)
    ON P36._ElementID = P.ID
WHERE P.IdClaseProceso = 36
  AND P.IdEstado IN (0,1,2)
  AND P36.[3_Tipo de trámite] = 2057
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

SELECT
    'Trámites Apertura de Empresa',
    5,
    36,
    'Licencia de Licores',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_36 P36 WITH (NOLOCK)
    ON P36._ElementID = P.ID
WHERE P.IdClaseProceso = 36
  AND P.IdEstado IN (0,1,2)
  AND P36.[3_Tipo de trámite] = 2055
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

/* 6 - Permiso Sanitario de Funcionamiento */
SELECT
    'Trámites Apertura de Empresa',
    6,
    20,
    'Permiso Sanitario de Funcionamiento',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_20 P20 WITH (NOLOCK)
    ON P20._ElementID = P.ID
INNER JOIN Panel_20_o1 P1 WITH (NOLOCK)
    ON P20.ID = P1._BaseTableRegisterID
INNER JOIN Panel_20_o4 P4 WITH (NOLOCK)
    ON P4._BaseTableRegisterID = P1._BaseTableRegisterID
WHERE P.IdClaseProceso = 20
  AND P.IdEstado NOT IN (7,8)
  AND P4.[3_Tipo de trámite PSF Hab] = 12739
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

/* 7 - PSF Renovación */
SELECT
    'Trámites Apertura de Empresa',
    7,
    73,
    'Permiso Sanitario de Funcionamiento Renovación',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_73 P73 WITH (NOLOCK)
    ON P73._ElementID = P.ID
INNER JOIN Panel_73_o1 P1 WITH (NOLOCK)
    ON P73.ID = P1._BaseTableRegisterID
INNER JOIN Panel_73_o3 P3 WITH (NOLOCK)
    ON P3._BaseTableRegisterID = P1._BaseTableRegisterID
WHERE P.IdClaseProceso = 73
  AND P.IdEstado NOT IN (7,8)
  AND P73.[3_Tipo de trámite PSF] = 4728
  AND P3.[3_Tipo de trámite PSF Hab] = 12739
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

/* 8 - PSF Modificación */
SELECT
    'Trámites Apertura de Empresa',
    8,
    73,
    'Permiso Sanitario de Funcionamiento Modificación',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_73 P73 WITH (NOLOCK)
    ON P73._ElementID = P.ID
INNER JOIN Panel_73_o1 P1 WITH (NOLOCK)
    ON P73.ID = P1._BaseTableRegisterID
INNER JOIN Panel_73_o3 P3 WITH (NOLOCK)
    ON P3._BaseTableRegisterID = P1._BaseTableRegisterID
WHERE P.IdClaseProceso = 73
  AND P.IdEstado NOT IN (7,8)
  AND P73.[3_Tipo de trámite PSF] = 4727
  AND P3.[3_Tipo de trámite PSF Hab] = 12739
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

/* 9 - PSF Cancelación */
SELECT
    'Trámites Apertura de Empresa',
    9,
    73,
    'Permiso Sanitario de Funcionamiento Cancelación',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_73 P73 WITH (NOLOCK)
    ON P73._ElementID = P.ID
INNER JOIN Panel_73_o1 P1 WITH (NOLOCK)
    ON P73.ID = P1._BaseTableRegisterID
INNER JOIN Panel_73_o3 P3 WITH (NOLOCK)
    ON P3._BaseTableRegisterID = P1._BaseTableRegisterID
WHERE P.IdClaseProceso = 73
  AND P.IdEstado NOT IN (7,8)
  AND P73.[3_Tipo de trámite PSF] = 4726
  AND P3.[3_Tipo de trámite PSF Hab] = 12739
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

/* 10 - Permiso de Habilitación */
SELECT
    'Trámites Apertura de Empresa',
    10,
    20,
    'Permiso de Habilitación',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_20 P20 WITH (NOLOCK)
    ON P20._ElementID = P.ID
INNER JOIN Panel_20_o1 P1 WITH (NOLOCK)
    ON P20.ID = P1._BaseTableRegisterID
INNER JOIN Panel_20_o4 P4 WITH (NOLOCK)
    ON P4._BaseTableRegisterID = P1._BaseTableRegisterID
WHERE P.IdClaseProceso = 20
  AND P.IdEstado NOT IN (7,8)
  AND P4.[3_Tipo de trámite PSF Hab] = 12740
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

/* 11 - Habilitación Renovación */
SELECT
    'Trámites Apertura de Empresa',
    11,
    73,
    'Permiso de Habilitación Renovación',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_73 P73 WITH (NOLOCK)
    ON P73._ElementID = P.ID
INNER JOIN Panel_73_o1 P1 WITH (NOLOCK)
    ON P73.ID = P1._BaseTableRegisterID
INNER JOIN Panel_73_o3 P3 WITH (NOLOCK)
    ON P3._BaseTableRegisterID = P1._BaseTableRegisterID
WHERE P.IdClaseProceso = 73
  AND P.IdEstado NOT IN (7,8)
  AND P73.[3_Tipo de trámite PSF] = 4728
  AND P3.[3_Tipo de trámite PSF Hab] = 12740
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

/* 12 - Habilitación Modificación */
SELECT
    'Trámites Apertura de Empresa',
    12,
    73,
    'Permiso de Habilitación Modificación',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_73 P73 WITH (NOLOCK)
    ON P73._ElementID = P.ID
INNER JOIN Panel_73_o1 P1 WITH (NOLOCK)
    ON P73.ID = P1._BaseTableRegisterID
INNER JOIN Panel_73_o3 P3 WITH (NOLOCK)
    ON P3._BaseTableRegisterID = P1._BaseTableRegisterID
WHERE P.IdClaseProceso = 73
  AND P.IdEstado NOT IN (7,8)
  AND P73.[3_Tipo de trámite PSF] = 4727
  AND P3.[3_Tipo de trámite PSF Hab] = 12740
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

/* 13 - Habilitación Cancelación */
SELECT
    'Trámites Apertura de Empresa',
    13,
    73,
    'Permiso de Habilitación Cancelación',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_73 P73 WITH (NOLOCK)
    ON P73._ElementID = P.ID
INNER JOIN Panel_73_o1 P1 WITH (NOLOCK)
    ON P73.ID = P1._BaseTableRegisterID
INNER JOIN Panel_73_o3 P3 WITH (NOLOCK)
    ON P3._BaseTableRegisterID = P1._BaseTableRegisterID
WHERE P.IdClaseProceso = 73
  AND P.IdEstado NOT IN (7,8)
  AND P73.[3_Tipo de trámite PSF] = 4726
  AND P3.[3_Tipo de trámite PSF Hab] = 12740
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

/* 14 - Registro de Gestor de Residuos */
SELECT
    'Trámites Apertura de Empresa',
    14,
    20,
    'Registro de Gestor de Residuos',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_20 P20 WITH (NOLOCK)
    ON P20._ElementID = P.ID
INNER JOIN Panel_20_o1 P1 WITH (NOLOCK)
    ON P20.ID = P1._BaseTableRegisterID
INNER JOIN Panel_20_o2 P2 WITH (NOLOCK)
    ON P2._BaseTableRegisterID = P1._BaseTableRegisterID
WHERE P.IdClaseProceso = 20
  AND P.IdEstado IN (0,1,2)
  AND P2.[3_TrámiteGestor] = 1
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

/* 15 - Renovación del Registro de Gestor de Residuos */
SELECT
    'Trámites Apertura de Empresa',
    15,
    119,
    'Renovación del Registro de Gestor de Residuos',
    (
        SELECT COUNT(*)
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN Panel_73 P73 WITH (NOLOCK)
            ON P73._ElementID = P.ID
        INNER JOIN Panel_73_o1 P1 WITH (NOLOCK)
            ON P73.ID = P1._BaseTableRegisterID
        INNER JOIN Panel_73_o3 P3 WITH (NOLOCK)
            ON P3._BaseTableRegisterID = P1._BaseTableRegisterID
        WHERE P.IdClaseProceso = 73
          AND P.IdEstado NOT IN (7,8)
          AND P3.[3_TrámiteGestor] = 1
          AND P3.[3_Tipo de trámite - Gestor de residuos] IS NULL
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))
    )
    +
    (
        SELECT COUNT(*)
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN Panel_119 P119 WITH (NOLOCK)
            ON P119._ElementID = P.ID
        INNER JOIN Panel_119_o1 O1 WITH (NOLOCK)
            ON O1._BaseTableRegisterID = P119.ID
        INNER JOIN Panel_119_o2 O2 WITH (NOLOCK)
            ON O2._BaseTableRegisterID = P119.ID
        WHERE P.IdClaseProceso = 119
          AND P.IdEstado NOT IN (7,8)
          AND O1.[3_Tipo de trámite - Gestor de residuos] = 8925
          AND ISNULL(O2.[3_Renovación con PSF físico - GR],0) = 0
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))
    )

UNION ALL

/* 16 - Modificación al Registro de Gestor de Residuos */
SELECT
    'Trámites Apertura de Empresa',
    16,
    119,
    'Modificación al Registro de Gestor de Residuos',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_119 P119 WITH (NOLOCK)
    ON P119._ElementID = P.ID
INNER JOIN Panel_119_o1 O1 WITH (NOLOCK)
    ON O1._BaseTableRegisterID = P119.ID
INNER JOIN Panel_119_o2 O2 WITH (NOLOCK)
    ON O2._BaseTableRegisterID = P119.ID
WHERE P.IdClaseProceso = 119
  AND P.IdEstado NOT IN (7,8)
  AND O1.[3_Tipo de trámite - Gestor de residuos] = 8924
  AND ISNULL(O2.[3_Modificación con PSF físico - GR],0) = 0
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

/* 17 - Registro de Gestor por primera vez con PSF físico */
SELECT
    'Trámites Apertura de Empresa',
    17,
    119,
    'Registro de Gestor de Residuos por primera vez con un PSF vigente en físico',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_119 P119 WITH (NOLOCK)
    ON P119._ElementID = P.ID
INNER JOIN Panel_119_o1 O1 WITH (NOLOCK)
    ON O1._BaseTableRegisterID = P119.ID
INNER JOIN Panel_119_o2 O2 WITH (NOLOCK)
    ON O2._BaseTableRegisterID = P119.ID
WHERE P.IdClaseProceso = 119
  AND P.IdEstado NOT IN (7,8)
  AND O1.[3_Tipo de trámite - Gestor de residuos] = 13971
  AND O2.[3_Primera vez con PSF físico - GR] = 1
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

/* 18 - Renovación del Registro de Gestor con PSF físico */
SELECT
    'Trámites Apertura de Empresa',
    18,
    119,
    'Renovación del Registro de Gestor de Residuos con un PSF vigente en físico',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_119 P119 WITH (NOLOCK)
    ON P119._ElementID = P.ID
INNER JOIN Panel_119_o1 O1 WITH (NOLOCK)
    ON O1._BaseTableRegisterID = P119.ID
INNER JOIN Panel_119_o2 O2 WITH (NOLOCK)
    ON O2._BaseTableRegisterID = P119.ID
WHERE P.IdClaseProceso = 119
  AND P.IdEstado NOT IN (7,8)
  AND O1.[3_Tipo de trámite - Gestor de residuos] = 8925
  AND O2.[3_Renovación con PSF físico - GR] = 1
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

/* 19 - Modificación del Registro de Gestor con PSF físico */
SELECT
    'Trámites Apertura de Empresa',
    19,
    119,
    'Modificación del Registro de Gestor de Residuos con un PSF vigente en físico',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_119 P119 WITH (NOLOCK)
    ON P119._ElementID = P.ID
INNER JOIN Panel_119_o1 O1 WITH (NOLOCK)
    ON O1._BaseTableRegisterID = P119.ID
INNER JOIN Panel_119_o2 O2 WITH (NOLOCK)
    ON O2._BaseTableRegisterID = P119.ID
WHERE P.IdClaseProceso = 119
  AND P.IdEstado NOT IN (7,8)
  AND O1.[3_Tipo de trámite - Gestor de residuos] = 8924
  AND O2.[3_Modificación con PSF físico - GR] = 1
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

UNION ALL

/* 20 - Reporte de Gestión Integral de Residuos */
SELECT
    'Trámites Apertura de Empresa',
    20,
    119,
    'Reporte de Gestión Integral de Residuos',
    COUNT(P.ID)
FROM AP__BPM_Procesos P WITH (NOLOCK)
INNER JOIN Panel_119 P119 WITH (NOLOCK)
    ON P119._ElementID = P.ID
INNER JOIN Panel_119_o1 O1 WITH (NOLOCK)
    ON O1._BaseTableRegisterID = P119.ID
WHERE P.IdClaseProceso = 119
  AND P.IdEstado NOT IN (7,8)
  AND O1.[3_Tipo de trámite - Gestor de residuos] = 8926
  AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
  AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

ORDER BY Orden;
