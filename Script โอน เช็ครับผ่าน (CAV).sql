use bcvat
set dateformat dmy
if exists(select name from tempdb.dbo.sysobjects where name = 'BCCHQINpass') 
	drop table tempdb.dbo.bcchqinpass
if exists(select name from tempdb.dbo.sysobjects where name = 'BCCHQINpasssub') 
	drop table tempdb.dbo.bcchqinpasssub
if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans_chqinpass') 
	drop table tempdb.dbo.bctrans_chqinpass
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub_chqinpass') 
	drop table tempdb.dbo.bctranssub_chqinpass
go 
set dateformat dmy
select * into tempdb.dbo.bcchqinpass from nebula.bcnp.dbo.bcchqinpass
	where docdate between '01/01/2015' and '31/12/2015'
		and  docno like '%CAV%'
select * into tempdb.dbo.bcchqinpasssub from nebula.bcnp.dbo.bcchqinpasssub 
	where docno in (select docno from tempdb.dbo.bcchqinpass)
select * into tempdb.dbo.bctrans_chqinpass from nebula.bcnp.dbo.bctrans 
	where docno in (select docno from tempdb.dbo.bcchqinpass)
select * into tempdb.dbo.bctranssub_chqinpass from nebula.bcnp.dbo.bctranssub 
	where docno in (select docno from tempdb.dbo.bcchqinpass)
go 

alter table tempdb.dbo.bcchqinpass drop column roworder
alter table tempdb.dbo.bcchqinpasssub drop column roworder
alter table tempdb.dbo.bctrans_chqinpass drop column roworder
alter table tempdb.dbo.bctranssub_chqinpass drop column roworder
go 

delete bcchqinpass where docno in (select docno from tempdb.dbo.bcchqinpass)
delete bcchqinpasssub where docno in (select docno from tempdb.dbo.bcchqinpass)
delete bctrans where docno in (select docno from tempdb.dbo.bcchqinpass)
delete bctranssub where docno in (select docno from tempdb.dbo.bcchqinpass)
go 

insert into bcchqinpass select * from tempdb.dbo.bcchqinpass
insert into bcchqinpasssub select * from tempdb.dbo.bcchqinpasssub
insert into bctrans select * from tempdb.dbo.bctrans_chqinpass
insert into bctranssub select * from tempdb.dbo.bctranssub_chqinpass
GO 

select * into tempdb.dbo.bcchqin_front from nebula.bcnp.dbo.bcchqin 


select * from bcchqinpasssub where docno in (select docno from tempdb.dbo.bcchqinpass)
update bcchqinpasssub  set chqroworder=
	(	select top 1 roworder from bcchqin where ChqNumber = bcchqinpasssub.ChqNumber )
 where docno in (select docno from tempdb.dbo.bcchqinpass)





