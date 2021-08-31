# banco todo
mysqldump -u root -p --databases sucos_vendas > dir/dump.sql

# tabela especifica
mysqldump -u root -p --databases sucos_vendas --tables notas_fiscais > dir/dump.sql


# ignorando tabela especifica
mysqldump -u root -p --databases sucos_vendas --ignore-table sucos_vendas.notas_fiscais > dir/dump.sql


# somente inserts
mysqldump -u root -p --databases sucos_vendas --no-create-db --no-create-info --complete-insert > dir/dump.sql

#restaurar bd
mysql -u root -p < dir/dump.sql

LOCK INSTANCE FOR BACKUP;
UNLOCK INSTANCE