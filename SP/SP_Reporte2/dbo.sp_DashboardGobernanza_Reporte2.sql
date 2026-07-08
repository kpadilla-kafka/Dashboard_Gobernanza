/*===============================================================================
  Procedimiento: dbo.sp_DashboardGobernanza_Reporte2
  Descripción  : Reporte 2 - Dashboard Gobernanza.
                 Distribuye la cantidad de trámites por mes (ENE-DIC) y total,
                 manteniendo la misma lógica de conteo del Reporte 1.

  Parámetros:
    @FechaInicio : Fecha inicial opcional.
    @FechaFin    : Fecha final opcional. Se contempla todo el día usando DATEADD.
    @Bloque      : Bloque a consultar. Acepta 'Todos' o múltiples bloques separados por '|'.

  Nota:
    - @Catalogo garantiza que aparezcan trámites con cantidad 0.
    - @Datos almacena las fechas reales para agrupar por mes.

  Creado por Kpadilla el 08/07/2026
===============================================================================*/

CREATE OR ALTER PROCEDURE dbo.sp_DashboardGobernanza_Reporte2
(
    @FechaInicio DATETIME = NULL,
    @FechaFin    DATETIME = NULL,
    @Bloque      NVARCHAR(MAX) = N'Todos'
)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Catalogo TABLE
    (
        OrdenBloque INT,
        Bloque NVARCHAR(150),
        Orden INT,
        IdClaseProceso INT,
        NombreTramite NVARCHAR(500)
    );

    INSERT INTO @Catalogo
    (
        OrdenBloque,
        Bloque,
        Orden,
        IdClaseProceso,
        NombreTramite
    )
    VALUES
    (1, N'Trámites previos a Apertura de Empresa', 1, 45, N'Calderas (Versión 1)'),
    (1, N'Trámites previos a Apertura de Empresa', 2, 154, N'Calderas Operación'),
    (1, N'Trámites previos a Apertura de Empresa', 3, 154, N'Calderas Instalación'),
    (1, N'Trámites previos a Apertura de Empresa', 4, 152, N'Calderas Inspección Anual'),
    (1, N'Trámites previos a Apertura de Empresa', 5, 152, N'Calderas Renovación'),
    (1, N'Trámites previos a Apertura de Empresa', 6, 152, N'Calderas Modificación'),
    (1, N'Trámites previos a Apertura de Empresa', 7, 152, N'Calderas Cancelación'),
    (1, N'Trámites previos a Apertura de Empresa', 8, 38, N'Sistema de Tratamiento de Aguas Residuales'),
    (1, N'Trámites previos a Apertura de Empresa', 9, 176, N'Sistema de Tratamiento de Aguas Residuales Renovación'),
    (1, N'Trámites previos a Apertura de Empresa', 10, 176, N'Sistema de Tratamiento de Aguas Residuales Modificación'),
    (1, N'Trámites previos a Apertura de Empresa', 11, 44, N'Tanques de Autoconsumo'),
    (1, N'Trámites previos a Apertura de Empresa', 12, 192, N'Tanques de Autoconsumo Renovación'),
    (1, N'Trámites previos a Apertura de Empresa', 13, 192, N'Tanques de Autoconsumo Modificación'),
    (1, N'Trámites previos a Apertura de Empresa', 14, 192, N'Tanques de Autoconsumo Cancelación'),
    (2, N'Trámites Apertura de Empresa', 1, 21, N'Certificado Veterinario de Operación (CVO)'),
    (2, N'Trámites Apertura de Empresa', 2, 36, N'Patente Comercial'),
    (2, N'Trámites Apertura de Empresa', 3, 36, N'Patente Comercial Cambio de Ubicación'),
    (2, N'Trámites Apertura de Empresa', 4, 36, N'Patente Comercial Cambio de Actividad'),
    (2, N'Trámites Apertura de Empresa', 5, 36, N'Licencia de Licores'),
    (2, N'Trámites Apertura de Empresa', 6, 20, N'Permiso Sanitario de Funcionamiento'),
    (2, N'Trámites Apertura de Empresa', 7, 73, N'Permiso Sanitario de Funcionamiento Renovación'),
    (2, N'Trámites Apertura de Empresa', 8, 73, N'Permiso Sanitario de Funcionamiento Modificación'),
    (2, N'Trámites Apertura de Empresa', 9, 73, N'Permiso Sanitario de Funcionamiento Cancelación'),
    (2, N'Trámites Apertura de Empresa', 10, 20, N'Permiso de Habilitación'),
    (2, N'Trámites Apertura de Empresa', 11, 73, N'Permiso de Habilitación Renovación'),
    (2, N'Trámites Apertura de Empresa', 12, 73, N'Permiso de Habilitación Modificación'),
    (2, N'Trámites Apertura de Empresa', 13, 73, N'Permiso de Habilitación Cancelación'),
    (2, N'Trámites Apertura de Empresa', 14, 20, N'Registro de Gestor de Residuos'),
    (2, N'Trámites Apertura de Empresa', 15, 119, N'Renovación del Registro de Gestor de Residuos'),
    (2, N'Trámites Apertura de Empresa', 16, 119, N'Modificación al Registro de Gestor de Residuos'),
    (2, N'Trámites Apertura de Empresa', 17, 119, N'Registro de Gestor de Residuos por primera vez con un PSF vigente en físico'),
    (2, N'Trámites Apertura de Empresa', 18, 119, N'Renovación del Registro de Gestor de Residuos con un PSF vigente en físico'),
    (2, N'Trámites Apertura de Empresa', 19, 119, N'Modificación del Registro de Gestor de Residuos con un PSF vigente en físico'),
    (2, N'Trámites Apertura de Empresa', 20, 119, N'Reporte de Gestión Integral de Residuos'),
    (3, N'Trámites Zonas Francas', 1, 2, N'Solicitud de Ingreso al Régimen de Zonas Francas'),
    (3, N'Trámites Zonas Francas', 2, 134, N'Solicitud de Ingreso al Régimen de Zonas Francas - 20 Bis'),
    (3, N'Trámites Zonas Francas', 3, 197, N'Solicitud de Estancias Categoría A: Empresas bajo el Régimen de Zona Franca'),
    (3, N'Trámites Zonas Francas', 4, 197, N'Solicitud de Ejecutivos Categoría A: Empresas bajo el Régimen de Zona Franca'),
    (4, N'Trámites Atracción de Inversión', 1, 161, N'Proyecto de Inversión Fílmica y Audiovisual'),
    (5, N'Trámites Ambientales', 1, 159, N'Permiso de vertido'),
    (5, N'Trámites Ambientales', 2, 159, N'Permiso de perforación de pozos'),
    (5, N'Trámites Ambientales', 3, 159, N'Concesión de aguas subterráneas'),
    (5, N'Trámites Ambientales', 4, 159, N'Concesión de aguas superficiales'),
    (5, N'Trámites Ambientales', 5, 172, N'Presentación de Proyecto para Estaciones de Servicio'),
    (5, N'Trámites Ambientales', 6, 186, N'D1'),
    (5, N'Trámites Ambientales', 7, 186, N'D1 - Torres'),
    (5, N'Trámites Ambientales', 8, 186, N'D1 - C'),
    (5, N'Trámites Ambientales', 9, 186, N'D1 - Desalinización con Declaración Jurada'),
    (5, N'Trámites Ambientales', 10, 186, N'D1 - Desalinización con Pronóstico-Plan de Gestión Ambiental'),
    (5, N'Trámites Ambientales', 11, 186, N'D1 - Desalinización con Estudio de Impacto Ambiental'),
    (5, N'Trámites Ambientales', 12, 186, N'D4 - Forestal'),
    (5, N'Trámites Ambientales', 13, 186, N'D6 - Cuadrante Urbano'),
    (5, N'Trámites Ambientales', 14, 186, N'EDA - Estudio de Diagnóstico Ambiental'),
    (5, N'Trámites Ambientales', 15, 186, N'SDA - Solicitud Devolución Garantía con Resolución de Archivo de Expediente'),
    (5, N'Trámites Ambientales', 16, 186, N'SDC - Solicitud de Devolución Garantía Cierre Técnico'),
    (5, N'Trámites Ambientales', 17, 186, N'RGA - Solicitud de Renovación de Garantía Ambiental'),
    (5, N'Trámites Ambientales', 18, 186, N'CRG - Presentación Comprobante Renovación Garantía'),
    (5, N'Trámites Ambientales', 19, 186, N'DDE - Devolución de Depósitos Erróneos'),
    (6, N'Trámites Institucionales', 1, 74, N'Emisión de Criterios Técnicos sobre Humedales'),
    (6, N'Trámites Institucionales', 2, 167, N'Firmas Declaraciones Juradas'),
    (6, N'Trámites Institucionales', 3, 77, N'Gestión de Aprobaciones'),
    (6, N'Trámites Institucionales', 4, 177, N'Inspecciones AFPA'),
    (6, N'Trámites Institucionales', 5, 173, N'Planes Reguladores'),
    (7, N'Trámites Registros', 1, 106, N'Registro IAGT (Data Completa)'),
    (7, N'Trámites Registros', 2, 199, N'Licencias de Cannabis para uso medicinal y terapéutico'),
    (7, N'Trámites Registros', 3, 199, N'Autorizaciones de Cáñamo para uso alimentario e industrial'),
    (7, N'Trámites Registros', 4, 208, N'Fichas de Emergencia para el Transporte Terrestre de Mercancías Peligrosas'),
    (8, N'Trámites Construcción', 1, 226, N'APC - Administrador de Proyectos de Construcción'),
    (8, N'Trámites Construcción', 2, 226, N'APC-M - Administrador de Proyectos de Construcción – Municipal'),
    (8, N'Trámites Construcción', 3, 226, N'APC-R - Administrador de Proyectos de Construcción – Requisitos'),
    (8, N'Trámites Construcción', 4, 226, N'APT - Administrador de Proyectos de Topografía');

    DECLARE @Datos TABLE
    (
        OrdenBloque INT,
        Bloque NVARCHAR(150),
        Orden INT,
        IdClaseProceso INT,
        NombreTramite NVARCHAR(500),
        FechaInicio DATETIME
    );

        ------------------------------------------------------------
        -- Bloque 1: Trámites previos a Apertura de Empresa
        ------------------------------------------------------------
        INSERT INTO @Datos
        SELECT 1, N'Trámites previos a Apertura de Empresa', 1, 45, N'Calderas (Versión 1)', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        WHERE P.IdClaseProceso = 45
          AND P.IdEstado IN (0,1,2)
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 1, N'Trámites previos a Apertura de Empresa', 2, 154, N'Calderas Operación', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN Panel_154 P154 WITH (NOLOCK) ON P154._ElementID = P.ID
        WHERE P.IdClaseProceso = 154
          AND P.IdEstado IN (0,1,2)
          AND P154.[3_Selección de trámite caldera] = 2216
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 1, N'Trámites previos a Apertura de Empresa', 3, 154, N'Calderas Instalación', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN Panel_154 P154 WITH (NOLOCK) ON P154._ElementID = P.ID
        WHERE P.IdClaseProceso = 154
          AND P.IdEstado IN (0,1,2)
          AND P154.[3_Selección de trámite caldera] = 2215
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 1, N'Trámites previos a Apertura de Empresa', 4, 152, N'Calderas Inspección Anual', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN Panel_152 P152 WITH (NOLOCK) ON P152._ElementID = P.ID
        WHERE P.IdClaseProceso = 152
          AND P.IdEstado IN (0,1,2)
          AND P152.[3_Tipo de trámite - Módulos calderas] = 11513
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 1, N'Trámites previos a Apertura de Empresa', 5, 152, N'Calderas Renovación', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN Panel_152 P152 WITH (NOLOCK) ON P152._ElementID = P.ID
        WHERE P.IdClaseProceso = 152
          AND P.IdEstado IN (0,1,2)
          AND P152.[3_Tipo de trámite - Módulos calderas] = 11510
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 1, N'Trámites previos a Apertura de Empresa', 6, 152, N'Calderas Modificación', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN Panel_152 P152 WITH (NOLOCK) ON P152._ElementID = P.ID
        WHERE P.IdClaseProceso = 152
          AND P.IdEstado IN (0,1,2)
          AND P152.[3_Tipo de trámite - Módulos calderas] = 12311
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 1, N'Trámites previos a Apertura de Empresa', 7, 152, N'Calderas Cancelación', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN Panel_152 P152 WITH (NOLOCK) ON P152._ElementID = P.ID
        WHERE P.IdClaseProceso = 152
          AND P.IdEstado IN (0,1,2)
          AND P152.[3_Tipo de trámite - Módulos calderas] = 11512
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 1, N'Trámites previos a Apertura de Empresa', 8, 38, N'Sistema de Tratamiento de Aguas Residuales', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        WHERE P.IdClaseProceso = 38
          AND P.IdEstado IN (0,1,2)
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 1, N'Trámites previos a Apertura de Empresa', 9, 176, N'Sistema de Tratamiento de Aguas Residuales Renovación', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN Panel_176 P176 WITH (NOLOCK) ON P176._ElementID = P.ID
        WHERE P.IdClaseProceso = 176
          AND P.IdEstado IN (0,1,2)
          AND P176.[3_Tipo de trámite STAR] = 12126
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 1, N'Trámites previos a Apertura de Empresa', 10, 176, N'Sistema de Tratamiento de Aguas Residuales Modificación', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN Panel_176 P176 WITH (NOLOCK) ON P176._ElementID = P.ID
        WHERE P.IdClaseProceso = 176
          AND P.IdEstado IN (0,1,2)
          AND P176.[3_Tipo de trámite STAR] = 12125
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 1, N'Trámites previos a Apertura de Empresa', 11, 44, N'Tanques de Autoconsumo', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        WHERE P.IdClaseProceso = 44
          AND P.IdEstado IN (0,1,2)
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 1, N'Trámites previos a Apertura de Empresa', 12, 192, N'Tanques de Autoconsumo Renovación', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN Panel_192 P192 WITH (NOLOCK) ON P192._ElementID = P.ID
        WHERE P.IdClaseProceso = 192
          AND P.IdEstado IN (0,1,2)
          AND P192.[3_Tipo de trámite Tanques] = 12788
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 1, N'Trámites previos a Apertura de Empresa', 13, 192, N'Tanques de Autoconsumo Modificación', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN Panel_192 P192 WITH (NOLOCK) ON P192._ElementID = P.ID
        WHERE P.IdClaseProceso = 192
          AND P.IdEstado IN (0,1,2)
          AND P192.[3_Tipo de trámite Tanques] = 12787
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 1, N'Trámites previos a Apertura de Empresa', 14, 192, N'Tanques de Autoconsumo Cancelación', P.FechaInicio
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
        INSERT INTO @Datos
        SELECT 2, N'Trámites Apertura de Empresa', 1, 21, N'Certificado Veterinario de Operación (CVO)', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        WHERE P.IdClaseProceso = 21
          AND P.IdEstado IN (0,1,2)
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

        UNION ALL
        SELECT 2, N'Trámites Apertura de Empresa', 2, 36, N'Patente Comercial', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN Panel_36 P36 WITH (NOLOCK) ON P36._ElementID = P.ID
        WHERE P.IdClaseProceso = 36
          AND P.IdEstado IN (0,1,2)
          AND P36.[3_Tipo de trámite] = 2054
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

        UNION ALL
        SELECT 2, N'Trámites Apertura de Empresa', 3, 36, N'Patente Comercial Cambio de Ubicación', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN Panel_36 P36 WITH (NOLOCK) ON P36._ElementID = P.ID
        WHERE P.IdClaseProceso = 36
          AND P.IdEstado IN (0,1,2)
          AND P36.[3_Tipo de trámite] = 2059
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

        UNION ALL
        SELECT 2, N'Trámites Apertura de Empresa', 4, 36, N'Patente Comercial Cambio de Actividad', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN Panel_36 P36 WITH (NOLOCK) ON P36._ElementID = P.ID
        WHERE P.IdClaseProceso = 36
          AND P.IdEstado IN (0,1,2)
          AND P36.[3_Tipo de trámite] = 2057
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

        UNION ALL
        SELECT 2, N'Trámites Apertura de Empresa', 5, 36, N'Licencia de Licores', P.FechaInicio
        FROM AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN Panel_36 P36 WITH (NOLOCK) ON P36._ElementID = P.ID
        WHERE P.IdClaseProceso = 36
          AND P.IdEstado IN (0,1,2)
          AND P36.[3_Tipo de trámite] = 2055
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY,1,@FechaFin))

        UNION ALL
        SELECT 2, N'Trámites Apertura de Empresa', 6, 20, N'Permiso Sanitario de Funcionamiento', P.FechaInicio
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
        SELECT 2, N'Trámites Apertura de Empresa', 7, 73, N'Permiso Sanitario de Funcionamiento Renovación', P.FechaInicio
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
        SELECT 2, N'Trámites Apertura de Empresa', 8, 73, N'Permiso Sanitario de Funcionamiento Modificación', P.FechaInicio
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
        SELECT 2, N'Trámites Apertura de Empresa', 9, 73, N'Permiso Sanitario de Funcionamiento Cancelación', P.FechaInicio
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
        SELECT 2, N'Trámites Apertura de Empresa', 10, 20, N'Permiso de Habilitación', P.FechaInicio
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
        SELECT 2, N'Trámites Apertura de Empresa', 11, 73, N'Permiso de Habilitación Renovación', P.FechaInicio
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
        SELECT 2, N'Trámites Apertura de Empresa', 12, 73, N'Permiso de Habilitación Modificación', P.FechaInicio
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
        SELECT 2, N'Trámites Apertura de Empresa', 13, 73, N'Permiso de Habilitación Cancelación', P.FechaInicio
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
        SELECT 2, N'Trámites Apertura de Empresa', 14, 20, N'Registro de Gestor de Residuos', P.FechaInicio
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
        SELECT 2, N'Trámites Apertura de Empresa', 15, 119, N'Renovación del Registro de Gestor de Residuos', P.FechaInicio
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

        UNION ALL
        SELECT 2, N'Trámites Apertura de Empresa', 15, 119, N'Renovación del Registro de Gestor de Residuos', P.FechaInicio
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

        UNION ALL
        SELECT 2, N'Trámites Apertura de Empresa', 16, 119, N'Modificación al Registro de Gestor de Residuos', P.FechaInicio
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
        SELECT 2, N'Trámites Apertura de Empresa', 17, 119, N'Registro de Gestor de Residuos por primera vez con un PSF vigente en físico', P.FechaInicio
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
        SELECT 2, N'Trámites Apertura de Empresa', 18, 119, N'Renovación del Registro de Gestor de Residuos con un PSF vigente en físico', P.FechaInicio
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
        SELECT 2, N'Trámites Apertura de Empresa', 19, 119, N'Modificación del Registro de Gestor de Residuos con un PSF vigente en físico', P.FechaInicio
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
        SELECT 2, N'Trámites Apertura de Empresa', 20, 119, N'Reporte de Gestión Integral de Residuos', P.FechaInicio
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
        INSERT INTO @Datos
        SELECT 3, N'Trámites Zonas Francas', 1, 2, N'Solicitud de Ingreso al Régimen de Zonas Francas', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_2 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 2
          AND P.IdEstado NOT IN (7, 8)
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 3, N'Trámites Zonas Francas', 2, 134, N'Solicitud de Ingreso al Régimen de Zonas Francas - 20 Bis', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_134 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 134
          AND P.IdEstado NOT IN (7, 8)
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 3, N'Trámites Zonas Francas', 3, 197, N'Solicitud de Estancias Categoría A: Empresas bajo el Régimen de Zona Franca', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_197 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 197
          AND P.IdEstado NOT IN (7, 8)
          AND T.[3_Tipo de trámite Migración] = 13166
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 3, N'Trámites Zonas Francas', 4, 197, N'Solicitud de Ejecutivos Categoría A: Empresas bajo el Régimen de Zona Franca', P.FechaInicio
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
        INSERT INTO @Datos
        SELECT
            4,
            N'Trámites Atracción de Inversión',
            1,
            161,
            N'Proyecto de Inversión Fílmica y Audiovisual',
            P.FechaInicio
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
        INSERT INTO @Datos
        SELECT 5, N'Trámites Ambientales', 1, 159, N'Permiso de vertido', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_159 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 159
          AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - TramAmb] = 11668
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 2, 159, N'Permiso de perforación de pozos', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_159 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 159
          AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - TramAmb] = 11669
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 3, 159, N'Concesión de aguas subterráneas', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_159 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 159
          AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - TramAmb] = 11670
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 4, 159, N'Concesión de aguas superficiales', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_159 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 159
          AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - TramAmb] = 11671
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 5, 172, N'Presentación de Proyecto para Estaciones de Servicio', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_172 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 172
          AND P.IdEstado NOT IN (7,8)
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 6, 186, N'D1', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - SETENA] = 12636
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 7, 186, N'D1 - Torres', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - SETENA] = 12637
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 8, 186, N'D1 - C', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - SETENA] = 12638
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 9, 186, N'D1 - Desalinización con Declaración Jurada', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - SETENA] = 12639
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 10, 186, N'D1 - Desalinización con Pronóstico-Plan de Gestión Ambiental', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - SETENA] = 12640
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 11, 186, N'D1 - Desalinización con Estudio de Impacto Ambiental', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - SETENA] = 12641
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 12, 186, N'D4 - Forestal', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - SETENA] = 12642
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 13, 186, N'D6 - Cuadrante Urbano', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - SETENA] = 12643
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 14, 186, N'EDA - Estudio de Diagnóstico Ambiental', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - SETENA] = 12644
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 15, 186, N'SDA - Solicitud Devolución Garantía con Resolución de Archivo de Expediente', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - SETENA] = 12645
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 16, 186, N'SDC - Solicitud de Devolución Garantía Cierre Técnico', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - SETENA] = 12646
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 17, 186, N'RGA - Solicitud de Renovación de Garantía Ambiental', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - SETENA] = 12647
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 18, 186, N'CRG - Presentación Comprobante Renovación Garantía', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - SETENA] = 12648
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 5, N'Trámites Ambientales', 19, 186, N'DDE - Devolución de Depósitos Erróneos', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_186 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 186 AND P.IdEstado NOT IN (7,8)
          AND T.[3_Tipo de trámite - SETENA] = 12649
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin));

        ------------------------------------------------------------
        -- Bloque 6: Trámites Institucionales
        ------------------------------------------------------------
        INSERT INTO @Datos
        SELECT 6, N'Trámites Institucionales', 1, 74, N'Emisión de Criterios Técnicos sobre Humedales', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_74 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 74
          AND P.IdEstado NOT IN (7, 8)
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 6, N'Trámites Institucionales', 2, 167, N'Firmas Declaraciones Juradas', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_167 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 167
          AND P.IdEstado NOT IN (7, 8)
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 6, N'Trámites Institucionales', 3, 77, N'Gestión de Aprobaciones', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_77 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 77
          AND P.IdEstado NOT IN (7, 8)
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 6, N'Trámites Institucionales', 4, 177, N'Inspecciones AFPA', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_177 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 177
          AND P.IdEstado NOT IN (7, 8)
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 6, N'Trámites Institucionales', 5, 173, N'Planes Reguladores', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_173 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 173
          AND P.IdEstado NOT IN (7, 8)
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin));

        ------------------------------------------------------------
        -- Bloque 7: Trámites Registros
        ------------------------------------------------------------
        INSERT INTO @Datos
        SELECT 7, N'Trámites Registros', 1, 106, N'Registro IAGT (Data Completa)', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_106 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 106
          AND P.IdEstado NOT IN (7, 8)
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 7, N'Trámites Registros', 2, 199, N'Licencias de Cannabis para uso medicinal y terapéutico', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_199 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 199
          AND P.IdEstado NOT IN (7, 8)
          AND UPPER(LTRIM(RTRIM(ISNULL(T.[3_Tipo de trámite MINSA-MAG], '')))) = 'CANNABIS'
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 7, N'Trámites Registros', 3, 199, N'Autorizaciones de Cáñamo para uso alimentario e industrial', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_199 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 199
          AND P.IdEstado NOT IN (7, 8)
          AND UPPER(LTRIM(RTRIM(ISNULL(T.[3_Tipo de trámite MINSA-MAG], '')))) = 'CANAMO'
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 7, N'Trámites Registros', 4, 208, N'Fichas de Emergencia para el Transporte Terrestre de Mercancías Peligrosas', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_208 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 208
          AND P.IdEstado NOT IN (7, 8)
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin));

        ------------------------------------------------------------
        -- Bloque 8: Trámites Construcción
        ------------------------------------------------------------
        INSERT INTO @Datos
        SELECT 8, N'Trámites Construcción', 1, 226, N'APC - Administrador de Proyectos de Construcción', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_226 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 226
          AND P.IdEstado NOT IN (7, 8)
          AND T.[3_Tipo de trámite - CFIA] = 14798
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 8, N'Trámites Construcción', 2, 226, N'APC-M - Administrador de Proyectos de Construcción – Municipal', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_226 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 226
          AND P.IdEstado NOT IN (7, 8)
          AND T.[3_Tipo de trámite - CFIA] = 14799
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 8, N'Trámites Construcción', 3, 226, N'APC-R - Administrador de Proyectos de Construcción – Requisitos', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_226 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 226
          AND P.IdEstado NOT IN (7, 8)
          AND T.[3_Tipo de trámite - CFIA] = 14800
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin))

        UNION ALL
        SELECT 8, N'Trámites Construcción', 4, 226, N'APT - Administrador de Proyectos de Topografía', P.FechaInicio
        FROM dbo.AP__BPM_Procesos P WITH (NOLOCK)
        INNER JOIN dbo.Panel_226 T WITH (NOLOCK) ON T._ElementID = P.ID
        WHERE P.IdClaseProceso = 226
          AND P.IdEstado NOT IN (7, 8)
          AND T.[3_Tipo de trámite - CFIA] = 14801
          AND (@FechaInicio IS NULL OR P.FechaInicio >= @FechaInicio)
          AND (@FechaFin IS NULL OR P.FechaInicio < DATEADD(DAY, 1, @FechaFin));


    ------------------------------------------------------------
    -- Resultado final: catálogo completo + conteo mensual por trámite
    -- Nota: se usa @Catalogo para que también aparezcan trámites con 0.
    ------------------------------------------------------------
    SELECT
         C.OrdenBloque,
         C.Bloque,
         C.Orden,
         C.IdClaseProceso,
         C.NombreTramite,
         SUM(CASE WHEN MONTH(D.FechaInicio) = 1  THEN 1 ELSE 0 END) AS ENE,
         SUM(CASE WHEN MONTH(D.FechaInicio) = 2  THEN 1 ELSE 0 END) AS FEB,
         SUM(CASE WHEN MONTH(D.FechaInicio) = 3  THEN 1 ELSE 0 END) AS MAR,
         SUM(CASE WHEN MONTH(D.FechaInicio) = 4  THEN 1 ELSE 0 END) AS ABR,
         SUM(CASE WHEN MONTH(D.FechaInicio) = 5  THEN 1 ELSE 0 END) AS MAY,
         SUM(CASE WHEN MONTH(D.FechaInicio) = 6  THEN 1 ELSE 0 END) AS JUN,
         SUM(CASE WHEN MONTH(D.FechaInicio) = 7  THEN 1 ELSE 0 END) AS JUL,
         SUM(CASE WHEN MONTH(D.FechaInicio) = 8  THEN 1 ELSE 0 END) AS AGO,
         SUM(CASE WHEN MONTH(D.FechaInicio) = 9  THEN 1 ELSE 0 END) AS SEP,
         SUM(CASE WHEN MONTH(D.FechaInicio) = 10 THEN 1 ELSE 0 END) AS OCT,
         SUM(CASE WHEN MONTH(D.FechaInicio) = 11 THEN 1 ELSE 0 END) AS NOV,
         SUM(CASE WHEN MONTH(D.FechaInicio) = 12 THEN 1 ELSE 0 END) AS DIC,
         COUNT(D.FechaInicio) AS Cantidad
    FROM @Catalogo C
    LEFT JOIN @Datos D
        ON  D.OrdenBloque = C.OrdenBloque
        AND D.Bloque = C.Bloque
        AND D.Orden = C.Orden
        AND D.IdClaseProceso = C.IdClaseProceso
        AND D.NombreTramite = C.NombreTramite
    WHERE @Bloque IS NULL
        OR @Bloque = N''
        OR @Bloque LIKE N'%Todos%'
        OR EXISTS (
            SELECT 1
            FROM STRING_SPLIT(@Bloque, N'|') B
            WHERE LTRIM(RTRIM(B.value)) = C.Bloque
        )
    GROUP BY
        C.OrdenBloque,
        C.Bloque,
        C.Orden,
        C.IdClaseProceso,
        C.NombreTramite
    ORDER BY
        C.OrdenBloque,
        C.Orden;
END;
GO
