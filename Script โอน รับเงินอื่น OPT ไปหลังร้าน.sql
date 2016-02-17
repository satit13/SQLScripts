use bcvat
set dateformat dmy
if exists(select name from tempdb.dbo.sysobjects where name = 'bcotherincome') 
	drop table tempdb.dbo.bcotherincome
if exists(select name from tempdb.dbo.sysobjects where name = 'bcrecmoney') 
	drop table tempdb.dbo.bcrecmoney
if exists(select name from tempdb.dbo.sysobjects where name = 'bcoutputtax') 
	drop table tempdb.dbo.bcoutputtax

if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans_otherincome') 
	drop table tempdb.dbo.bctrans_otherincome
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub_otherincome') 
	drop table tempdb.dbo.bctranssub_otherincome
go 

select * into tempdb.dbo.bcotherincome from nebula.bcnp.dbo.bcotherincome
	where docdate between '01/01/2015' and '31/12/2015'
		and (docno like '%OPT%' )
select * into tempdb.dbo.bcrecmoney from nebula.bcnp.dbo.bcrecmoney 
	where docno in (select docno from tempdb.dbo.bcotherincome)
select * into tempdb.dbo.bcoutputtax from nebula.bcnp.dbo.bcoutputtax 
	where docno in (select docno from tempdb.dbo.bcotherincome)
select * into tempdb.dbo.bctrans_otherincome from nebula.bcnp.dbo.bctrans 
	where docno in (select docno from tempdb.dbo.bcotherincome)
select * into tempdb.dbo.bctranssub_otherincome from nebula.bcnp.dbo.bctranssub 
	where docno in (select docno from tempdb.dbo.bcotherincome)
go 

alter table tempdb.dbo.bcotherincome drop column roworder
alter table tempdb.dbo.bcrecmoney drop column roworder
alter table tempdb.dbo.bcoutputtax drop column roworder
alter table tempdb.dbo.bctrans_otherincome drop column roworder
alter table tempdb.dbo.bctranssub_otherincome drop column roworder
go 

delete bcotherincome where docno in (select docno from tempdb.dbo.bcotherincome)
delete bcrecmoney where docno in (select docno from tempdb.dbo.bcotherincome)
delete bcoutputtax where docno in (select docno from tempdb.dbo.bcoutputtax)
delete bctrans where docno in (select docno from tempdb.dbo.bcotherincome)
delete bctranssub where docno in (select docno from tempdb.dbo.bcotherincome)
go 

insert into bcotherincome select * from tempdb.dbo.bcotherincome
insert into bcrecmoney select * from tempdb.dbo.bcrecmoney
insert into bctrans select * from tempdb.dbo.bctrans_otherincome
insert into bctranssub select * from tempdb.dbo.bctranssub_otherincome
GO 


