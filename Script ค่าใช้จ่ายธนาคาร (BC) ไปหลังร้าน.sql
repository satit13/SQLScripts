use bcvat
set dateformat dmy
if exists(select name from tempdb.dbo.sysobjects where name = 'BCBANKEXPENSE') 
	drop table tempdb.dbo.BCBANKEXPENSE
if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans_BCBANKEXPENSE') 
	drop table tempdb.dbo.bctrans_BCBANKEXPENSE
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub_BCBANKEXPENSE') 
	drop table tempdb.dbo.bctranssub_BCBANKEXPENSE
go 

select * into tempdb.dbo.BCBANKEXPENSE from nebula.bcnp.dbo.BCBANKEXPENSE
	where docdate between '01/01/2015' and '31/12/2015'
		and docno like '%OT%'
select * into tempdb.dbo.bctrans_BCBANKEXPENSE from nebula.bcnp.dbo.bctrans 
	where docno in (select docno from tempdb.dbo.BCBANKEXPENSE)
select * into tempdb.dbo.bctranssub_BCBANKEXPENSE from nebula.bcnp.dbo.bctranssub 
	where docno in (select docno from tempdb.dbo.BCBANKEXPENSE)
go 

alter table tempdb.dbo.BCBANKEXPENSE drop column roworder
alter table tempdb.dbo.bctrans_BCBANKEXPENSE drop column roworder
alter table tempdb.dbo.bctranssub_BCBANKEXPENSE drop column roworder
go 

delete BCBANKEXPENSE where docno in (select docno from tempdb.dbo.BCBANKEXPENSE)
delete bctrans where docno in (select docno from tempdb.dbo.BCBANKEXPENSE)
delete bctranssub where docno in (select docno from tempdb.dbo.BCBANKEXPENSE)
go 

insert into BCBANKEXPENSE select * from tempdb.dbo.BCBANKEXPENSE
insert into bctrans select * from tempdb.dbo.bctrans_BCBANKEXPENSE
insert into bctranssub select * from tempdb.dbo.bctranssub_BCBANKEXPENSE
GO 


