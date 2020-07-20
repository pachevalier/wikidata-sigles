#!/bin/bash
# fail on error

set -e
export api="https://www.data.gouv.fr/api/1"
export dataset_id="5f10abd45b3b4e87f947e9d4"
export api_key=$API_KEY

curl -G https://query.wikidata.org/bigdata/namespace/wdq/sparql --data-urlencode query="$(< administrations.sparql)" -H 'Accept: text/csv' > wikidata-sigles-administrations.csv

curl "$api/datasets/$dataset_id/resources/6bbf9c18-73cc-4aeb-baa9-6de5c2cb099a/upload/" -F "file=@wikidata-sigles-administrations.csv" -H "X-API-KEY:$api_key"

curl -G https://query.wikidata.org/bigdata/namespace/wdq/sparql --data-urlencode query="$(< administrations.sparql)" -H 'Accept: text/csv' > wikidata-sigles-impots.csv

curl "$api/datasets/$dataset_id/resources/3b72dccb-10d4-4ef5-9d1a-c1e6b0778f61/upload/" -F "file=@wikidata-sigles-impots.csv" -H "X-API-KEY:$api_key"
