use bcvat
set dateformat dmy
if exists(select name from tempdb.dbo.sysobjects where name = 'bcapinvoice')
	drop table tempdb.dbo.bcapinvoice
if exists(select name from tempdb.dbo.sysobjects where name = 'bcapinvoicesub')
	drop table tempdb.dbo.bcapinvoicesub

if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans')
	drop table tempdb.dbo.bctrans
if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub')
	drop table tempdb.dbo.bctranssub

if exists(select name from tempdb.dbo.sysobjects where name = 'apinvoice_key')
	drop table tempdb.dbo.apinvoice_key
go
select docno into tempdb.dbo.apinvoice_key from nebula.bcnp.dbo.bcapinvoice 
	where (docno like '%RV%' or 
		  docno like '%RX%' or 
			docno like '%RCIP%') and 
	YEAR(docdate) =2015 and 
	docno not in (select docno from bcapinvoice)
go
/*
หัวเอกสาร ASV วันที่ 29/9,  12/10,  29/10,  18/11,  27/11 
*/
 


print 'เลือกข้อมูล'
select * into tempdb.dbo.bcapinvoice from nebula.bcnp.dbo.bcapinvoice where docno in (select docno from tempdb.dbo.apinvoice_key)
select * into tempdb.dbo.bcapinvoicesub from nebula.bcnp.dbo.bcapinvoicesub  where docno in (select docno from tempdb.dbo.apinvoice_key)

select * into tempdb.dbo.bctrans from nebula.bcnp.dbo.bctrans where docno in (select docno from tempdb.dbo.apinvoice_key)
select * into tempdb.dbo.bctranssub from nebula.bcnp.dbo.bctranssub where docno in (select docno from tempdb.dbo.apinvoice_key)

go

print 'Alter table drop roworder'
alter table tempdb.dbo.bcapinvoice drop column roworder
alter table tempdb.dbo.bcapinvoicesub	drop column roworder

alter table tempdb.dbo.bctrans drop column roworder
alter table tempdb.dbo.bctranssub drop column roworder


go 
print 'ลบข้อมูลเดิม'
delete bcapinvoice where docno in (select docno from tempdb.dbo.bcapinvoice)
delete bcapinvoicesub where docno in (select docno from tempdb.dbo.bcapinvoice)

delete bctrans where docno in (select docno from tempdb.dbo.bcapinvoice)
delete bctranssub where docno in (select docno from tempdb.dbo.bcapinvoice)


go 

print 'insert new data'
insert into bcapinvoice select * from tempdb.dbo.bcapinvoice 
insert into bcapinvoicesub select * from tempdb.dbo.bcapinvoicesub 

insert into bctrans select * from tempdb.dbo.bctrans 
insert into bctranssub select * from tempdb.dbo.bctranssub 


go



