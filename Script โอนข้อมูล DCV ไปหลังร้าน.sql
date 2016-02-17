drop table tempdb.dbo.bcdebitnote1
drop table tempdb.dbo.bcdebitnotesub1
drop table tempdb.dbo.bctrans_dcv
drop table  tempdb.dbo.bctranssub_dcv
drop table tempdb.dbo.bcoutputtax_dcv

select *  into tempdb.dbo.bcdebitnote1 from nebula.bcnp.dbo.bcdebitnote1 
	where year(docdate)=2011 and month(docdate) between 1 and 3  and docno like '%DCV%'
select *  into tempdb.dbo.bcdebitnotesub1 from nebula.bcnp.dbo.bcdebitnotesub1 
	where year(docdate)=2011 and month(docdate) between 1 and 3  and docno like '%DCV%'

select *  into tempdb.dbo.bctrans_dcv  from nebula.bcnp.dbo.bctrans  
	where year(docdate)=2011 and month(docdate) between 1 and 3  and docno like '%DCV%'
select *  into tempdb.dbo.bctranssub_dcv  from nebula.bcnp.dbo.bctranssub  
	where year(docdate)=2011 and month(docdate) between 1 and 3 and docno like '%DCV%'
select *  into tempdb.dbo.bcoutputtax_dcv from nebula.bcnp.dbo.bcoutputtax 
	where year(docdate)=2011 and month(docdate) between 1 and 3  and docno like '%DCV%'

select * from tempdb.dbo.bcdebitnote1

alter table tempdb.dbo.bcdebitnote1 drop column roworder 
alter table tempdb.dbo.bcdebitnotesub1 drop column roworder 
alter table tempdb.dbo.bctrans_dcv drop column roworder 
alter table tempdb.dbo.bctranssub_dcv drop column roworder 
alter table tempdb.dbo.bcoutputtax_dcv drop column roworder 


delete bcdebitnote1 where  year(docdate)=2011 and  month(docdate) between 1 and 3  
delete bcdebitnotesub1 where  year(docdate)=2011 and  month(docdate) between 1 and 3  
delete bctrans where   year(docdate)=2011 and  month(docdate) between 1 and 3   and docno like '%DCV%'
delete bctranssub  where  year(docdate)=2011 and  month(docdate) between 1 and 3    and docno like '%DCV%'
delete bcoutputtax where  year(docdate)=2011 and  month(docdate) between 1 and 3    and docno like '%DCV%'

insert into bcdebitnote1 select * from tempdb.dbo.bcdebitnote1 
insert into bcdebitnotesub1 select * from tempdb.dbo.bcdebitnotesub1 
insert into bctrans select * from tempdb.dbo.bctrans_dcv 
insert into bctranssub select * from tempdb.dbo.bctranssub_dcv
insert into bcoutputtax select * from tempdb.dbo.bcoutputtax_dcv 
