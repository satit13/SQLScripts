use bcvat
/*
bcardeposit
bcardepositsub
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


if exists(select name from tempdb.dbo.sysobjects where name = 'bcardeposit_index')
	drop table tempdb.dbo.bcardeposit_index
select docno into tempdb.dbo.bcardeposit_index  from  nebula.bcnp.dbo.bcardeposit
where year(docdate)=2009 and month(docdate)=2 
	and docno not like '%N%'



--select left(docno,7)  from tempdb.dbo.bcardeposit_index group by left(docno,7)
select * 
into tempdb.dbo.bcardeposit
from nebula.bcnp.dbo.bcardeposit where docno in (select docno from tempdb.dbo.bcardeposit_index)

select * 
into tempdb.dbo.bcardeposituse
from nebula.bcnp.dbo.bcardeposituse 
where depositno in (select docno from tempdb.dbo.bcardeposit)


select *  
into tempdb.dbo.bctrans_ardeposit
from nebula.bcnp.dbo.bctrans where docno in (select docno from tempdb.dbo.bcardeposit_index)

select *  
into tempdb.dbo.bctranssub_ardeposit
from nebula.bcnp.dbo.bctranssub where docno in (select docno from tempdb.dbo.bcardeposit_index)



select * 
into tempdb.dbo.bcrecmoney_ardeposit
from nebula.bcnp.dbo.bcrecmoney where docno in (select docno from tempdb.dbo.bcardeposit_index)






alter table tempdb.dbo.bcardeposit drop column roworder
alter table tempdb.dbo.bctrans_ardeposit drop column roworder
alter table tempdb.dbo.bctranssub_ardeposit drop column roworder
alter table tempdb.dbo.bcardeposituse drop column roworder


use bcvat
delete  bcardeposit where docno in (select docno from tempdb.dbo.bcardeposit_index)
delete  bcardeposituse where docno in (select docno from tempdb.dbo.bcardeposit_index)
delete  bctrans where docno in (select docno from tempdb.dbo.bcardeposit_index)
delete  bctranssub where docno in (select docno from tempdb.dbo.bcardeposit_index)


insert into bcardeposit select * from tempdb.dbo.bcardeposit
insert into bcardeposituse select * from tempdb.dbo.bcardeposituse
insert into bctrans select * from tempdb.dbo.bctrans_ardeposit
insert into bctranssub select * from tempdb.dbo.bctranssub_ardeposit


