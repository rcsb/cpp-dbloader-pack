# db-loader usage

## Schema Processing

In order to prepare a relational database schema (and relevant shell scripts), the `-schema` command line option is used.

### Example 1 

An example of preparing a MySQL schema. It is assumed that schema mapping configuration file is "schema_mapping.cif", the database name is
"testdb" and the database user is "testuser".

```
db-loader -map schema_mapping.cif -server mysql -db testdb -dbuser testuser -schema
```

The result of this command are the following generated files:

- `DB_LOADER_SCHEMA_COMMANDS.csh` - this script is executed to do all schema related processing on the DB server. It utilizes the two *.sql files described below in order to first delete the existing schema and then create a new one.
- `DB_LOADER_SCHEMA_DROP.sql` - SQL instructions to delete existing schema tablesfrom DB (prior to loading new schema)
- `DB_LOADER_SCHEMA.sql` - SQL instructions for creating the DB schema

To generate schemas for other databases use proper name in the "-server" option.

### Example 2

 An example of preparing an XML schema. It is assumed that schema
mapping configuration file is "schema_mapping.cif".

```
db-loader -map schema_mapping.cif -xml -schema
```

The result of this command is a single file:

- `DB_LOADER_SCHEMA_XML.xsd` - an XML schema file 

## Data Processing

CIF data input

In a single invocation, this application can process either one CIF file or
multiple CIF files. A single file is processed using the `-f` command line
option. Multiple files are processed using the `-list` command line option.
`-list` expects a file name, which contains a list of CIF file names (separated
by newlines) which are to be processed.

### Example 3
In this example one CIF file (`my_file.cif`) will be converted to MySQL server data in SQL format. It is assumed that schema mapping configuration file is `schema_mapping.cif`, the database name is `testdb` and
the database user is `testuser`. Note that schema mapping will not be revised, 
since `-revise` option is absent.

```
db-loader -map schema_mapping.cif -server mysql -db testdb -dbuser testuser \
  -f my_file.cif
```

The result of this command are the following generated files:

- `DB_LOADER_COMMANDS.csh` - this script is executed to do all data related processing on the DB server. It utilizes an SQL file described below to do DB loading.
- `DB_LOADER.sql` - data in form of SQL instructions that is to be loaded.

To generate schemas for other databases use proper name in the `-server` option.

To process multiple files at once, use `-list` instead of `-f` option.

To also revise the schema mapping, use `-revise` option followed by the name
of the file to which a revised schema mapping is to be stored.

### Example 4

In this example three CIF files (`file-1.cif`, `file-2.cif` and
`file-3.cif`) will be converted to Sybase server data in BCP format. It is assumed
that schema mapping configuration file is `schema_mapping.cif`, the database
name is `testdb` and the database user is `testuser`. Data field terminator
is set to `&##&\t` and data row terminator is set to `$##$\n`. The schema
mapping will be revised and written to `revised_schema_mapping.cif`.

```
db-loader -map schema_mapping.cif -server sybase -db testdb -dbuser testuser \
  -ft '&##&\t' -rt '$##$\n' -list file_list.txt \
  -revise revised_schema_mapping.cif
```

The content of the file `file_list.txt` is this:

```
file-1.cif
file-2.cif
file-3.cif
```

The result of this command is the following generated files:

- `DB_LOADER_COMMANDS.csh` - this script is executed to do all data related processing on the DB server. It utilizes an SQL file described below to first delete data and then the other script to load the data. The actual data is stored in `*.bcp` files.
- `DB_LOADER_DELETE.sql` - statements to delete the data (if it exists)
- `DB_LOADER_LOAD_COMMANDS.csh` - the script which utilizes `*.bcp` files and loads the data to the DB server 
- `*.bcp` - files containing the data to be loaded in bulk

To generate data for other databases use proper name in the `-server` option.
Note that for other databases, there may be differences in the number and
types of files that are needed for bulk loading.


### Example 5

In this example the current schema and the revised schema mapping
are combined to create a new schema mapping.

```
db-loader -map schema_mapping.cif -update updated_schema_mapping.cif \
          -revise revised_schema_mapping.cif
```

After executing this command, an updated schema mapping is stored in the file
`updated_schema_mapping.cif` and can be used in future data processing with
`-map` option.


### Example 6

In this example one CIF file (`my_file.cif`) will be converted to XML data output. It is assumed that schema mapping configuration file is
`schema_mapping.cif`. Note that schema mapping will not be revised, 
since `-revise` option is absent.

```
db-loader -map schema_mapping.cif -xml -f my_file.cif
```

The result of this command is one file:

- `my_file.cif.xml` - this is an XML equivalent of relational DB data.



