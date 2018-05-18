ALTER TABLE documents ADD COLUMN custom text NOT NULL DEFAULT "";
ALTER TABLE documents MODIFY id varchar(64);
ALTER TABLE documents MODIFY content longblob NOT NULL;

UPDATE documents SET id = SHA2(id, 256) WHERE LENGTH(id) < 64; # Update to SHA256 IDs

ALTER TABLE documents DROP COLUMN address;
