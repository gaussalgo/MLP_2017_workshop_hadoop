# Telco Data Sample on AWS S3

For the purpose of the conference we have created an S3 bucket with voice call data.

The bucket is named : **mlprague**

Location of the data sets is : **s3.eu-central-1.amazonaws.com**

There are 4 data sets:

**mlp_sampled_cdr_records.parquet** - phone call records from two months

record_type: string - type of voice records
date_key: string - date of the call
duration: integer - duration of the call in seconds
frommsisdn_prefix: string - operator prefix
frommsisdn: long - home operator number (either receiving or calling - according to the record type)
tomsisdn_prefix: string - operator prefix
tomsisdn: long - number of the second customer (can be either of the home operator or not)

**mlp_sampled_ebr_base_20160401.parquet, mlp_sampled_ebr_base_20160501.parquet** - information about home operator customers

msisdn: long - number of the customer
customer_type: string - either private or business
commitment_from_key: string - date of the commitment start
commitment_to_key: string - date of the commitment end
rateplan_group: long - name of the rateplan group
rateplan_name: long - name of the raplan

**mlp_sampled_ebr_churners_20151201_20160630.parquet** - list of churned customers from two months

msisdn: long - number of the customer
date_key: string - date of the churn

To access the data we have created a temporary key and secret to the S3 bucket. Let us know a bit about yourself and collect the keys to access S3.

https://goo.gl/forms/pdibUnh6yANd4kg22

# Primer for accessing S3 data with Spark2

Code:
```
from pyspark.context import SparkContext
from pyspark.sql import HiveContext

sc = SparkContext()
sqlContext = HiveContext(sc)

sc._jsc.hadoopConfiguration().set("fs.s3a.access.key","<ENTER ACCESS KEY>")
sc._jsc.hadoopConfiguration().set("fs.s3a.secret.key", "<ENTER SECRET KEY>")
sc._jsc.hadoopConfiguration().set("fs.s3a.endpoint", "s3.eu-central-1.amazonaws.com")

df1 = sqlContext.read.parquet('s3a://mlprague/pub/mlp_sampled_cdr_records.parquet')
df2 = sqlContext.read.parquet('s3a://mlprague/pub/mlp_sampled_ebr_base_20160401.parquet')
df3 = sqlContext.read.parquet('s3a://mlprague/pub/mlp_sampled_ebr_base_20160501.parquet')
df4 = sqlContext.read.parquet('s3a://mlprague/pub/mlp_sampled_ebr_churners_20151201_20160630.parquet')

df1.printSchema()
df2.printSchema()
df3.printSchema()
df4.printSchema()

sc.stop()
exit()
```
