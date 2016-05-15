People System
========================
The purpose of this application is to allow a user to add the basic information about a person and notify via email to the existent people in the system when a user is added or deleted.

Delivery Date
===================

Tuesday, May 17th, 2016

Instalation Steps
===================

System dependencies
* Ruby 2.2.4
* Redis server (http://redis.io)
* RVM (https://rvm.io)
* MySQL

Clone the proyect using https:`git clone https://github.com/jasonbolbar/people_system.git`
or via ssh:`git clone git@github.com:jasonbolbar/people_system.git`

On the folder proyect run the folloing command: 
```
  bundle install
```

On `config` directoy create `database.yml` with the following content:
```
default: &default
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: <DATABASE USERNAME>
  password: <DATABASE PASSWORD>
  socket: /var/run/mysqld/mysqld.sock
```
This configuration will be used to establish the connection to the database. For each environment consider to add the following lines in `database.yml` :
```
<ENVIRONMENT>:
  <<: *default
  database: <DATABASE_NAME>
```
