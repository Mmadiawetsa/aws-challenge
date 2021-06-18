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

dynamic_frame_read = glue_context.create_dynamic_frame.from_catalog(
    database = glue_db, table_name = glue_table
)

dataframe = dynamic_frame_read.toDF()

########################## Data Transformation #####################

ordered_dataframe = ordered_dataframe.orderBy(f.desc("Column_name"))

########################## Load Data ###############################

ordered_dataframe = ordered_dataframe.repartition(1)

dynamic_frame_write = DynamicFrame.fromDF(ordered_dataframe, glue_context, "dynamic_frame_write")

# write back to s3
glue_context.write_dynamic_frame.from_options(
    frame = dynamic_frame_write,
    connection_type = "s3",
    connection_options = {
        "path": s3_write_path,
        # "partitionKeys": ["column_name"]
    },
    format = "csv"
)
job.commit()