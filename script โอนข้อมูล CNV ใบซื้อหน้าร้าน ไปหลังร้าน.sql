use bcvat
set dateformat dmy
if exists(select name from tempdb.dbo.sysobjects where name = 'bcstkrefund')
	drop table tempdb.dbo.bcstkrefund
if exists(select name from tempdb.dbo.sysobjects where name = 'bcstkrefundsub')
	drop table tempdb.dbo.bcstkrefundsub
if exists(select name from tempdb.dbo.sysobjects where name = 'bcinputtax')
	drop table tempdb.dbo.bcinputtax
if exists(select name from tempdb.dbo.sysobjects where name = 'bcapwtaxlist')
	drop table tempdb.dbo.bcapwtaxlist
if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans')
	drop table tempdb.dbo.bctrans
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub')
	drop table tempdb.dbo.bctranssub
if exists(select name from tempdb.dbo.sysobjects where name = 'bcapdeposituse')
	drop table tempdb.dbo.bcapdeposituse
if exists(select name from tempdb.dbo.sysobjects where name = 'bcinvstkrefund')
	drop table tempdb.dbo.bcinvstkrefund

if exists(select name from tempdb.dbo.sysobjects where name = 'apinvoice_key')
	drop table tempdb.dbo.apinvoice_key
go
select docno into tempdb.dbo.apinvoice_key 
from nebula.bcnp.dbo.bcstkrefund 
	where docno like '%CNV5312-0045%' 
	--and docdate between '04/12/2011' and '04/12/2011'
go
/*
หัวเอกสาร CNV
เดือน 7  วันที่ 12
เดือน 8  วันที่ 6, 19, 26, 31
เดือน 9  วันที่ 1, 9, 10, 28
เดือน 10 วันที่ 8, 12, 19, 20, 21, 25, 26
เดือน 11 วันที่ 5, 16, 17, 19, 24, 25,26, 29, 30
 
*/
 


print 'เลือกข้อมูล'
select * into tempdb.dbo.bcstkrefund from nebula.bcnp.dbo.bcstkrefund where docno in (select docno from tempdb.dbo.apinvoice_key)
select * into tempdb.dbo.bcstkrefundsub from nebula.bcnp.dbo.bcstkrefundsub  where docno in (select docno from tempdb.dbo.apinvoice_key)
select * into tempdb.dbo.bcinputtax from nebula.bcnp.dbo.bcinputtax  where docno in (select docno from tempdb.dbo.apinvoice_key)
select * into tempdb.dbo.bcapwtaxlist from nebula.bcnp.dbo.bcapwtaxlist where docno in (select docno from tempdb.dbo.apinvoice_key)
select * into tempdb.dbo.bctrans from nebula.bcnp.dbo.bctrans where docno in (select docno from tempdb.dbo.apinvoice_key)
select * into tempdb.dbo.bctranssub from nebula.bcnp.dbo.bctranssub where docno in (select docno from tempdb.dbo.apinvoice_key)
select * into tempdb.dbo.bcapdeposituse from nebula.bcnp.dbo.bcapdeposituse  where docno in (select docno from tempdb.dbo.apinvoice_key)
select * into tempdb.dbo.bcinvstkrefund from nebula.bcnp.dbo.bcinvstkrefund  where stkrefundno in (select docno from tempdb.dbo.apinvoice_key)



go

print 'Alter table drop roworder'
alter table tempdb.dbo.bcstkrefund drop column roworder
alter table tempdb.dbo.bcstkrefundsub	drop column roworder
alter table tempdb.dbo.bcinputtax	drop column roworder
alter table tempdb.dbo.bcapwtaxlist drop column roworder
alter table tempdb.dbo.bctrans drop column roworder
alter table tempdb.dbo.bctranssub drop column roworder
alter table tempdb.dbo.bcapdeposituse drop column roworder
alter table tempdb.dbo.bcinvstkrefund drop column roworder

go 
print 'ลบข้อมูลเดิม'
delete bcstkrefund where docno in (select docno from tempdb.dbo.bcstkrefund)
delete bcstkrefundsub where docno in (select docno from tempdb.dbo.bcstkrefund)
delete bcinputtax where docno in (select docno from tempdb.dbo.bcstkrefund)
delete bcapwtaxlist where docno in (select docno from tempdb.dbo.bcstkrefund)
delete bctrans where docno in (select docno from tempdb.dbo.bcstkrefund)
delete bctranssub where docno in (select docno from tempdb.dbo.bcstkrefund)
delete bcapdeposituse where docno in (select docno from tempdb.dbo.bcstkrefund)
delete bcinvstkrefund where stkrefundno in (select docno from tempdb.dbo.bcstkrefund)


go 

print 'insert new data'
insert into bcstkrefund select * from tempdb.dbo.bcstkrefund 
insert into bcstkrefundsub select * from tempdb.dbo.bcstkrefundsub 
insert into bcinputtax select * from tempdb.dbo.bcinputtax 
insert into bcapwtaxlist select * from tempdb.dbo.bcapwtaxlist 
insert into bctrans select * from tempdb.dbo.bctrans 
insert into bctranssub select * from tempdb.dbo.bctranssub 
insert into bcapdeposituse select * from tempdb.dbo.bcapdeposituse 
insert into bcinvstkrefund select * from tempdb.dbo.bcinvstkrefund 

go



