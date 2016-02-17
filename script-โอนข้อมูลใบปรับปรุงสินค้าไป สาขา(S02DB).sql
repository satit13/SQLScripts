use bcnp
--drop table tempdb.dbo.bcstkadjust 
--drop table tempdb.dbo.bcstkadjustsub 

select * 
into tempdb.dbo.bcstkadjust 
from nebula.bcnp.dbo.bcstkadjust 
where docno in 
	(
	'S02-IJ5312-0003','S02-IJ5312-0004'
	)


select * 
into tempdb.dbo.bcstkadjustsub 
from nebula.bcnp.dbo.bcstkadjustsub 
where docno in 
	(
	'S02-IJ5312-0003','S02-IJ5312-0004'
	)


drop table tempdb.dbo.bctrans_stkadj 
drop table tempdb.dbo.bctranssub_stkadj

select * 
into tempdb.dbo.bctrans_stkadj 
from nebula.bcnp.dbo.bctrans 
where docno in 
	(
	'S02-IJ5312-0003','S02-IJ5312-0004'
	)



select * 
into tempdb.dbo.bctranssub_stkadj 
from nebula.bcnp.dbo.bctranssub 
where docno in 
	(
	'S02-IJ5312-0003','S02-IJ5312-0004'
	)


alter table tempdb.dbo.bcstkadjust drop column roworder
alter table tempdb.dbo.bcstkadjustsub drop column roworder
alter table tempdb.dbo.bctrans_stkadj drop column roworder
alter table tempdb.dbo.bctranssub_stkadj drop column roworder

delete bcstkadjust where docno in (select docno from  tempdb.dbo.bcstkadjust)
delete bcstkadjustsub where docno in (select docno from  tempdb.dbo.bcstkadjust)
delete bctrans where docno in (select docno from  tempdb.dbo.bcstkadjust)
delete bctranssub where docno in (select docno from  tempdb.dbo.bcstkadjust)


insert into bcstkadjust select * from tempdb.dbo.bcstkadjust
insert into bcstkadjustsub select * from tempdb.dbo.bcstkadjustsub
insert into bctrans select * from tempdb.dbo.bctrans_stkadj
insert into bctranssub select * from tempdb.dbo.bctranssub_stkadj
