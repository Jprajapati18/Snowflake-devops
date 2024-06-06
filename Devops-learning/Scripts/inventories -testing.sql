create or replace database SNOWFLAKE_DEVOPS;

create schema SNOWFLAKE_DEVOPS.devops;

CREATE ROLE accountadmin ;


GRANT ROLE DEVOPS_DEV TO ROLE accountadmin;


use role DEVOPS_DEV;

grant usage on database SNOWFLAKE_DEVOPS to role DEVOPS_DEV;
grant usage on schema SNOWFLAKE_DEVOPS.devops to role DEVOPS_DEV;
grant select on future tables in schema SNOWFLAKE_DEVOPS.devops to role DEVOPS_DEV;



create or replace secret SNOWFLAKE_DEVOPS.devops.jigar_github_secret
type = PASSWORD
USERNAME = 'Jprajapati18' 
PASSWORD = 'Jpraja@18$$$';


SHOW SECRETS;


CREATE OR REPLACE API INTEGRATION JIGAR_GITHUB_API_INTEGRARION
API_PROVIDER = GIT_HTTPS_API
API_ALLOWED_PREFIXES = ('https://github.com/Jprajapati18')
ALLOWED_AUTHENTICATION_SECRETS = (jigar_github_secret)
ENABLED = TRUE;


SHOW INTEGRATIONS;

SHOW API INTEGRATIONS;


DESCRIBE API INTEGRATION JIGAR_GITHUB_API_INTEGRARION;



CREATE OR REPLACE GIT REPOSITORY DEVOPS_REPO
API_INTEGRATION =JIGAR_GITHUB_API_INTEGRARION
GIT_CREDENTIALS = jigar_github_secret
ORIGIN = 'https://github.com/Jprajapati18/Snowflake-devops.git';


show git repositories;

grant read ON GIT REPOSITORY DEVOPS_REPO TO ROLE  DEVOPS_DEV;

USE ROLE accountadmin;

list @DEVOPS_REPO/branches/main;

list @DEVOPS_REPO/commits/380048cde12911c665ea29ca0231024fadfa3ba1;


show git branches in devops_repo;

show git tags in devops_repo;


alter git repository devops_repo fetch;

execute immediate from @devops_repo/branches/dev/Devops-learning/Scripts/table-1.sql;

show tables LIKE '%MY_TABLE%';
















