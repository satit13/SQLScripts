use bcvat
set dateformat dmy
if exists(select name from tempdb.dbo.sysobjects where name = 'bcchqinreturn') 
	drop table tempdb.dbo.bcchqinreturn
if exists(select name from tempdb.dbo.sysobjects where name = 'bcchqinretsub') 
	drop table tempdb.dbo.bcchqinretsub
if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans_chqinret') 
	drop table tempdb.dbo.bctrans_chqinret
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub_chqinret') 
	drop table tempdb.dbo.bctranssub_chqinrets
go 

select * into tempdb.dbo.bcchqinreturn from nebula.bcnp.dbo.bcchqinreturn
	where docdate between '01/01/2015' and '31/12/2015' and docno like '%CRV%'
select * into tempdb.dbo.bcchqinretsub from nebula.bcnp.dbo.bcchqinretsub 
	where docno in (select docno from tempdb.dbo.bcchqinreturn)
select * into tempdb.dbo.bctrans_chqinret from nebula.bcnp.dbo.bctrans 
	where docno in (select docno from tempdb.dbo.bcchqinreturn)
select * into tempdb.dbo.bctranssub_chqinret from nebula.bcnp.dbo.bctranssub 
	where docno in (select docno from tempdb.dbo.bcchqinreturn)
go 

alter table tempdb.dbo.bcchqinreturn drop column roworder
alter table tempdb.dbo.bcchqinretsub drop column roworder
alter table tempdb.dbo.bctrans_chqinret drop column roworder
alter table tempdb.dbo.bctranssub_chqinret drop column roworder
go 

delete bcchqinreturn where docno in (select docno from tempdb.dbo.bcchqinreturn)
delete bcchqinretsub where docno in (select docno from tempdb.dbo.bcchqinreturn)
delete bctrans where docno in (select docno from tempdb.dbo.bcchqinreturn)
delete bctranssub where docno in (select docno from tempdb.dbo.bcchqinreturn)
go 

insert into bcchqinreturn select * from tempdb.dbo.bcchqinreturn
insert into bcchqinretsub select * from tempdb.dbo.bcchqinretsub
insert into bctrans select * from tempdb.dbo.bctrans_chqinret
insert into bctranssub select * from tempdb.dbo.bctranssub_chqinret
GO 



