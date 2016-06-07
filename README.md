# sigeu-deseg

Installation on Ubuntu 14.04:
- Install Eclipse J2EE
- Install PostgreSQL (https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-14-04)
- sudo -i -u postgres
- psql
- create user ...;
- select * from pg_user;
- \du
- create database test1;
- \conninfo  (show how you're connected)
- create table nameOfTable ( test serial PRIMARY KEY );
- \d  (show tables created)

Cada pasta dentro do repositório corresponde a um projeto do Eclipse. Seguem requisitos de cada projeto:

SIGEU:
- Java JDK 1.8 
- Apache Tomcat 8
- Eclipse Luna
  - EGit plugin
  - Maven Plugin
# sigeu-deseg
