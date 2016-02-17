--รบกวนโอนข้อมูล AV AT ORT เดือน 3/53 ให้ด้วยค่ะ
use bcvat


if exists(select name from tempdb.dbo.sysobjects where name = 'bcapotherdebt')
	drop table tempdb.dbo.bcapotherdebt
select docno
 into tempdb.dbo.bcapotherdebt
 from nebula.bcnp.dbo.bcapotherdebt 
 where left(docno,2) in('AV','AT') and year(docdate)=2014 --



if exists(select name from tempdb.dbo.sysobjects where name = 'bcinputtax')
	drop table tempdb.dbo.bcinputtax
select  * 
into tempdb.dbo.bcinputtax
from nebula.bcnp.dbo.bcinputtax where docno in 
	(select docno from tempdb.dbo.bcapotherdebt)

if exists(select name from tempdb.dbo.sysobjects where name = 'bcapotherdept')
	drop table tempdb.dbo.bcapotherdept
select * 
into tempdb.dbo.bcapotherdept
from nebula.bcnp.dbo.bcapotherdebt where docno in 
	(select docno from tempdb.dbo.bcapotherdebt)


if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans')
	drop table tempdb.dbo.bctrans
select * 
into tempdb.dbo.bctrans
from nebula.bcnp.dbo.bctrans where docno in 
	(select docno from tempdb.dbo.bcapotherdebt)

if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub')
	drop table tempdb.dbo.bctranssub
select * 
into tempdb.dbo.bctranssub
from nebula.bcnp.dbo.bctranssub where docno in 
	(select docno from tempdb.dbo.bcapotherdebt)

if exists(select name from tempdb.dbo.sysobjects where name = 'bcapwtaxlist')
	drop table tempdb.dbo.bcapwtaxlist
select * 
into tempdb.dbo.bcapwtaxlist
from nebula.bcnp.dbo.bcapwtaxlist where docno in 
	(select docno from tempdb.dbo.bcapotherdebt)

/*
if exists(select name from tempdb.dbo.sysobjects where name = 'bcinputtax_of')
	drop table tempdb.dbo.bcinputtax_of
select * 
into tempdb.dbo.bcinputtax_of
from nebula.bcnp.dbo.bcinputtax 
	where docno like  '%OF%' and  year(docdate)=2010

*/

alter table tempdb.dbo.bcinputtax drop column roworder
alter table tempdb.dbo.bcapotherdept drop column roworder
alter table tempdb.dbo.bctrans drop column roworder
alter table tempdb.dbo.bctranssub drop column roworder
alter table tempdb.dbo.bcapwtaxlist drop column roworder

--alter table tempdb.dbo.bcinputtax_of drop column roworder


delete bcinputtax where docno in (select docno from tempdb.dbo.bcinputtax)
delete bcapotherdebt where docno in (select docno from tempdb.dbo.bcapotherdept)
delete bctrans where docno in (select docno from tempdb.dbo.bctrans)
delete bctranssub where docno in (select docno from tempdb.dbo.bctranssub)
delete bcapwtaxlist where docno in (select docno from tempdb.dbo.bcapotherdept)
--delete bcvat.dbo.bcinputtax where docno in (select docno from tempdb.dbo.bcinputtax_of)





insert into bcinputtax select * from tempdb.dbo.bcinputtax
insert into bcapotherdebt select * from tempdb.dbo.bcapotherdept
insert into bctrans select * from tempdb.dbo.bctrans
insert into bctranssub select * from tempdb.dbo.bctranssub
insert into bcapwtaxlist select * from tempdb.dbo.bcapwtaxlist

--insert into bcinputtax select * from tempdb.dbo.bcinputtax_of


