       SELECT pg_terminate_backend(procpid)
       FROM pg_stat_activity
       WHERE datname = 'baddatabase';

-- terminate process by an annoying user
       SELECT pg_terminate_backend(procpid)
       FROM pg_stat_activity
       WHERE usename = 'baduser';
