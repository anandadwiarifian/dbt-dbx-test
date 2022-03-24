{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 'raw_product'
derived_columns:
  RECORD_SOURCE: "!1SAP"
  LOAD_DATETIME: 'CURRENT_TIMESTAMP()'
hashed_columns:
  PRODUCT_HK: PRODUCT_ID
  PRODUCT_HASHDIFF:
    is_hashdiff: true
    columns:
      - PRODUCT_DESC
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}