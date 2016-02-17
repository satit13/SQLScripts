use bcvat
drop table tempdb.dbo.bcstkadjust 
drop table tempdb.dbo.bcstkadjustsub 
drop table tempdb.dbo.bctrans_stkadj
drop table tempdb.dbo.bctranssub_stkadj

--IO-IP-IJ 
go 

select * 
into tempdb.dbo.bcstkadjust 
from nebula.bcnp.dbo.bcstkadjust 
--where ((docno like ('%IJ%') and mydescription like '%**66**%') or 
--(docno like ('%IP%') and mydescription like '%**69**%')) and YEAR(docdate)>=2014
where (docno like '%IO%' or docno like '%IP%' or docno like '%IJ%') and YEAR(docdate)=2015
go 


select * 
into tempdb.dbo.bcstkadjustsub 
from nebula.bcnp.dbo.bcstkadjustsub 
where docno in 
	(
	select docno from tempdb.dbo.bcstkadjust 
	)



select * 
into tempdb.dbo.bctrans_stkadj 
from nebula.bcnp.dbo.bctrans 
where docno in 
	(
	select docno from tempdb.dbo.bcstkadjust 
	)



select * 
into tempdb.dbo.bctranssub_stkadj 
from nebula.bcnp.dbo.bctranssub 
where docno in 
	(
	select docno from tempdb.dbo.bcstkadjust 
	)

go 



alter table tempdb.dbo.bcstkadjust drop column roworder
alter table tempdb.dbo.bcstkadjustsub drop column roworder
alter table tempdb.dbo.bctrans_stkadj drop column roworder
alter table tempdb.dbo.bctranssub_stkadj drop column roworder
go 

delete bcstkadjust where docno in (select docno from  tempdb.dbo.bcstkadjust)
delete bcstkadjustsub where docno in (select docno from  tempdb.dbo.bcstkadjust)
delete bctrans where docno in (select docno from  tempdb.dbo.bcstkadjust)
delete bctranssub where docno in (select docno from  tempdb.dbo.bcstkadjust)
go 



insert into bcstkadjust select * from tempdb.dbo.bcstkadjust
insert into bcstkadjustsub select * from tempdb.dbo.bcstkadjustsub
insert into bctrans select * from tempdb.dbo.bctrans_stkadj
insert into bctranssub select * from tempdb.dbo.bctranssub_stkadj
go 