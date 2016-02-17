use bcvat
/*
bccreditnote
bccreditnotesub
bcinvcreditnote
bctrans
bctranssub


S01-RAB
S01-RCV
S01-RDM
S01-RHV
S01-RVD
S01-RVM
S01-RXT
W01-RCV
W01-RDV
W01-RVD

*/


if exists(select name from tempdb.dbo.sysobjects where name = 'bccreditnote_index')
	drop table tempdb.dbo.bccreditnote_index
select docno into tempdb.dbo.bccreditnote_index  from  nebula.bcnp.dbo.bccreditnote
where year(docdate)=2009 and month(docdate)=2 
	and docno not like '%N%'


select * 
into tempdb.dbo.bccreditnote
from nebula.bcnp.dbo.bccreditnote where docno in (select docno from tempdb.dbo.bccreditnote_index)

select * 
into tempdb.dbo.bccreditnotesub
from nebula.bcnp.dbo.bccreditnotesub where docno in (select docno from tempdb.dbo.bccreditnote_index)

select *  
into tempdb.dbo.bctrans_creditnote
from nebula.bcnp.dbo.bctrans where docno in (select docno from tempdb.dbo.bccreditnote_index)

select *  
into tempdb.dbo.bctranssub_creditnote
from nebula.bcnp.dbo.bctranssub where docno in (select docno from tempdb.dbo.bccreditnote_index)

select * 
into tempdb.dbo.bcinvcreditnote
from nebula.bcnp.dbo.bcinvcreditnote 
where creditnoteno in (select docno from tempdb.dbo.bccreditnote)


alter table tempdb.dbo.bccreditnote drop column roworder
alter table tempdb.dbo.bccreditnotesub drop column roworder
alter table tempdb.dbo.bctrans_creditnote drop column roworder
alter table tempdb.dbo.bctranssub_creditnote drop column roworder
alter table tempdb.dbo.bcinvcreditnote drop column roworder


use bcvat
delete  bccreditnote where docno in (select docno from tempdb.dbo.bccreditnote_index)
delete  bccreditnotesub where docno in (select docno from tempdb.dbo.bccreditnote_index)
delete  bctrans where docno in (select docno from tempdb.dbo.bccreditnote_index)
delete  bctranssub where docno in (select docno from tempdb.dbo.bccreditnote_index)
delete bcinvcreditnote where creditnoteno in (select docno from tempdb.dbo.bccreditnote_index)

insert into bccreditnote select * from tempdb.dbo.bccreditnote
insert into bccreditnotesub select * from tempdb.dbo.bccreditnotesub
insert into bctrans select * from tempdb.dbo.bctrans_creditnote
insert into bctranssub select * from tempdb.dbo.bctranssub_creditnote
insert into bcinvcreditnote select * from tempdb.dbo.bcinvcreditnote

