--หัวเอกสาร RTE ปี 54 โอนไป npvat54'

use bcvat
drop table tempdb.dbo.depretkey 
drop table tempdb.dbo.BCReturnDepSpecial 
drop table tempdb.dbo.BCPAYMONEY 
drop table tempdb.dbo.bctrans 
drop table tempdb.dbo.bctranssub 
GO 
-- 

select docno into tempdb.dbo.depretkey from nebula.bcnp.dbo.BCReturnDepSpecial where docno like '%RTE%'
and year(docdate)=2015
GO 

select * into tempdb.dbo.BCReturnDepSpecial
 from nebula.bcnp.dbo.bcreturndepspecial where docno in (select docno from tempdb.dbo.depretkey)

select * into tempdb.dbo.BCPAYMONEY
 from nebula.bcnp.dbo.bcpaymoney where docno in (select docno from tempdb.dbo.depretkey)

select * into tempdb.dbo.bctrans
 from nebula.bcnp.dbo.bctrans where docno in (select docno from tempdb.dbo.depretkey)

select * into tempdb.dbo.bctranssub
 from nebula.bcnp.dbo.bctranssub where docno in (select docno from tempdb.dbo.depretkey)

GO 
alter table tempdb.dbo.BCReturnDepSpecial drop column roworder
alter table tempdb.dbo.BCPAYMONEY drop column roworder
alter table tempdb.dbo.bctrans drop column roworder
alter table tempdb.dbo.bctranssub drop column roworder
GO 

delete BCReturnDepSpecial where docno in (select docno from tempdb.dbo.depretkey)
delete bctrans where docno in (select docno from tempdb.dbo.depretkey)
delete bctranssub where docno in (select docno from tempdb.dbo.depretkey)
delete bcpaymoney where docno in (select docno from tempdb.dbo.depretkey)
GO 

insert into BCReturnDepSpecial select * from tempdb.dbo.BCReturnDepSpecial
insert into bctrans select * from tempdb.dbo.bctrans
insert into bctranssub select * from tempdb.dbo.bctranssub
insert into bcpaymoney select * from tempdb.dbo.bcpaymoney
GO 

