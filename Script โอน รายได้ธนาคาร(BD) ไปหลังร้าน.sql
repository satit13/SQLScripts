use bcvat
set dateformat dmy
if exists(select name from tempdb.dbo.sysobjects where name = 'BCBANKINCOME') 
	drop table tempdb.dbo.BCBANKINCOME
if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans') 
	drop table tempdb.dbo.bctrans
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub') 
	drop table tempdb.dbo.bctranssub
go 

select * into tempdb.dbo.BCBANKINCOME from nebula.bcnp.dbo.BCBANKINCOME
	where docdate between '01/06/2015' and '30/06/2015'
		and docno like '%BD%'
select * into tempdb.dbo.bctrans from nebula.bcnp.dbo.bctrans 
	where docno in (select docno from tempdb.dbo.BCBANKINCOME)
select * into tempdb.dbo.bctranssub from nebula.bcnp.dbo.bctranssub 
	where docno in (select docno from tempdb.dbo.BCBANKINCOME)
go 

alter table tempdb.dbo.BCBANKINCOME drop column roworder
alter table tempdb.dbo.bctrans drop column roworder
alter table tempdb.dbo.bctranssub drop column roworder
go 

delete BCBANKINCOME where docno in (select docno from tempdb.dbo.BCBANKINCOME)
delete bctrans where docno in (select docno from tempdb.dbo.BCBANKINCOME)
delete bctranssub where docno in (select docno from tempdb.dbo.BCBANKINCOME)
go 

insert into BCBANKINCOME select * from tempdb.dbo.BCBANKINCOME
insert into bctrans select * from tempdb.dbo.bctrans
insert into bctranssub select * from tempdb.dbo.bctranssub
GO 



