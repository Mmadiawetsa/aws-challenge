import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from awsglue.dynamicframe import DynamicFrame
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)

# variables
glue_db = "injest-db"
glue_table = "read"
s3_write_path = "s3://glue-injest-bucket/write"

########################### Load the dataset #######################

dynamic_frame = spark.read.csv("glue_db", header=True)

dynamic_frame.write.parquet("file:///parquet")

dynamic_frame_write = spark.read.parquet("file:///parquet")

datasource = glue_context.write_dynamic_frame.from_options(
    frame = dynamic_frame_write,
    connection_type = "s3",
    connection_options = {
        "path": s3_write_path,
        # "partitionKeys": ["column_name"]
    },
    transformation_ctx = "datasource"
)
job.commit()