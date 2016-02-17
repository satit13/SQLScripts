-- Script นำรูปแบบการเชื่อมจากหน้าร้านมาหลังร้าน 
if exists(select name from tempdb.dbo.sysobjects where name = 'bcglformat')
	drop table tempdb.dbo.bcglformat
if exists(select name from tempdb.dbo.sysobjects where name = 'bcglformatsub')
	drop table tempdb.dbo.bcglformatsub
go 

select * into tempdb.dbo.bcglformat from nebula.bcnp.dbo.bcglformat 
select * into tempdb.dbo.bcglformatsub from nebula.bcnp.dbo.bcglformatsub


alter table tempdb.dbo.bcglformat drop column roworder
alter table tempdb.dbo.bcglformatsub drop column roworder


delete bcglformat where code in (select code from tempdb.dbo.bcglformat)
delete bcglformatsub where code in (select code from tempdb.dbo.bcglformat)


insert into bcglformat select * from tempdb.dbo.bcglformat 
insert into bcglformatsub select * from tempdb.dbo.bcglformatsub

Go 