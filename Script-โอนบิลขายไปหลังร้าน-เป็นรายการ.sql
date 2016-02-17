drop table tempdb.dbo.bcarinvoice_xx
drop table tempdb.dbo.bcarinvoicesub_xx
drop table tempdb.dbo.bcrecmoney_xx
drop table tempdb.dbo.bccreditcard_xx
drop table tempdb.dbo.bctrans_xx
drop table tempdb.dbo.bctranssub_xx
drop table tempdb.dbo.bcoutputtax_xx


select * into tempdb.dbo.bcarinvoice_xx from nebula.bcnp.dbo.bcarinvoice where docno in ('W01-ICV5302-2473')
select * into tempdb.dbo.bcarinvoicesub_xx  from nebula.bcnp.dbo.bcarinvoicesub where docno in ('W01-ICV5302-2473')
select * into tempdb.dbo.bcrecmoney_xx  from nebula.bcnp.dbo.bcrecmoney where docno in ('W01-ICV5302-2473')
select * into tempdb.dbo.bccreditcard_xx  from nebula.bcnp.dbo.bccreditcard where docno in ('W01-ICV5302-2473')
select * into tempdb.dbo.bctrans_xx  from nebula.bcnp.dbo.bctrans where docno in ('W01-ICV5302-2473')
select * into tempdb.dbo.bctranssub_xx  from nebula.bcnp.dbo.bctranssub where docno in ('W01-ICV5302-2473')
select * into tempdb.dbo.bcoutputtax_xx  from nebula.bcnp.dbo.bcoutputtax where docno in ('W01-ICV5302-2473')


ALTER table tempdb.dbo.bcarinvoice_xx drop column roworder
ALTER table tempdb.dbo.bcarinvoicesub_xx drop column roworder
ALTER table tempdb.dbo.bcrecmoney_xx drop column roworder
ALTER table tempdb.dbo.bccreditcard_xx drop column roworder
ALTER table tempdb.dbo.bctrans_xx drop column roworder
ALTER table tempdb.dbo.bctranssub_xx drop column roworder
ALTER table tempdb.dbo.bcoutputtax_xx drop column roworder

delete bcarinvoice where docno in (select docno from  tempdb.dbo.bcarinvoice_xx)
delete bcarinvoicesub where docno in (select docno  from tempdb.dbo.bcarinvoice_xx)
delete bcrecmoney where docno in (select docno  from tempdb.dbo.bcarinvoice_xx)
delete bccreditcard where docno in (select docno  from tempdb.dbo.bcarinvoice_xx)
delete bctrans where docno in (select docno  from tempdb.dbo.bcarinvoice_xx)
delete bctranssub where docno in (select docno  from tempdb.dbo.bcarinvoice_xx)
delete bcoutputtax where docno in (select docno  from tempdb.dbo.bcarinvoice_xx)

insert into bcarinvoice select * from tempdb.dbo.bcarinvoice_xx
insert into bcarinvoicesub select * from tempdb.dbo.bcarinvoicesub_xx
insert into bcrecmoney select * from tempdb.dbo.bcrecmoney_xx
insert into bccreditcard select * from tempdb.dbo.bccreditcard_xx
insert into bctrans select * from tempdb.dbo.bctrans_xx
insert into bctranssub select * from tempdb.dbo.bctranssub_xx
insert into bcoutputtax select * from tempdb.dbo.bcoutputtax_xx