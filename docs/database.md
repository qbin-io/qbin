# Database Structure

qbin requires a MariaDB (or MySQL) database, and will create the following table:

## documents

| Column | Type | Description |
| ------ | ---- | ----------- |
| `id`* | `varchar(30)` | Name of the document as used in the URL |
| `content` | `longtext` | Syntax-highlighted document content |
| `syntax` | `varchar(30)` | Syntax highlighting language name, defaults to an empty string |
| `upload` | `datetime` | Upload time, defaults to `CURRENT_TIMESTAMP` |
| `expiration` | `datetime` | Expiration time, defaults to `NULL` (no expiration). A value less or equal than `FROM_UNIXTIME(0)` indicates a volatile document (deleted on first view). |
| `address` | `varchar(45)` | IPv6 (or IPv6-encoded IPv4) address of the uploader |
| `views` | `int unsigned` | Number of views a document has received |
