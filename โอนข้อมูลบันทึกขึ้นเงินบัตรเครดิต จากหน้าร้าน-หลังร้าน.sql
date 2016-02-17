set dateformat dmy
use bcvat
set dateformat dmy
if exists(select name from tempdb.dbo.sysobjects where name = 'BCCREDITPASS')
	drop table tempdb.dbo.bccreditpass
if exists(select name from tempdb.dbo.sysobjects where  name = 'BCCREDITPASSSUB')
	drop table tempdb.dbo.bccreditpasssub

if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans')
	drop table tempdb.dbo.bctrans
if exists(select name from tempdb.dbo.sysobjects where  name = 'bctranssub')
	drop table tempdb.dbo.bctranssub
set dateformat dmy
go
set dateformat  dmy
select *
	into tempdb.dbo.bccreditpass 
	from nebula.bcnp.dbo.BCCREDITPASS 
	where docdate between '01/11/2014' and '30/11/2014'


select *
	into tempdb.dbo.bccreditpasssub 
	from nebula.bcnp.dbo.BCCREDITPASSsub 
	where docno in (select docno from tempdb.dbo.bccreditpass)


select * 
	into tempdb.dbo.bctrans
	from nebula.bcnp.dbo.bctrans 
	where docno in (select docno from tempdb.dbo.bccreditpass)

select * 
	into tempdb.dbo.bctranssub
	from nebula.bcnp.dbo.bctranssub
	where docno in (select docno from tempdb.dbo.bccreditpass)

go
alter table tempdb.dbo.bccreditpass drop column roworder
alter table tempdb.dbo.bccreditpasssub drop column roworder
alter table tempdb.dbo.bctrans drop column roworder
alter table tempdb.dbo.bctranssub drop column roworder
go

delete bccreditpass where docno in (select docno from tempdb.dbo.bccreditpass)
delete bccreditpasssub where docno in (select docno from tempdb.dbo.bccreditpass)
delete bctrans where docno in (select docno from tempdb.dbo.bccreditpass)
delete bctranssub where docno in (select docno from tempdb.dbo.bccreditpass)
go

insert bccreditpass select * from tempdb.dbo.bccreditpass
insert bccreditpasssub select * from tempdb.dbo.bccreditpasssub
insert bctrans select * from tempdb.dbo.bctrans
insert bctranssub select * from tempdb.dbo.bctranssub
go

--select * from bctrans where docno in (select docno from tempdb.dbo.bctrans)



--select * from tempdb.dbo.bctrans where docno in (select docno from bctrans)

