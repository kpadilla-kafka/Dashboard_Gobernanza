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
      Dashboard Gobernanza
      Proyecto: PROCOMER

      Descripción:
      Devuelve la información consolidada del Dashboard de
      Gobernanza según rango de fechas y bloque seleccionado.

      Nota:
      Por ahora solo implementa:
      - Trámites previos a Apertura de Empresa
    ************************************************************/

    ------------------------------------------------------------
    -- Tabla de resultados
    ------------------------------------------------------------
    DECLARE @Resultados TABLE
    (
        Bloque NVARCHAR(150),
        Orden INT,
        IdClaseProceso INT,
        NombreTramite NVARCHAR(250),
        Cantidad INT
    );

    ------------------------------------------------------------
    -- Bloque 1: Trámites previos a Apertura de Empresa
    ------------------------------------------------------------
    INSERT INTO @Resultados
    SELECT
        N'Trámites previos a Apertura de Empresa' AS Bloque,
        1 AS Orden,
        45 AS IdClaseProceso,
        N'Calderas (Versión 1)' AS NombreTramite,
        COUNT(P.ID) AS Cantidad
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    WHERE P.IdClaseProceso = 45
      AND P.IdEstado IN (0,1,2)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL

    SELECT
        N'Trámites previos a Apertura de Empresa',
        2,
        154,
        N'Calderas Operación',
        COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_154 P154 WITH (NOLOCK)
        ON P154._ElementID = P.ID
    WHERE P.IdClaseProceso = 154
      AND P.IdEstado IN (0,1,2)
      AND P154.[3_Selección de trámite caldera] = 2216
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL

    SELECT
        N'Trámites previos a Apertura de Empresa',
        3,
        154,
        N'Calderas Instalación',
        COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_154 P154 WITH (NOLOCK)
        ON P154._ElementID = P.ID
    WHERE P.IdClaseProceso = 154
      AND P.IdEstado IN (0,1,2)
      AND P154.[3_Selección de trámite caldera] = 2215
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL

    SELECT
        N'Trámites previos a Apertura de Empresa',
        4,
        152,
        N'Calderas Inspección Anual',
        COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_152 P152 WITH (NOLOCK)
        ON P152._ElementID = P.ID
    WHERE P.IdClaseProceso = 152
      AND P.IdEstado IN (0,1,2)
      AND P152.[3_Tipo de trámite - Módulos calderas] = 11513
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL

    SELECT
        N'Trámites previos a Apertura de Empresa',
        5,
        152,
        N'Calderas Renovación',
        COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_152 P152 WITH (NOLOCK)
        ON P152._ElementID = P.ID
    WHERE P.IdClaseProceso = 152
      AND P.IdEstado IN (0,1,2)
      AND P152.[3_Tipo de trámite - Módulos calderas] = 11510
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL

    SELECT
        N'Trámites previos a Apertura de Empresa',
        6,
        152,
        N'Calderas Modificación',
        COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_152 P152 WITH (NOLOCK)
        ON P152._ElementID = P.ID
    WHERE P.IdClaseProceso = 152
      AND P.IdEstado IN (0,1,2)
      AND P152.[3_Tipo de trámite - Módulos calderas] = 12311
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL

    SELECT
        N'Trámites previos a Apertura de Empresa',
        7,
        152,
        N'Calderas Cancelación',
        COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_152 P152 WITH (NOLOCK)
        ON P152._ElementID = P.ID
    WHERE P.IdClaseProceso = 152
      AND P.IdEstado IN (0,1,2)
      AND P152.[3_Tipo de trámite - Módulos calderas] = 11512
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL

    SELECT
        N'Trámites previos a Apertura de Empresa',
        8,
        38,
        N'Sistema de Tratamiento de Aguas Residuales',
        COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    WHERE P.IdClaseProceso = 38
      AND P.IdEstado IN (0,1,2)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL

    SELECT
        N'Trámites previos a Apertura de Empresa',
        9,
        176,
        N'Sistema de Tratamiento de Aguas Residuales Renovación',
        COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_176 P176 WITH (NOLOCK)
        ON P176._ElementID = P.ID
    WHERE P.IdClaseProceso = 176
      AND P.IdEstado IN (0,1,2)
      AND P176.[3_Tipo de trámite STAR] = 12126
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL

    SELECT
        N'Trámites previos a Apertura de Empresa',
        10,
        176,
        N'Sistema de Tratamiento de Aguas Residuales Modificación',
        COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_176 P176 WITH (NOLOCK)
        ON P176._ElementID = P.ID
    WHERE P.IdClaseProceso = 176
      AND P.IdEstado IN (0,1,2)
      AND P176.[3_Tipo de trámite STAR] = 12125
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL

    SELECT
        N'Trámites previos a Apertura de Empresa',
        11,
        44,
        N'Tanques de Autoconsumo',
        COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    WHERE P.IdClaseProceso = 44
      AND P.IdEstado IN (0,1,2)
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL

    SELECT
        N'Trámites previos a Apertura de Empresa',
        12,
        192,
        N'Tanques de Autoconsumo Renovación',
        COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_192 P192 WITH (NOLOCK)
        ON P192._ElementID = P.ID
    WHERE P.IdClaseProceso = 192
      AND P.IdEstado IN (0,1,2)
      AND P192.[3_Tipo de trámite Tanques] = 12788
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL

    SELECT
        N'Trámites previos a Apertura de Empresa',
        13,
        192,
        N'Tanques de Autoconsumo Modificación',
        COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_192 P192 WITH (NOLOCK)
        ON P192._ElementID = P.ID
    WHERE P.IdClaseProceso = 192
      AND P.IdEstado IN (0,1,2)
      AND P192.[3_Tipo de trámite Tanques] = 12787
      AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
      AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

    UNION ALL

    SELECT
        N'Trámites previos a Apertura de Empresa',
        14,
        192,
        N'Tanques de Autoconsumo Cancelación',
        COUNT(P.ID)
    FROM AP__BPM_Procesos P WITH (NOLOCK)
    INNER JOIN Panel_192 P192 WITH (NOLOCK)
        ON P192._ElementID = P.ID
    WHERE P.IdClaseProceso = 192
      AND P.IdEstado IN (0,1,2)
      AND P192.[3_Tipo de trámite Tanques] = 12789
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
    ORDER BY Orden;
END;
GO
