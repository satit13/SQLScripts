use bcvat
set dateformat dmy
if exists(select name from tempdb.dbo.sysobjects where name = 'BCOTHEREXPENSE') 
	drop table tempdb.dbo.BCOTHEREXPENSE
if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans_BCOTHEREXPENSE') 
	drop table tempdb.dbo.bctrans_BCOTHEREXPENSE
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub_BCOTHEREXPENSE') 
	drop table tempdb.dbo.bctranssub_BCOTHEREXPENSE
go 

select * into tempdb.dbo.BCOTHEREXPENSE from nebula.bcnp.dbo.BCOTHEREXPENSE
	where docdate between '01/01/2015' and '31/12/2015'
		and docno like '%OT%'
select * into tempdb.dbo.bctrans_BCOTHEREXPENSE from nebula.bcnp.dbo.bctrans 
	where docno in (select docno from tempdb.dbo.BCOTHEREXPENSE)
select * into tempdb.dbo.bctranssub_BCOTHEREXPENSE from nebula.bcnp.dbo.bctranssub 
	where docno in (select docno from tempdb.dbo.BCOTHEREXPENSE)
go 

alter table tempdb.dbo.BCOTHEREXPENSE drop column roworder
alter table tempdb.dbo.bctrans_BCOTHEREXPENSE drop column roworder
alter table tempdb.dbo.bctranssub_BCOTHEREXPENSE drop column roworder
go 

delete BCOTHEREXPENSE where docno in (select docno from tempdb.dbo.BCOTHEREXPENSE)
delete bctrans where docno in (select docno from tempdb.dbo.BCOTHEREXPENSE)
delete bctranssub where docno in (select docno from tempdb.dbo.BCOTHEREXPENSE)
go 

insert into BCOTHEREXPENSE select * from tempdb.dbo.BCOTHEREXPENSE
insert into bctrans select * from tempdb.dbo.bctrans_BCOTHEREXPENSE
insert into bctranssub select * from tempdb.dbo.bctranssub_BCOTHEREXPENSE
GO 


