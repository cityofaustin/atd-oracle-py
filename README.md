# ATD Oracle PY

This is a ready-to-run python container that can connect to any Oracle database supported by [cx_Oracle](https://cx-oracle.readthedocs.io/en/latest/user_guide/introduction.html). 

** IT IS NOT PRECONFIGURED TO CONNECT TO ANY SERVICE, IT SERVES ONLY AS A BASE IMAGE **

### How to Use

1.First, create python script:

```python
# File Name: main.py
import cx_Oracle

# Establish the database connection
connection = cx_Oracle.connect("hr", userpwd, "dbhost.example.com/orclpdb1")

# Obtain a cursor
cursor = connection.cursor()

# Data for binding
managerId = 145
firstName = "Peter"

# Execute the query
sql = """SELECT first_name, last_name
         FROM employees
         WHERE manager_id = :mid AND first_name = :fn"""
cursor.execute(sql, mid = managerId, fn = firstName)

# Loop over the result set
for row in cursor:
    print(row)
```

2.Then create a docker image:

```dockerfile
# File Name: Docker-sample
FROM atddocker/atd-oracle-py:production

# Copy your python script to any workdir
WORKDIR /app
COPY main.py  /app/main.py
```
3.Build and run your script:

```
$ docker build -f Dockerfile-sample -t atd-oracle-py-sample .
$ docker run -it --rm --name oracle-test atd-oracle-py-sample ./main.py
```


### Build Container Locally

A basic build command will suffice. In the following example, notice
the docker build tag is set to `local` which is a trivial way to 
differentiate environments:

```
docker build -f Dockerfile -t atd-oracle-py:local .
```

### Docker-Compose

There are two docker-compose examples provided, these are examples on
how to run Oracle locally. I can be a lengthy process on slow computers.

These two examples require that you build the containers first before
launch; once built, you should be able to run the services for your own
testing.

The Oracle image builder was taken from [this Oracle repo](https://github.com/oracle/docker-images/tree/master/OracleDatabase/SingleInstance) 
and put here for your convenience. To build a test database:

1. Download the Oracle version you would like to use form [this link](https://www.oracle.com/database/technologies/oracle-database-software-downloads.html)
and notice that you may only be able to run the Express Editions 11g or 18c.
2. Place the downloaded RPM or ZIP into the ~/OracleDatabase/dockerfiles/`<version>` folder.
For version 18c put your RPM file in `18.4.0`, or if 11g put the zip file in `11.2.0.2` and do not decompress/extract it.
3. Build the oracle image:
- For version 18c: `./buildDockerImage.sh -v 18.4.0 -x`
- For version 11g: `./buildDockerImage.sh -v 11.2.0.2 -x` 

 
Please also note these files and the OracleDatabase are part of `.dockerignore` and they
are not put in the container build process.

### Staging and Production

As of now, we are currently building the staging (master) and production branches using respective tags:
- Production: `atd-oracle-py:production`
- Staging: `atd-oracle-py:master`

 

