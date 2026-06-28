USE [AuraPortal_BPMS_PROD];
GO

CREATE OR ALTER PROCEDURE dbo.sp_DashboardGobernanza
    @FechaInicio DATETIME = NULL,
    @FechaFin    DATETIME = NULL,
    @Bloque      NVARCHAR(150) = N'Todos'
AS
BEGIN
    SET NOCOUNT ON;

    /***********************************************************
      Dashboard Gobernanza 434
      Proyecto: PROCOMER

      Descripción:
      Devuelve la información consolidada del Dashboard de
      Gobernanza según rango de fechas y bloque seleccionado.

      Bloques incluidos:
      1. Trámites previos a Apertura de Empresa
      2. Trámites Apertura de Empresa
      3. Trámites Zonas Francas
      4. Trámites Atracción de Inversión
      5. Trámites Ambientales
      6. Trámites Institucionales
      7. Trámites Registros
      8. Trámites Construcción
    ************************************************************/

    DECLARE @Resultados TABLE
    (
        Bloque NVARCHAR(150),
        Orden INT,
        IdClaseProceso INT,
        NombreTramite NVARCHAR(500),
        Cantidad INT
    );

    ------------------------------------------------------------
    -- Bloque 1: Trámites previos a Apertura de Empresa
    ------------------------------------------------------------
    INSERT INTO @Resultados
    SELECT N'Trámites previos a Apertura de Empresa', 1, 45, N'Calderas (Versión 1)', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    WHERE P.IdClaseProceso = 45
      AND P.IdEstado IN (0,1,2)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites previos a Apertura de Empresa', 2, 154, N'Calderas Operación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_154 P154 WITH (NOLOCK) ON P154._ElementID = P.ID
    WHERE P.IdClaseProceso = 154
      AND P.IdEstado IN (0,1,2)
      AND P154.[3_Selección de trámite caldera] = 2216
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites previos a Apertura de Empresa', 3, 154, N'Calderas Instalación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_154 P154 WITH (NOLOCK) ON P154._ElementID = P.ID
    WHERE P.IdClaseProceso = 154
      AND P.IdEstado IN (0,1,2)
      AND P154.[3_Selección de trámite caldera] = 2215
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites previos a Apertura de Empresa', 4, 152, N'Calderas Inspección Anual', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_152 P152 WITH (NOLOCK) ON P152._ElementID = P.ID
    WHERE P.IdClaseProceso = 152
      AND P.IdEstado IN (0,1,2)
      AND P152.[3_Tipo de trámite - Módulos calderas] = 11513
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites previos a Apertura de Empresa', 5, 152, N'Calderas Renovación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_152 P152 WITH (NOLOCK) ON P152._ElementID = P.ID
    WHERE P.IdClaseProceso = 152
      AND P.IdEstado IN (0,1,2)
      AND P152.[3_Tipo de trámite - Módulos calderas] = 11510
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites previos a Apertura de Empresa', 6, 152, N'Calderas Modificación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_152 P152 WITH (NOLOCK) ON P152._ElementID = P.ID
    WHERE P.IdClaseProceso = 152
      AND P.IdEstado IN (0,1,2)
      AND P152.[3_Tipo de trámite - Módulos calderas] = 12311
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites previos a Apertura de Empresa', 7, 152, N'Calderas Cancelación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_152 P152 WITH (NOLOCK) ON P152._ElementID = P.ID
    WHERE P.IdClaseProceso = 152
      AND P.IdEstado IN (0,1,2)
      AND P152.[3_Tipo de trámite - Módulos calderas] = 11512
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites previos a Apertura de Empresa', 8, 38, N'Sistema de Tratamiento de Aguas Residuales', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    WHERE P.IdClaseProceso = 38
      AND P.IdEstado IN (0,1,2)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites previos a Apertura de Empresa', 9, 176, N'Sistema de Tratamiento de Aguas Residuales Renovación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_176 P176 WITH (NOLOCK) ON P176._ElementID = P.ID
    WHERE P.IdClaseProceso = 176
      AND P.IdEstado IN (0,1,2)
      AND P176.[3_Tipo de trámite STAR] = 12126
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites previos a Apertura de Empresa', 10, 176, N'Sistema de Tratamiento de Aguas Residuales Modificación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_176 P176 WITH (NOLOCK) ON P176._ElementID = P.ID
    WHERE P.IdClaseProceso = 176
      AND P.IdEstado IN (0,1,2)
      AND P176.[3_Tipo de trámite STAR] = 12125
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites previos a Apertura de Empresa', 11, 44, N'Tanques de Autoconsumo', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    WHERE P.IdClaseProceso = 44
      AND P.IdEstado IN (0,1,2)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites previos a Apertura de Empresa', 12, 192, N'Tanques de Autoconsumo Renovación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_192 P192 WITH (NOLOCK) ON P192._ElementID = P.ID
    WHERE P.IdClaseProceso = 192
      AND P.IdEstado IN (0,1,2)
      AND P192.[3_Tipo de trámite Tanques] = 12788
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites previos a Apertura de Empresa', 13, 192, N'Tanques de Autoconsumo Modificación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_192 P192 WITH (NOLOCK) ON P192._ElementID = P.ID
    WHERE P.IdClaseProceso = 192
      AND P.IdEstado IN (0,1,2)
      AND P192.[3_Tipo de trámite Tanques] = 12787
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites previos a Apertura de Empresa', 14, 192, N'Tanques de Autoconsumo Cancelación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_192 P192 WITH (NOLOCK) ON P192._ElementID = P.ID
    WHERE P.IdClaseProceso = 192
      AND P.IdEstado IN (0,1,2)
      AND P192.[3_Tipo de trámite Tanques] = 12789
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin));

    ------------------------------------------------------------
    -- Bloque 2: Trámites Apertura de Empresa
    ------------------------------------------------------------
    INSERT INTO @Resultados
    SELECT N'Trámites Apertura de Empresa', 1, 21, N'Certificado Veterinario de Operación (CVO)', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    WHERE P.IdClaseProceso = 21
      AND P.IdEstado IN (0,1,2)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 2, 36, N'Patente Comercial', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_36 P36 WITH (NOLOCK) ON P36._ElementID = P.ID
    WHERE P.IdClaseProceso = 36
      AND P.IdEstado IN (0,1,2)
      AND P36.[3_Tipo de trámite] = 2054
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 3, 36, N'Patente Comercial Cambio de Ubicación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_36 P36 WITH (NOLOCK) ON P36._ElementID = P.ID
    WHERE P.IdClaseProceso = 36
      AND P.IdEstado IN (0,1,2)
      AND P36.[3_Tipo de trámite] = 2059
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 4, 36, N'Patente Comercial Cambio de Actividad', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_36 P36 WITH (NOLOCK) ON P36._ElementID = P.ID
    WHERE P.IdClaseProceso = 36
      AND P.IdEstado IN (0,1,2)
      AND P36.[3_Tipo de trámite] = 2057
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 5, 36, N'Licencia de Licores', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_36 P36 WITH (NOLOCK) ON P36._ElementID = P.ID
    WHERE P.IdClaseProceso = 36
      AND P.IdEstado IN (0,1,2)
      AND P36.[3_Tipo de trámite] = 2055
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 6, 20, N'Permiso Sanitario de Funcionamiento', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_20 P20 WITH (NOLOCK) ON P20._ElementID = P.ID
    INNER JOIN Panel_20_o1 P1 WITH (NOLOCK) ON P20.ID = P1._BaseTableRegisterID
    INNER JOIN Panel_20_o4 P4 WITH (NOLOCK) ON P4._BaseTableRegisterID = P1._BaseTableRegisterID
    WHERE P.IdClaseProceso = 20
      AND P.IdEstado NOT IN (7,8)
      AND P4.[3_Tipo de trámite PSF Hab] = 12739
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 7, 73, N'Permiso Sanitario de Funcionamiento Renovación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_73 P73 WITH (NOLOCK) ON P73._ElementID = P.ID
    INNER JOIN Panel_73_o1 P1 WITH (NOLOCK) ON P73.ID = P1._BaseTableRegisterID
    INNER JOIN Panel_73_o3 P3 WITH (NOLOCK) ON P3._BaseTableRegisterID = P1._BaseTableRegisterID
    WHERE P.IdClaseProceso = 73
      AND P.IdEstado NOT IN (7,8)
      AND P73.[3_Tipo de trámite PSF] = 4728
      AND P3.[3_Tipo de trámite PSF Hab] = 12739
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 8, 73, N'Permiso Sanitario de Funcionamiento Modificación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_73 P73 WITH (NOLOCK) ON P73._ElementID = P.ID
    INNER JOIN Panel_73_o1 P1 WITH (NOLOCK) ON P73.ID = P1._BaseTableRegisterID
    INNER JOIN Panel_73_o3 P3 WITH (NOLOCK) ON P3._BaseTableRegisterID = P1._BaseTableRegisterID
    WHERE P.IdClaseProceso = 73
      AND P.IdEstado NOT IN (7,8)
      AND P73.[3_Tipo de trámite PSF] = 4727
      AND P3.[3_Tipo de trámite PSF Hab] = 12739
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 9, 73, N'Permiso Sanitario de Funcionamiento Cancelación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_73 P73 WITH (NOLOCK) ON P73._ElementID = P.ID
    INNER JOIN Panel_73_o1 P1 WITH (NOLOCK) ON P73.ID = P1._BaseTableRegisterID
    INNER JOIN Panel_73_o3 P3 WITH (NOLOCK) ON P3._BaseTableRegisterID = P1._BaseTableRegisterID
    WHERE P.IdClaseProceso = 73
      AND P.IdEstado NOT IN (7,8)
      AND P73.[3_Tipo de trámite PSF] = 4726
      AND P3.[3_Tipo de trámite PSF Hab] = 12739
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 10, 20, N'Permiso de Habilitación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_20 P20 WITH (NOLOCK) ON P20._ElementID = P.ID
    INNER JOIN Panel_20_o1 P1 WITH (NOLOCK) ON P20.ID = P1._BaseTableRegisterID
    INNER JOIN Panel_20_o4 P4 WITH (NOLOCK) ON P4._BaseTableRegisterID = P1._BaseTableRegisterID
    WHERE P.IdClaseProceso = 20
      AND P.IdEstado NOT IN (7,8)
      AND P4.[3_Tipo de trámite PSF Hab] = 12740
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 11, 73, N'Permiso de Habilitación Renovación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_73 P73 WITH (NOLOCK) ON P73._ElementID = P.ID
    INNER JOIN Panel_73_o1 P1 WITH (NOLOCK) ON P73.ID = P1._BaseTableRegisterID
    INNER JOIN Panel_73_o3 P3 WITH (NOLOCK) ON P3._BaseTableRegisterID = P1._BaseTableRegisterID
    WHERE P.IdClaseProceso = 73
      AND P.IdEstado NOT IN (7,8)
      AND P73.[3_Tipo de trámite PSF] = 4728
      AND P3.[3_Tipo de trámite PSF Hab] = 12740
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 12, 73, N'Permiso de Habilitación Modificación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_73 P73 WITH (NOLOCK) ON P73._ElementID = P.ID
    INNER JOIN Panel_73_o1 P1 WITH (NOLOCK) ON P73.ID = P1._BaseTableRegisterID
    INNER JOIN Panel_73_o3 P3 WITH (NOLOCK) ON P3._BaseTableRegisterID = P1._BaseTableRegisterID
    WHERE P.IdClaseProceso = 73
      AND P.IdEstado NOT IN (7,8)
      AND P73.[3_Tipo de trámite PSF] = 4727
      AND P3.[3_Tipo de trámite PSF Hab] = 12740
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 13, 73, N'Permiso de Habilitación Cancelación', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_73 P73 WITH (NOLOCK) ON P73._ElementID = P.ID
    INNER JOIN Panel_73_o1 P1 WITH (NOLOCK) ON P73.ID = P1._BaseTableRegisterID
    INNER JOIN Panel_73_o3 P3 WITH (NOLOCK) ON P3._BaseTableRegisterID = P1._BaseTableRegisterID
    WHERE P.IdClaseProceso = 73
      AND P.IdEstado NOT IN (7,8)
      AND P73.[3_Tipo de trámite PSF] = 4726
      AND P3.[3_Tipo de trámite PSF Hab] = 12740
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 14, 20, N'Registro de Gestor de Residuos', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_20 P20 WITH (NOLOCK) ON P20._ElementID = P.ID
    INNER JOIN Panel_20_o1 P1 WITH (NOLOCK) ON P20.ID = P1._BaseTableRegisterID
    INNER JOIN Panel_20_o2 P2 WITH (NOLOCK) ON P2._BaseTableRegisterID = P1._BaseTableRegisterID
    WHERE P.IdClaseProceso = 20
      AND P.IdEstado IN (0,1,2)
      AND P2.[3_TrámiteGestor] = 1
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 15, 119, N'Renovación del Registro de Gestor de Residuos',
    (
        SELECT COUNT(*)
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN Panel_73 P73 WITH (NOLOCK) ON P73._ElementID = P.ID
        INNER JOIN Panel_73_o1 P1 WITH (NOLOCK) ON P73.ID = P1._BaseTableRegisterID
        INNER JOIN Panel_73_o3 P3 WITH (NOLOCK) ON P3._BaseTableRegisterID = P1._BaseTableRegisterID
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
        INNER JOIN Panel_119 P119 WITH (NOLOCK) ON P119._ElementID = P.ID
        INNER JOIN Panel_119_o1 O1 WITH (NOLOCK) ON O1._BaseTableRegisterID = P119.ID
        INNER JOIN Panel_119_o2 O2 WITH (NOLOCK) ON O2._BaseTableRegisterID = P119.ID
        WHERE P.IdClaseProceso = 119
          AND P.IdEstado NOT IN (7,8)
          AND O1.[3_Tipo de trámite - Gestor de residuos] = 8925
          AND ISNULL(O2.[3_Renovación con PSF físico - GR],0) = 0
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))
    )

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 16, 119, N'Modificación al Registro de Gestor de Residuos', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_119 P119 WITH (NOLOCK) ON P119._ElementID = P.ID
    INNER JOIN Panel_119_o1 O1 WITH (NOLOCK) ON O1._BaseTableRegisterID = P119.ID
    INNER JOIN Panel_119_o2 O2 WITH (NOLOCK) ON O2._BaseTableRegisterID = P119.ID
    WHERE P.IdClaseProceso = 119
      AND P.IdEstado NOT IN (7,8)
      AND O1.[3_Tipo de trámite - Gestor de residuos] = 8924
      AND ISNULL(O2.[3_Modificación con PSF físico - GR],0) = 0
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 17, 119, N'Registro de Gestor de Residuos por primera vez con un PSF vigente en físico', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_119 P119 WITH (NOLOCK) ON P119._ElementID = P.ID
    INNER JOIN Panel_119_o1 O1 WITH (NOLOCK) ON O1._BaseTableRegisterID = P119.ID
    INNER JOIN Panel_119_o2 O2 WITH (NOLOCK) ON O2._BaseTableRegisterID = P119.ID
    WHERE P.IdClaseProceso = 119
      AND P.IdEstado NOT IN (7,8)
      AND O1.[3_Tipo de trámite - Gestor de residuos] = 13971
      AND O2.[3_Primera vez con PSF físico - GR] = 1
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 18, 119, N'Renovación del Registro de Gestor de Residuos con un PSF vigente en físico', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_119 P119 WITH (NOLOCK) ON P119._ElementID = P.ID
    INNER JOIN Panel_119_o1 O1 WITH (NOLOCK) ON O1._BaseTableRegisterID = P119.ID
    INNER JOIN Panel_119_o2 O2 WITH (NOLOCK) ON O2._BaseTableRegisterID = P119.ID
    WHERE P.IdClaseProceso = 119
      AND P.IdEstado NOT IN (7,8)
      AND O1.[3_Tipo de trámite - Gestor de residuos] = 8925
      AND O2.[3_Renovación con PSF físico - GR] = 1
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 19, 119, N'Modificación del Registro de Gestor de Residuos con un PSF vigente en físico', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_119 P119 WITH (NOLOCK) ON P119._ElementID = P.ID
    INNER JOIN Panel_119_o1 O1 WITH (NOLOCK) ON O1._BaseTableRegisterID = P119.ID
    INNER JOIN Panel_119_o2 O2 WITH (NOLOCK) ON O2._BaseTableRegisterID = P119.ID
    WHERE P.IdClaseProceso = 119
      AND P.IdEstado NOT IN (7,8)
      AND O1.[3_Tipo de trámite - Gestor de residuos] = 8924
      AND O2.[3_Modificación con PSF físico - GR] = 1
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

    UNION ALL
    SELECT N'Trámites Apertura de Empresa', 20, 119, N'Reporte de Gestión Integral de Residuos', COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_119 P119 WITH (NOLOCK) ON P119._ElementID = P.ID
    INNER JOIN Panel_119_o1 O1 WITH (NOLOCK) ON O1._BaseTableRegisterID = P119.ID
    WHERE P.IdClaseProceso = 119
      AND P.IdEstado NOT IN (7,8)
      AND O1.[3_Tipo de trámite - Gestor de residuos] = 8926
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin));

    ------------------------------------------------------------
    -- Bloque 3: Trámites Zonas Francas
    ------------------------------------------------------------
    INSERT INTO @Resultados
    SELECT N'Trámites Zonas Francas', 1, 2, N'Solicitud de Ingreso al Régimen de Zonas Francas', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_2 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 2
      AND P.IdEstado NOT IN (7, 8)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Zonas Francas', 2, 134, N'Solicitud de Ingreso al Régimen de Zonas Francas - 20 Bis', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_134 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 134
      AND P.IdEstado NOT IN (7, 8)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Zonas Francas', 3, 197, N'Solicitud de Estancias Categoría A: Empresas bajo el Régimen de Zona Franca', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_197 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 197
      AND P.IdEstado NOT IN (7, 8)
      AND T.[3_Tipo de trámite Migración] = 13166
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Zonas Francas', 4, 197, N'Solicitud de Ejecutivos Categoría A: Empresas bajo el Régimen de Zona Franca', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_197 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 197
      AND P.IdEstado NOT IN (7, 8)
      AND ISNULL(T.[3_Tipo de trámite Migración], 0) <> 13166
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin));

    ------------------------------------------------------------
    -- Bloque 4: Trámites Atracción de Inversión
    ------------------------------------------------------------
    INSERT INTO @Resultados
    SELECT
        N'Trámites Atracción de Inversión',
        1,
        161,
        N'Proyecto de Inversión Fílmica y Audiovisual',
        COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_161 T WITH (NOLOCK)
        ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 161
      AND P.IdEstado NOT IN (7, 8)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin));


    ------------------------------------------------------------
    -- Bloque 5: Trámites Ambientales
    ------------------------------------------------------------
    INSERT INTO @Resultados
    SELECT N'Trámites Ambientales', 1, 159, N'Permiso de vertido', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_159 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 159
      AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - TramAmb] = 11668
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 2, 159, N'Permiso de perforación de pozos', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_159 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 159
      AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - TramAmb] = 11669
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 3, 159, N'Concesión de aguas subterráneas', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_159 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 159
      AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - TramAmb] = 11670
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 4, 159, N'Concesión de aguas superficiales', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_159 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 159
      AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - TramAmb] = 11671
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 5, 172, N'Presentación de Proyecto para Estaciones de Servicio', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_172 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 172
      AND P.IdEstado NOT IN (7,8)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 6, 186, N'D1', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - SETENA] = 12636
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 7, 186, N'D1 - Torres', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - SETENA] = 12637
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 8, 186, N'D1 - C', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - SETENA] = 12638
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 9, 186, N'D1 - Desalinización con Declaración Jurada', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - SETENA] = 12639
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 10, 186, N'D1 - Desalinización con Pronóstico-Plan de Gestión Ambiental', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - SETENA] = 12640
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 11, 186, N'D1 - Desalinización con Estudio de Impacto Ambiental', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - SETENA] = 12641
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 12, 186, N'D4 - Forestal', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - SETENA] = 12642
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 13, 186, N'D6 - Cuadrante Urbano', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - SETENA] = 12643
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 14, 186, N'EDA - Estudio de Diagnóstico Ambiental', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - SETENA] = 12644
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 15, 186, N'SDA - Solicitud Devolución Garantía con Resolución de Archivo de Expediente', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - SETENA] = 12645
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 16, 186, N'SDC - Solicitud de Devolución Garantía Cierre Técnico', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - SETENA] = 12646
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 17, 186, N'RGA - Solicitud de Renovación de Garantía Ambiental', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - SETENA] = 12647
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 18, 186, N'CRG - Presentación Comprobante Renovación Garantía', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - SETENA] = 12648
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Ambientales', 19, 186, N'DDE - Devolución de Depósitos Erróneos', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
      AND T.[3_Tipo de trámite - SETENA] = 12649
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin));

    ------------------------------------------------------------
    -- Bloque 6: Trámites Institucionales
    ------------------------------------------------------------
    INSERT INTO @Resultados
    SELECT N'Trámites Institucionales', 1, 74, N'Emisión de Criterios Técnicos sobre Humedales', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_74 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 74
      AND P.IdEstado NOT IN (7, 8)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Institucionales', 2, 167, N'Firmas Declaraciones Juradas', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_167 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 167
      AND P.IdEstado NOT IN (7, 8)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Institucionales', 3, 77, N'Gestión de Aprobaciones', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_77 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 77
      AND P.IdEstado NOT IN (7, 8)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Institucionales', 4, 177, N'Inspecciones AFPA', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_177 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 177
      AND P.IdEstado NOT IN (7, 8)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Institucionales', 5, 173, N'Planes Reguladores', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_173 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 173
      AND P.IdEstado NOT IN (7, 8)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin));

    ------------------------------------------------------------
    -- Bloque 7: Trámites Registros
    ------------------------------------------------------------
    INSERT INTO @Resultados
    SELECT N'Trámites Registros', 1, 106, N'Registro IAGT (Data Completa)', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_106 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 106
      AND P.IdEstado NOT IN (7, 8)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Registros', 2, 199, N'Licencias de Cannabis para uso medicinal y terapéutico', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_199 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 199
      AND P.IdEstado NOT IN (7, 8)
      AND UPPER(LTRIM(RTRIM(ISNULL(T.[3_Tipo de trámite MINSA-MAG], '')))) = 'CANNABIS'
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Registros', 3, 199, N'Autorizaciones de Cáñamo para uso alimentario e industrial', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_199 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 199
      AND P.IdEstado NOT IN (7, 8)
      AND UPPER(LTRIM(RTRIM(ISNULL(T.[3_Tipo de trámite MINSA-MAG], '')))) = 'CANAMO'
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Registros', 4, 208, N'Fichas de Emergencia para el Transporte Terrestre de Mercancías Peligrosas', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_208 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 208
      AND P.IdEstado NOT IN (7, 8)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin));

    ------------------------------------------------------------
    -- Bloque 8: Trámites Construcción
    ------------------------------------------------------------
    INSERT INTO @Resultados
    SELECT N'Trámites Construcción', 1, 226, N'APC - ADMINISTRADOR DE PROYECTOS DE CONSTRUCCIÓN', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_226 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 226
      AND P.IdEstado NOT IN (7, 8)
      AND T.[3_Tipo de trámite - CFIA] = 14798
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Construcción', 2, 226, N'APC-M - ADMINISTRADOR DE PROYECTOS DE CONSTRUCCIÓN – MUNICIPAL', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_226 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 226
      AND P.IdEstado NOT IN (7, 8)
      AND T.[3_Tipo de trámite - CFIA] = 14799
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Construcción', 3, 226, N'APC-R - ADMINISTRADOR DE PROYECTOS DE CONSTRUCCIÓN – REQUISITOS', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_226 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 226
      AND P.IdEstado NOT IN (7, 8)
      AND T.[3_Tipo de trámite - CFIA] = 14800
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL
    SELECT N'Trámites Construcción', 4, 226, N'APT - ADMINISTRADOR DE PROYECTOS DE TOPOGRAFÍA', COUNT(*)
    FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN dbo.Panel_226 T WITH (NOLOCK) ON T._ElementID = P.ID
    WHERE P.IdClaseProceso = 226
      AND P.IdEstado NOT IN (7, 8)
      AND T.[3_Tipo de trámite - CFIA] = 14801
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin));

    ------------------------------------------------------------
    -- Resultado final
    ------------------------------------------------------------
    SELECT
        Bloque,
        Orden,
        IdClaseProceso,
        NombreTramite,
        Cantidad
    FROM @Resultados
    WHERE @Bloque IS NULL
       OR @Bloque = N''
       OR @Bloque IN (N'Todos', N'Todas')
       OR Bloque = @Bloque
    ORDER BY
        CASE Bloque
            WHEN N'Trámites previos a Apertura de Empresa' THEN 1
            WHEN N'Trámites Apertura de Empresa' THEN 2
            WHEN N'Trámites Zonas Francas' THEN 3
            WHEN N'Trámites Atracción de Inversión' THEN 4
            WHEN N'Trámites Ambientales' THEN 5
            WHEN N'Trámites Institucionales' THEN 6
            WHEN N'Trámites Registros' THEN 7
            WHEN N'Trámites Construcción' THEN 8
            ELSE 99
        END,
        Orden;
END;
GO
