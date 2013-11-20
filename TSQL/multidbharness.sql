
exec sp_MSforeachdb
' use ?
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = ''dbo'' AND  TABLE_NAME = ''version'')
begin 
    /* This is a Certain Database */
    print ''Processing database ?''
BEGIN TRY
      INSERT INTO maintenance.dbo.BIRegistrations (portal, registrations, date)
            SELECT ''?'', COUNT(reg_id), DATEADD(DAY, DATEDIFF(DAY, -1, GETDATE()), -1)  FROM 
            registrations
            WHERE reg_is_test = 0
            AND reg_is_active = 1
            AND reg_date_created >=  (SELECT DATEADD(DAY, DATEDIFF(DAY, -1, GETDATE()), -1))
END TRY
BEGIN CATCH
        SELECT ''Error: '' + ERROR_MESSAGE()
END CATCH
end
'
