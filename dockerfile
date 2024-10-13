# Use the official PostgreSQL image from Docker Hub
FROM postgres:latest

# Set environment variables for Postgres user, password, and database
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=password
ENV POSTGRES_DB=app
COPY ./init.sql /docker-entrypoint-initdb.d/


# Expose the default PostgreSQL port
EXPOSE 5432