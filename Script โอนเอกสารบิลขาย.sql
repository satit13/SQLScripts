select docno
	into tempdb.dbo.bcarinvoice_index
	from nebula.bcnp.dbo.bcarinvoice 
	where month(docdate)=2 
	and year(docdate)=2009
	and docno not   like '%N%'





select * 
	into tempdb.dbo.bcarinvoice
	from nebula.bcnp.dbo.bcarinvoice
	where docno in (select docno from tempdb.dbo.bcarinvoice_index)

select * 
	into tempdb.dbo.bcrecmoney_arinvoice
	from nebula.bcnp.dbo.bcrecmoney
	where docno in (select docno from tempdb.dbo.bcarinvoice_index)

select * 
	into tempdb.dbo.bcarinvoicesub
	from nebula.bcnp.dbo.bcarinvoicesub
	where docno in (select docno from tempdb.dbo.bcarinvoice_index)

select * 
	into tempdb.dbo.bcoutputtax_arinvoice
	from nebula.bcnp.dbo.bcoutputtax
	where docno in (select docno from tempdb.dbo.bcarinvoice_index)
select * 
	into tempdb.dbo.bctrans_arinvoice
	from nebula.bcnp.dbo.bctrans
	where docno in (select docno from tempdb.dbo.bcarinvoice_index)
select * 
	into tempdb.dbo.bctranssub_arinvoice
	from nebula.bcnp.dbo.bctranssub
	where docno in (select docno from tempdb.dbo.bcarinvoice_index)




delete tempdb.dbo.bcarinvoicesub where docno in 
(
select docno from tempdb.dbo.bcarinvoice where iscancel=1 and docno like '%IC%'
)


delete tempdb.dbo.bcoutputtax where docno in 
(
select docno from tempdb.dbo.bcarinvoice where iscancel=1 and docno like '%IC%'
)

delete  tempdb.dbo.bctrans where docno in 
(
select docno from tempdb.dbo.bcarinvoice where iscancel=1 and docno like '%IC%'
)
delete  tempdb.dbo.bctranssub where docno in 
(
select docno from tempdb.dbo.bcarinvoice where iscancel=1 and docno like '%IC%'
)

delete  tempdb.dbo.bcarinvoice where docno in 
(
select docno from tempdb.dbo.bcarinvoice where iscancel=1 and docno like '%IC%'
)

delete  tempdb.dbo.bcrecmoney_arinvoice where docno in 
(
select docno from tempdb.dbo.bcarinvoice where iscancel=1 and docno like '%IC%'
)


alter table tempdb.dbo.bcarinvoice drop column roworder
alter table tempdb.dbo.bcarinvoicesub drop column roworder
alter table tempdb.dbo.bcoutputtax_arinvoice drop column roworder
alter table tempdb.dbo.bctrans_arinvoice drop column roworder
alter table tempdb.dbo.bctranssub_arinvoice drop column roworder
alter  table tempdb.dbo.bcrecmoney_arinvoice drop column roworder

delete bcarinvoice where docno in (select docno from tempdb.dbo.bcarinvoice)
delete bcarinvoicesub where docno in (select docno from tempdb.dbo.bcarinvoice)
delete bcoutputtax where docno in (select docno from tempdb.dbo.bcarinvoice)
delete bctrans where docno in (select docno from tempdb.dbo.bcarinvoice)
delete bctranssub where docno in (select docno from tempdb.dbo.bcarinvoice)
delete bcrecmoney where docno in (select docno from tempdb.dbo.bcarinvoice)

insert into bcarinvoice select * from tempdb.dbo.bcarinvoice
insert into bcarinvoicesub select * from tempdb.dbo.bcarinvoicesub
insert into bcoutputtax select * from tempdb.dbo.bcoutputtax_arinvoice
insert into bctrans select * from tempdb.dbo.bctrans_arinvoice
insert into bctranssub select * from tempdb.dbo.bctranssub_arinvoice
insert into bcrecmoney select * from tempdb.dbo.bcrecmoney_arinvoice