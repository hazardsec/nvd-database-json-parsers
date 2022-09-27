# Python to Postgres NVD Download and Import
Program for automating the download and parsing of the NVD JSON Data Feeds and importing them into PostgreSQL

## Usage

### Subcommands
<pre>
./nvd-to-postgresql --help

  ./nvd-to-postgesql download
  ./nvd-to-postgesql import
</pre>
### Options for Subcommands

#### download
<pre>

./nvd-to-postgresql download --help

  --use-defaults      Use default values for download
  --incremental       Only download the recent and modified NVD JSON Data Feeds
  --import            Import records after download
  --exclude-history   Do not create history snapshot (ignored unless --import used)
  --delete-downloads  Deletes all downloaded NVD JSON files that match the default path or the path specified at runtime (ignored unless --import used)
</pre>
#### import
<pre>

./nvd-to-postgresql import --help

  --use-defaults      Use default values for import
  --incremental       Only import the recent and modified NVD JSON Data Feeds
  --download          Download records before import
  --exclude-history   Do not create history snapshot
  --delete-downloads  Deletes all downloaded NVD JSON files that match the default path or the path specified at runtime
</pre>