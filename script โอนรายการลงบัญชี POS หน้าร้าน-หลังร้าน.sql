use bcvat
select * 
into tempdb.dbo.bctrans_pos
from nebula.bcnp.dbo.bctrans
 where Source=-1 and year(docdate)=2009 and month(docdate)=2



select * 
into tempdb.dbo.bctranssub_pos
from nebula.bcnp.dbo.bctranssub
 where Source=-1 and year(docdate)=2009 and month(docdate)=2



alter table tempdb.dbo.bctrans_pos drop column roworder
alter table tempdb.dbo.bctranssub_pos  drop column roworder


delete bctrans where docno in (select docno from tempdb.dbo.bctrans_pos)
delete bctranssub where docno in (select docno from tempdb.dbo.bctrans_pos)


insert into bctrans select * from tempdb.dbo.bctrans
insert into bctrans select * from tempdb.dbo.bctranssub