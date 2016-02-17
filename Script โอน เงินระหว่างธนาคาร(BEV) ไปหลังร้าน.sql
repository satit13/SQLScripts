use bcvat
set dateformat dmy
if exists(select name from tempdb.dbo.sysobjects where name = 'BCBANKTRANSFER') 
	drop table tempdb.dbo.BCBANKTRANSFER
if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans') 
	drop table tempdb.dbo.bctrans
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub') 
	drop table tempdb.dbo.bctranssub
go 

select * into tempdb.dbo.BCBANKTRANSFER from nebula.bcnp.dbo.BCBANKTRANSFER
	where docdate between '01/06/2015' and '30/06/2015'
		and docno like '%BEV%'
select * into tempdb.dbo.bctrans from nebula.bcnp.dbo.bctrans 
	where docno in (select docno from tempdb.dbo.BCBANKTRANSFER)
select * into tempdb.dbo.bctranssub from nebula.bcnp.dbo.bctranssub 
	where docno in (select docno from tempdb.dbo.BCBANKTRANSFER)
go 

alter table tempdb.dbo.BCBANKTRANSFER drop column roworder
alter table tempdb.dbo.bctrans drop column roworder
alter table tempdb.dbo.bctranssub drop column roworder
go 

delete BCBANKTRANSFER where docno in (select docno from tempdb.dbo.BCBANKTRANSFER)
delete bctrans where docno in (select docno from tempdb.dbo.BCBANKTRANSFER)
delete bctranssub where docno in (select docno from tempdb.dbo.BCBANKTRANSFER)
go 

insert into BCBANKTRANSFER select * from tempdb.dbo.BCBANKTRANSFER
insert into bctrans select * from tempdb.dbo.bctrans
insert into bctranssub select * from tempdb.dbo.bctranssub
GO 

