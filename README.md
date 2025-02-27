# Site-ok hozzaadása kollekciókhoz

```mysql
INSERT INTO site_collections (site_id, collection_id)
SELECT s.id, c.id
FROM sites s
CROSS JOIN collections c;
```