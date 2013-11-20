CREATE OR REPLACE FUNCTION sp_find_events_to_archive(days_param int) RETURNS INTEGER
AS
$$
DECLARE returned_events INTEGER;
DECLARE month_interval INTERVAL;
BEGIN
-- Test Function, not production.   Testing Archiving.
month_interval = days_param || ' months';
TRUNCATE TABLE events_to_archive;
INSERT INTO events_to_archive (event_id)
SELECT evt_id FROM events where evt_end_date <= now() - month_interval;
SELECT COUNT (event_id) INTO returned_events FROM events_to_archive ;
RETURN returned_events;
END;
$$
LANGUAGE plpgsql
