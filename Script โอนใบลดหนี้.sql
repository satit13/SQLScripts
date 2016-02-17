
select * into tempdb.dbo.bccreditnote_rxt  from nebula.bcnp.dbo.bccreditnote where  docno like '%RXT%' and month(docdate)=3 and year(docdate)=2009
select * into tempdb.dbo.bccreditnotesub_rxt   from nebula.bcnp.dbo.bccreditnotesub  where  docno like '%RXT%' and month(docdate)=3 and year(docdate)=2009
select * into tempdb.dbo.bctrans_rxt from   nebula.bcnp.dbo.bctrans    where docno like '%RXT%' and month(docdate)=3 and year(docdate)=2009
select * into tempdb.dbo.bctranssub_rxt from nebula.bcnp.dbo.bctranssub   where docno like '%RXT%' and month(docdate)=3 and year(docdate)=2009
select * into tempdb.dbo.bcinvcreditnote_rxt from nebula.bcnp.dbo.bcinvcreditnote where creditnoteno  like  '%RXT%' and creditnoteno in (select docno from bccreditnote where  docno like '%RXT%' and month(docdate)=3 and year(docdate)=2009)



alter table  tempdb.dbo.bccreditnote_rxt drop column roworder 
alter table  tempdb.dbo.bccreditnotesub_rxt drop column roworder 
alter table  tempdb.dbo.bctrans_rxt drop column roworder 
alter table  tempdb.dbo.bctranssub_rxt drop column roworder 



delete bccreditnote where  docno in (select docno from tempdb.dbo.bccreditnote_rxt)
delete bccreditnotesub where docno in (select docno from tempdb.dbo.bccreditnote_rxt)
delete bctrans where docno in (select docno from tempdb.dbo.bccreditnote_rxt)
delete bctranssub where docno in (select docno from tempdb.dbo.bccreditnote_rxt)


insert into bccreditnote  select * from tempdb.dbo.bccreditnote_rxt
insert into bccreditnotesub  select * from tempdb.dbo.bccreditnotesub_rxt
insert into bctrans  select * from tempdb.dbo.bctrans_rxt
insert into bctranssub  select * from tempdb.dbo.bctranssub_rxt