# miauau-database
Docker Container and SQL Script for Mocking Database in miauau Project

for setup, start Docker Engine and run the following commands:

docker build -t mypostgres-dev

docker run --name postgres-dev-container -d -p 5432:5432 mypostgres-dev
