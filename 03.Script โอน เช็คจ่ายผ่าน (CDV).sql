use bcvat
set dateformat dmy
if exists(select name from tempdb.dbo.sysobjects where name = 'bcchqoutpass') 
	drop table tempdb.dbo.bcchqoutpass
if exists(select name from tempdb.dbo.sysobjects where name = 'bcchqoutpasssub') 
	drop table tempdb.dbo.bcchqoutpasssub
if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans_chqoutpass') 
	drop table tempdb.dbo.bctrans_chqoutpass
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub_chqoutpass') 
	drop table tempdb.dbo.bctranssub_chqoutpass
go 
set dateformat dmy
select * into tempdb.dbo.bcchqoutpass from nebula.bcnp.dbo.bcchqoutpass
	where docdate between '01/06/2015' and '30/06/2015'
		and  docno like '%CDV%'
select * into tempdb.dbo.bcchqoutpasssub from nebula.bcnp.dbo.bcchqoutpasssub 
	where docno in (select docno from tempdb.dbo.bcchqoutpass)
select * into tempdb.dbo.bctrans_chqoutpass from nebula.bcnp.dbo.bctrans 
	where docno in (select docno from tempdb.dbo.bcchqoutpass)
select * into tempdb.dbo.bctranssub_chqoutpass from nebula.bcnp.dbo.bctranssub 
	where docno in (select docno from tempdb.dbo.bcchqoutpass)
go 

alter table tempdb.dbo.bcchqoutpass drop column roworder
alter table tempdb.dbo.bcchqoutpasssub drop column roworder
alter table tempdb.dbo.bctrans_chqoutpass drop column roworder
alter table tempdb.dbo.bctranssub_chqoutpass drop column roworder
go 


delete bcchqoutpass where docno in (select docno from tempdb.dbo.bcchqoutpass)
delete bcchqoutpasssub where docno in (select docno from tempdb.dbo.bcchqoutpass)
delete bctrans where docno in (select docno from tempdb.dbo.bcchqoutpass)
delete bctranssub where docno in (select docno from tempdb.dbo.bcchqoutpass)
go 

insert into bcchqoutpass select * from tempdb.dbo.bcchqoutpass
insert into bcchqoutpasssub select * from tempdb.dbo.bcchqoutpasssub
insert into bctrans select * from tempdb.dbo.bctrans_chqoutpass
insert into bctranssub select * from tempdb.dbo.bctranssub_chqoutpass
GO 



