As root, become the postgres user.

# su - postgres
-bash-3.00$
Open up /var/lib/pgsql/data/pg_hba.conf in your text editor and look for the authentication method for the postgres user. Unless you are connecting to PostgreSQL over the network, it will be a local user, so look for the line starting with that:

local all postgres md5
Network users would begin with "host" and there would also be an IP address and netmask:

host all postgres 10.255.255.10 255.255.255.0 md5
If your system is configured for all users to authenticate in the same way, you see "all" in place of a username.

local all all md5
Note that "md5" may be set to "password" or a number of other options, but you want to make it "ident sameuser". This means you can connect to PostgreSQL as long as you are the user specified.

local all postgres ident sameuser
After you have saved your changes to pg_hba.conf, issue the command 'pg_ctl reload'. You will be able to connect now with psql.

-bash-3.00$ pg_ctl reload
postmaster signaled
-bash-3.00$ psql
Welcome to psql 8.1.8, the PostgreSQL interactive terminal.

Type:  \copyright for distribution terms
       \h for help with SQL commands
       \? for help with psql commands
       \g or terminate with semicolon to execute query
       \q to quit

postgres=#
Now reset your password.

postgres=# ALTER USER postgres WITH ENCRYPTED PASSWORD 'password';
ALTER ROLE
postgres=# \q
Now re-edit pg_hba.conf to set it back to using md5 or password authentication (md5 is more secure). Signal a reload again, then run psql to make sure it is working.

-bash-3.00$ pg_ctl reload
postmaster signaled
-bash-3.00$ psql
Password:
Welcome to psql 8.1.8, the PostgreSQL interactive terminal.

Type:  \copyright for distribution terms
       \h for help with SQL commands
       \? for help with psql commands
       \g or terminate with semicolon to execute query
       \q to quit

postgres=#