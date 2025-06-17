-- This script checks for messy indexes (fragmentation)
SELECT
    dbschemas.[name] as 'Schema',
    dbtables.[name] as 'Table',
    dbindexes.[name] as 'Index',
    indexstats.avg_fragmentation_in_percent,
    indexstats.page_count
FROM
    sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS indexstats
INNER JOIN
    sys.tables dbtables on dbtables.[object_id] = indexstats.[object_id]
INNER JOIN
    sys.schemas dbschemas on dbtables.[schema_id] = dbschemas.[schema_id]
INNER JOIN
    sys.indexes AS dbindexes ON dbindexes.[object_id] = indexstats.[object_id]
    AND indexstats.index_id = dbindexes.index_id
WHERE
    indexstats.avg_fragmentation_in_percent > 10 -- Show me indexes that are more than 10% messy
ORDER BY
    indexstats.avg_fragmentation_in_percent DESC;