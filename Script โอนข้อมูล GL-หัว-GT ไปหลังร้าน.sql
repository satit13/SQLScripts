--ขอเพิ่มการโอนข้อมูล หัวเอกสาร GT หน้าบัญชี/บันทึกข้อมูลรายวัน
use bcvat

if exists(select name from tempdb.dbo.sysobjects where name = 'bctrans_gl')
	drop table tempdb.dbo.bctrans_gl

if exists(select name from tempdb.dbo.sysobjects where name = 'bctranssub_gl')
	drop table tempdb.dbo.bctranssub_gl
go 


select * into  tempdb.dbo.bctrans_gl from  nebula.bcnp.dbo.bctrans 
	where source=0  and docno like '%GT%'
		and month(docdate)=2
		and year(docdate)=2015


select * into tempdb.dbo.bctranssub_gl from nebula.bcnp.dbo.bctranssub where docno in (select docno from tempdb.dbo.bctrans_gl)
--select * from nebula.bcnp.dbo.bcoutputtax where docno in (select docno from tempdb.dbo.bctrans)


alter table tempdb.dbo.bctrans_gl drop column roworder
alter table tempdb.dbo.bctranssub_gl drop column roworder

delete bctrans where docno in (select docno from tempdb.dbo.bctrans_gl)
delete bctranssub where docno in (select docno from tempdb.dbo.bctrans_gl)

insert into bctrans select * from tempdb.dbo.bctrans_gl
insert into bctranssub select * from tempdb.dbo.bctranssub_gl

