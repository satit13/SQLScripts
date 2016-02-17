use bcvat

drop table tempdb.dbo.OPT51
drop table tempdb.dbo.OPT51_bctrans
drop table tempdb.dbo.OPT51_bctranssub
go
select * into tempdb.dbo.OPT51 from nebula.bcnp.dbo.bcotherincome where year(docdate)=2010   and left(docno,3) = 'OPT'
select * into tempdb.dbo.OPT51_bctrans from nebula.bcnp.dbo.bctrans where year(docdate)=2010  and left(docno,3) = 'OPT'
select * into tempdb.dbo.OPT51_bctranssub from nebula.bcnp.dbo.bctranssub where year(docdate)=2010  and left(docno,3) = 'OPT'
go 

alter table tempdb.dbo.OPT51  drop column roworder 
alter table tempdb.dbo.OPT51_bctrans  drop column roworder 
alter table tempdb.dbo.OPT51_bctranssub  drop column roworder 
go

delete bcotherincome where docno in (select docno from tempdb.dbo.OPT51)
delete bctrans where docno in (select docno from tempdb.dbo.OPT51)
delete bctranssub where docno in (select docno from tempdb.dbo.OPT51)
go 

insert into bcotherincome select * from tempdb.dbo.OPT51
insert into bctrans select * from tempdb.dbo.OPT51_bctrans
insert into bctranssub select * from tempdb.dbo.OPT51_bctranssub
go 