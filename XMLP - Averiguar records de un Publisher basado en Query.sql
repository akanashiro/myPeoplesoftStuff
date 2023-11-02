-- Obtengo el tipo de origen (DS_TYPE) y el origen de datos (DS_ID)
SELECT *
FROM PSXPRPTDEFN
WHERE REPORT_DEFN_ID = 'REPORT_NAME';

-- Datos de origen de datos
SELECT *
FROM PSXPDATASRC
WHERE DS_ID = 'REPORT_NAME_Q';

-- Definición de query
SELECT *
FROM PSQRYDEFN
WHERE QRYNAME = 'REPORT_NAME_Q';

-- Records de query
SELECT *
FROM PSQRYRECORD
WHERE QRYNAME = 'REPORT_NAME_Q';