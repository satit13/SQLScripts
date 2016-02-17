use bcvat
if exists(select name from tempdb.dbo.sysobjects where name = 'bcapinvoice_index_fix')
drop table tempdb.dbo.bcapinvoice_index_fix
if exists(select name from tempdb.dbo.sysobjects where name = 'bcapinvoice_fix')
drop table tempdb.dbo.bcapinvoice_fix

if exists(select name from tempdb.dbo.sysobjects where name = 'bcapinvoicesub_fix')
drop table tempdb.dbo.bcapinvoicesub_fix

if exists(select name from tempdb.dbo.sysobjects where name = 'bcirsub_fix')
drop table tempdb.dbo.bcirsub_fix
if exists(select name from tempdb.dbo.sysobjects where name = 'bcinputtax_fix')
drop table tempdb.dbo.bcinputtax_fix
if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans_fix')
drop table tempdb.dbo.bctrans_fix
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub_fix')
drop table tempdb.dbo.bctranssub_fix

if exists(select name from tempdb.dbo.sysobjects where name = 'bcapwtaxlist_fix')
drop table tempdb.dbo.bcapwtaxlist_fix


select docno into tempdb.dbo.bcapinvoice_index_fix from nebula.bcnp.dbo.bcapinvoice 
where --year(docdate)=2010
iscancel=0
and year(docdate)=2015 and (docno like '%IV%' or docno like '%IX%')
and docno not in (select docno from bcvat.dbo.bcapinvoice)
--and month(docdate)<10
--and docno not in (select docno from bcvat.dbo.bcapinvoice where year(docdate)=2010)

-- Gen index file 
select * into tempdb.dbo.bcapinvoice_fix
	 from nebula.bcnp.dbo.bcapinvoice 
 	 where docno in (select docno from tempdb.dbo.bcapinvoice_index_fix)


select * into tempdb.dbo.bcirsub_fix
	 from nebula.bcnp.dbo.bcirsub
 	 where docno in (select docno from tempdb.dbo.bcapinvoice_index_fix)

select * into tempdb.dbo.bcapinvoicesub_fix
	 from nebula.bcnp.dbo.bcapinvoicesub
 	 where docno in (select docno from tempdb.dbo.bcapinvoice_index_fix)


select * into tempdb.dbo.bcinputtax_fix
	 from nebula.bcnp.dbo.bcinputtax
 	 where docno in (select docno from tempdb.dbo.bcapinvoice_index_fix)

select * into tempdb.dbo.bctrans_fix
	 from nebula.bcnp.dbo.bctrans
 	 where docno in (select docno from tempdb.dbo.bcapinvoice_index_fix)

select * into tempdb.dbo.bctranssub_fix
	 from nebula.bcnp.dbo.bctranssub
 	 where docno in (select docno from tempdb.dbo.bcapinvoice_index_fix)

select * into tempdb.dbo.bcapwtaxlist_fix
	 from nebula.bcnp.dbo.bcapwtaxlist
 	 where docno in (select docno from tempdb.dbo.bcapinvoice_index_fix)

alter table tempdb.dbo.bcapinvoice_fix drop column roworder
alter table tempdb.dbo.bcapinvoicesub_fix drop column roworder
alter table tempdb.dbo.bcirsub_fix drop column roworder
alter table tempdb.dbo.bcinputtax_fix drop column roworder
alter table tempdb.dbo.bctrans_fix drop column roworder
alter table tempdb.dbo.bctranssub_fix drop column roworder
alter table tempdb.dbo.bcapwtaxlist_fix drop column roworder


delete bcvat.dbo.bcapinvoice where docno in (select docno from  tempdb.dbo.bcapinvoice_index_fix)
delete bcvat.dbo.bcapinvoicesub where docno in (select docno from  tempdb.dbo.bcapinvoice_index_fix)
delete bcvat.dbo.bcirsub where docno in (select docno from tempdb.dbo.bcapinvoice_index_fix)
delete bcvat.dbo.bcinputtax where docno in (select docno from tempdb.dbo.bcapinvoice_index_fix)
delete bcvat.dbo.bctrans where docno in (select docno from tempdb.dbo.bcapinvoice_index_fix)
delete bcvat.dbo.bctranssub where docno in (select docno from tempdb.dbo.bcapinvoice_index_fix)
delete bcvat.dbo.bcapwtaxlist where docno in (select docno from tempdb.dbo.bcapinvoice_index_fix)


insert into bcvat.dbo.bcapinvoice select * from tempdb.dbo.bcapinvoice_fix
insert into bcvat.dbo.bcapinvoicesub select * from tempdb.dbo.bcapinvoicesub_fix
insert into bcvat.dbo.bcirsub select * from tempdb.dbo.bcirsub_fix
insert into bcvat.dbo.bcinputtax select * from tempdb.dbo.bcinputtax_fix
insert into bcvat.dbo.bctrans select * from tempdb.dbo.bctrans_fix
insert into bcvat.dbo.bctranssub select * from tempdb.dbo.bctranssub_fix
insert into bcvat.dbo.bcapwtaxlist select * from tempdb.dbo.bcapwtaxlist_fix
go 