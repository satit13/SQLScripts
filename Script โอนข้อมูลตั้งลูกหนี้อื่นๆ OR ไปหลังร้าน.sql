--รบกวนโอนข้อมูล AV AT ORT เดือน 3/53 ให้ด้วยค่ะ
use bcvat


if exists(select name from tempdb.dbo.sysobjects where name = 'bcarotherdebt_key')
	drop table tempdb.dbo.bcarotherdebt_key
select docno
 into tempdb.dbo.bcarotherdebt_key
 from nebula.bcnp.dbo.bcarotherdebt 
 where docno like '%OR%' and year(docdate)=2015
GO 


if exists(select name from tempdb.dbo.sysobjects where name = 'bcarotherdebt')
	drop table tempdb.dbo.bcarotherdebt
select *
 into tempdb.dbo.bcarotherdebt
 from nebula.bcnp.dbo.bcarotherdebt 
 where docno  in (select docno from tempdb.dbo.bcarotherdebt_key)
GO 



if exists(select name from tempdb.dbo.sysobjects where name = 'bcoutputtax')
	drop table tempdb.dbo.bcoutputtax
select  * 
into tempdb.dbo.bcoutputtax
from nebula.bcnp.dbo.bcoutputtax where docno in 
	(select docno from tempdb.dbo.bcarotherdebt_key)


if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans')
	drop table tempdb.dbo.bctrans
select * 
into tempdb.dbo.bctrans
from nebula.bcnp.dbo.bctrans where docno in 
	(select docno from tempdb.dbo.bcarotherdebt_key)

if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub')
	drop table tempdb.dbo.bctranssub
select * 
into tempdb.dbo.bctranssub
from nebula.bcnp.dbo.bctranssub where docno in 
	(select docno from tempdb.dbo.bcarotherdebt_key)

if exists(select name from tempdb.dbo.sysobjects where name = 'bcarwtaxlist')
	drop table tempdb.dbo.bcarwtaxlist
select * 
into tempdb.dbo.bcarwtaxlist
from nebula.bcnp.dbo.bcapwtaxlist where docno in 
	(select docno from tempdb.dbo.bcarotherdebt_key)



alter table tempdb.dbo.bcoutputtax drop column roworder
alter table tempdb.dbo.bcarotherdebt drop column roworder
alter table tempdb.dbo.bctrans drop column roworder
alter table tempdb.dbo.bctranssub drop column roworder
alter table tempdb.dbo.bcarwtaxlist drop column roworder

--alter table tempdb.dbo.bcoutputtax_of drop column roworder


delete bcoutputtax where docno in (select docno from tempdb.dbo.bcoutputtax)
delete bcarotherdebt where docno in (select docno from tempdb.dbo.bcarotherdebt)
delete bctrans where docno in (select docno from tempdb.dbo.bctrans)
delete bctranssub where docno in (select docno from tempdb.dbo.bctranssub)
delete bcarwtaxlist where docno in (select docno from tempdb.dbo.bcarotherdebt)
--delete bcvat.dbo.bcoutputtax where docno in (select docno from tempdb.dbo.bcoutputtax_of)





insert into bcoutputtax select * from tempdb.dbo.bcoutputtax
insert into bcarotherdebt select * from tempdb.dbo.bcarotherdebt
insert into bctrans select * from tempdb.dbo.bctrans
insert into bctranssub select * from tempdb.dbo.bctranssub
insert into bcarwtaxlist select * from tempdb.dbo.bcarwtaxlist

--insert into bcoutputtax select * from tempdb.dbo.bcoutputtax_of


