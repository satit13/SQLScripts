use bcvat
if exists(select name from tempdb.dbo.sysobjects where name = 'bcchartofaccount')
	drop table tempdb.dbo.bcchartofaccount 

select * into tempdb.dbo.bcchartofaccount 
	from nebula.bcnp.dbo.bcchartofaccount where code not in 
(select code from bcchartofaccount)

alter table tempdb.dbo.bcchartofaccount drop column roworder

insert into bcchartofaccount select * from tempdb.dbo.bcchartofaccount

go

-- update ชื่อบัญชีให้ตรงกับหน้าร้าน
update bcchartofaccount set name1 = b.name1 
from bcchartofaccount a inner join nebula.bcnp.dbo.bcchartofaccount b on a.code=b.code
where a.name1 <> b.name1

go 

----


