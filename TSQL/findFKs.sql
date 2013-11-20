SELECT ROW_NUMBER() OVER (ORDER BY OBJECT_NAME(fk.referenced_object_id), clm1.name) as 'S.No',
       fk.referenced_object_id as ReferencedObjID,
       constraint_column_id as ColumnID,
       OBJECT_NAME(fk.referenced_object_id) as [ReferencedTable(Parent)],
       SCHEMA_NAME (CAST(OBJECTPROPERTYEX(fk.referenced_object_id,N'SchemaId') AS bit)) as [ParentSchema],
       clm2.name as ReferencedColumnName,
       OBJECT_NAME(constraint_object_id) as ConstraintName,
       fk.parent_object_id as ReferencingObjID,
       OBJECT_NAME(fk.parent_object_id) as [ReferencingTable (Foreign)],
       clm1.name as ForeignKeyColumn,
       SCHEMA_NAME (CAST(OBJECTPROPERTYEX(fk.parent_object_id,N'SchemaId') AS bit)) as [ForeignSchema],
       [Action on Update] = CONVERT(varchar,CASE OBJECTPROPERTY(constraint_object_id,'CnstIsUpdateCascade')  
                                        WHEN 1 THEN 'CASCADE'
                                        ELSE 'NO_ACTION'
                                      END), 
       [Action on Delete] = CONVERT(varchar,CASE OBJECTPROPERTY(constraint_object_id,'CnstIsDeleteCascade')  
                                        WHEN 1 THEN 'CASCADE'
                                        ELSE 'NO_ACTION'
                                      END)
FROM sys.foreign_key_columns fk
       JOIN sys.columns clm1 
         ON fk.parent_column_id = clm1.column_id 
            AND fk.parent_object_id = clm1.object_id
       JOIN sys.columns clm2
         ON fk.referenced_column_id = clm2.column_id 
            AND fk.referenced_object_id= clm2.object_id
--WHERE OBJECT_NAME(fk.referenced_object_id) = 'TBL_TEST'  --- table name which is being referenced by other tables via Foreign Keys
ORDER BY OBJECT_NAME(fk.referenced_object_id)
