from typing import Union

from fastapi import FastAPI, File, UploadFile
import pandas as pd
from sqlalchemy import create_engine
import os
from dotenv import load_dotenv
import json

load_dotenv()
app = FastAPI()

password = os.getenv("password")
con = create_engine(
    f"postgresql+psycopg2://postgres:{password}@localhost:5432/postgres"
)

with open("schema.json", "r") as f:
    schema = json.load(f)


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.post("/uploadfile/")
async def create_upload_file(file: UploadFile = File(...)):

    file_name = file.filename.replace(".csv", "")

    if file_name in schema:

        col_names = schema.get(file_name)
        df = pd.read_csv(file.file, header=None, names=col_names)

        df.to_sql(file_name, con, schema="bronze", if_exists="replace", index=False)

        return f"{file_name} was upload do postgre!"

    else:
        return "Schema not saved!"
