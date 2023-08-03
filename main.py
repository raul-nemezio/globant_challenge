from typing import Union

from fastapi import FastAPI, File, UploadFile
import pandas as pd
from sqlalchemy import create_engine
import os
from dotenv import load_dotenv

load_dotenv()
app = FastAPI()

password = os.getenv('password')
con = create_engine(f"postgresql+psycopg2://postgres:{password}@localhost:5432/postgres")

@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.post("/uploadfile/")
async def create_upload_file(file: UploadFile = File(...)):

    df = pd.read_csv(file.file)
    file = file.filename.replace('.csv', '')

    df.to_sql(file, con, schema='bronze',
              if_exists='replace', index=False)

    return f"{file} was upload do postgre!"
