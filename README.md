## About the project 
I had an use case to transform a considerable amount of data to Data Vault 2.0 in Databrick environment. To simplify the process, I was looking for an open-source tools to automate the process to ease deployment and maintenance. I encountered [dbt (data build tool)](https://docs.getdbt.com/) and [dbtvault](https://dbtvault.readthedocs.io/en/latest/).

dbt can work just fine in Databricks, but there are still SQL template codes that need to be develop to use dbt for developing DV2.0 in that platform.

So, I changed some source code files of dbtvault. This project is basically a dbt project folder with dbtvault package installed, but the dbtvault package is adjusted a little bit to support Databricks. The source code files changed are [hub.sql](dbt_packages/dbtvault/macros/tables/databricks/) and [link.sql](dbt_packages/dbtvault/macros/tables/databricks/link.sql). The macro for hashing is also adjusted [here](dbt_packages/dbtvault/macros/supporting/hash.sql).

## Prerequisites
This project uses dbt-core 1.0.4 version and dbt databrick plugin 1.0.1 version. 

To install both dependencies, run: 
```sh
pip install dbt-core==1.0.4 dbt-databricks==1.01
```


