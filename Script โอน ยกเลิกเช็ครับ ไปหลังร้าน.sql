use bcvat
set dateformat dmy
if exists(select name from tempdb.dbo.sysobjects where name = 'bcchqincancel') 
	drop table tempdb.dbo.bcchqincancel
if exists(select name from tempdb.dbo.sysobjects where name = 'bcchqincancelsub') 
	drop table tempdb.dbo.bcchqincancelsub
if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans_chqincc') 
	drop table tempdb.dbo.bctrans_chqincc
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub_chqincc') 
	drop table tempdb.dbo.bctranssub_chqincc
go 

select * into tempdb.dbo.bcchqincancel 
	from nebula.bcnp.dbo.bcchqincancel
	where docdate between '01/10/2012' and '31/12/2012' and isnull(bookno,'') <> '253-3-04147-7'
		--and  docno like '%CIV%'
select * into tempdb.dbo.bcchqincancelsub from nebula.bcnp.dbo.bcchqincancelsub 
	where docno in (select docno from tempdb.dbo.bcchqincancel)
select * into tempdb.dbo.bctrans_chqincc from nebula.bcnp.dbo.bctrans 
	where docno in (select docno from tempdb.dbo.bcchqincancel)
select * into tempdb.dbo.bctranssub_chqincc from nebula.bcnp.dbo.bctranssub 
	where docno in (select docno from tempdb.dbo.bcchqincancel)
go 

alter table tempdb.dbo.bcchqincancel drop column roworder
alter table tempdb.dbo.bcchqincancelsub drop column roworder
alter table tempdb.dbo.bctrans_chqincc drop column roworder
alter table tempdb.dbo.bctranssub_chqincc drop column roworder
go 

delete bcchqincancel where docno in (select docno from tempdb.dbo.bcchqincancel)
delete bcchqincancelsub where docno in (select docno from tempdb.dbo.bcchqincancel)
delete bctrans where docno in (select docno from tempdb.dbo.bcchqincancel)
delete bctranssub where docno in (select docno from tempdb.dbo.bcchqincancel)
go 

insert into bcchqincancel select * from tempdb.dbo.bcchqincancel
insert into bcchqincancelsub select * from tempdb.dbo.bcchqincancelsub
insert into bctrans select * from tempdb.dbo.bctrans_chqincc
insert into bctranssub select * from tempdb.dbo.bctranssub_chqincc
GO 



