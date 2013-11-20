SELECT s.name AS 'schema', ts.name AS TableName,
c.name AS column_name, c.column_id,
SCHEMA_NAME(t.schema_id) AS DatatypeSchema,
t.name AS Datatypename
,t.is_user_defined, t.is_assembly_type
,c.is_nullable, c.max_length, c.PRECISION,
c.scale
FROM sys.columns AS c
INNER JOIN sys.types AS t ON c.user_type_id=t.user_type_id
INNER JOIN sys.tables ts ON ts.OBJECT_ID = c.OBJECT_ID
INNER JOIN sys.schemas s ON s.schema_id = ts.schema_id
ORDER BY s.name, ts.name, c.column_id
