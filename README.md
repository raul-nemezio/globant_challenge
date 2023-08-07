# globant_challenge

## Section API

For this section I have used Python and FastAPI to do a simple API in which the user can select the csv and this will load the csv into the database in the schema bronze.

![alt text](./images/upload_csv_api.PNG?raw=true)

## Postgre SQL

To create the database I have used docker using the command 'sudo docker run --name globant_postgre -e POSTGRES_PASSWORD= -p 5432:5432 -d postgres', I did not have the time to change this and the code to docker compose, but with this simple change the code would be easily transferable to any cloud virtual machine or docker enviroment.

## Queries results

The results of both queries were:

### Query 1:

![alt text](./images/employees_grouped_query_result.PNG?raw=true)

### Query 2:

![alt text](./images/hired_result_query.PNG?raw=true)