use bcvat

drop table tempdb.dbo.bcstkissueret_key
drop table tempdb.dbo.bcstkissueret
drop table tempdb.dbo.bcstkissretsub
drop table tempdb.dbo.bctrans_issueret
drop table tempdb.dbo.bctranssub_issueret
select docno into tempdb.dbo.bcstkissueret_key
	from  nebula.bcnp.dbo.bcstkissueret 
	where (docno like '%ID%')
		and YEAR(docdate)=2015

select * into tempdb.dbo.bcstkissueret 
	from  nebula.bcnp.dbo.bcstkissueret 
	where docno in (select docno from tempdb.dbo.bcstkissueret_key)
		
select * into tempdb.dbo.bcstkissretsub from  nebula.bcnp.dbo.bcstkissretsub
	where docno in (select docno from tempdb.dbo.bcstkissueret_key)
	

select * into tempdb.dbo.bctrans_issueret 
	from nebula.bcnp.dbo.bctrans 
	where docno in (select  docno from tempdb.dbo.bcstkissueret)
select * into tempdb.dbo.bctranssub_issueret 
	from nebula.bcnp.dbo.bctranssub 
	where docno in (select  docno from tempdb.dbo.bcstkissueret)


alter table tempdb.dbo.bcstkissueret drop column roworder
alter table tempdb.dbo.bcstkissretsub drop column roworder
alter table tempdb.dbo.bctrans_issueret drop column roworder
alter table tempdb.dbo.bctranssub_issueret drop column roworder


delete bcstkissueret where docno in (select docno from tempdb.dbo.bcstkissueret)
delete bcstkissretsub where docno in (select docno from tempdb.dbo.bcstkissueret)
delete bctrans where docno in (select docno from tempdb.dbo.bcstkissueret)
delete bctranssub where docno in (select docno from tempdb.dbo.bcstkissueret)



insert into bcstkissueret select * from tempdb.dbo.bcstkissueret
insert into bcstkissretsub select * from tempdb.dbo.bcstkissretsub
insert into bctrans select * from tempdb.dbo.bctrans_issueret
insert into bctranssub select * from tempdb.dbo.bctranssub_issueret

select top 1  * from tempdb.dbo.bcstkissretsub
select top 1 * from bcstkissretsub