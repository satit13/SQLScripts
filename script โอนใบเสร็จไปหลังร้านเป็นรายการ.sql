use bcvat
drop table tempdb.dbo.bcreceipt1_xx
drop table tempdb.dbo.bcreceiptsub1_xx
drop table tempdb.dbo.bcrecmoney_xx
drop table tempdb.dbo.bccreditcard_xx
drop table tempdb.dbo.bctrans_xx
drop table tempdb.dbo.bctranssub_xx
drop table tempdb.dbo.bcchqin_xx
drop table tempdb.dbo.bcarwtaxlist_xx


drop table tempdb.dbo.bcREKEY

-- โอน RE , RR ที่ยังไม่ได้โอนไปหลังร้าน
select docno  into tempdb.dbo.bcREKEY from nebula.bcnp.dbo.bcreceipt1 
	where YEAR(docdate)=2015 and docno not in (select docno from bcvat.dbo.BCReceipt1)
		and (docno like '%RE%' or docno like '%RR%')


select * into tempdb.dbo.bcreceipt1_xx from nebula.bcnp.dbo.bcreceipt1 where docno in (select docno from tempdb.dbo.bcREKEY)
select * into tempdb.dbo.bcreceiptsub1_xx  from nebula.bcnp.dbo.bcreceiptsub1 where docno in(select docno from tempdb.dbo.bcREKEY)
select * into tempdb.dbo.bcrecmoney_xx  from nebula.bcnp.dbo.bcrecmoney where docno in (select docno from tempdb.dbo.bcREKEY)
select * into tempdb.dbo.bccreditcard_xx  from nebula.bcnp.dbo.bccreditcard where docno in (select docno from tempdb.dbo.bcREKEY)
select * into tempdb.dbo.bctrans_xx  from nebula.bcnp.dbo.bctrans where docno in (select docno from tempdb.dbo.bcREKEY)
select * into tempdb.dbo.bctranssub_xx  from nebula.bcnp.dbo.bctranssub where docno in (select docno from tempdb.dbo.bcREKEY)
select * into tempdb.dbo.bcchqin_xx  from nebula.bcnp.dbo.bcchqin where docno in (select docno from tempdb.dbo.bcREKEY)
select * into tempdb.dbo.bcarwtaxlist_xx  from nebula.bcnp.dbo.bcarwtaxlist where docno in (select docno from tempdb.dbo.bcREKEY)


ALTER table tempdb.dbo.bcreceipt1_xx drop column roworder
ALTER table tempdb.dbo.bcreceiptsub1_xx drop column roworder
ALTER table tempdb.dbo.bcrecmoney_xx drop column roworder
ALTER table tempdb.dbo.bccreditcard_xx drop column roworder
ALTER table tempdb.dbo.bctrans_xx drop column roworder
ALTER table tempdb.dbo.bctranssub_xx drop column roworder
ALTER table tempdb.dbo.bcchqin_xx drop column roworder
ALTER table tempdb.dbo.bcarwtaxlist_xx drop column roworder


delete bcreceipt1 where docno in (select docno from  tempdb.dbo.bcreceipt1_xx)
delete bcreceiptsub1 where docno in (select docno  from tempdb.dbo.bcreceipt1_xx)
delete bcrecmoney where docno in (select docno  from tempdb.dbo.bcreceipt1_xx)
delete bccreditcard where docno in (select docno  from tempdb.dbo.bcreceipt1_xx)
delete bctrans where docno in (select docno  from tempdb.dbo.bcreceipt1_xx)
delete bctranssub where docno in (select docno  from tempdb.dbo.bcreceipt1_xx)
delete bcchqin where docno in (select docno  from tempdb.dbo.bcreceipt1_xx)
delete bcarwtaxlist where docno in (select docno  from tempdb.dbo.bcreceipt1_xx)



insert into bcreceipt1 select * from tempdb.dbo.bcreceipt1_xx
insert into bcreceiptsub1 select * from tempdb.dbo.bcreceiptsub1_xx
insert into bcrecmoney select * from tempdb.dbo.bcrecmoney_xx
insert into bccreditcard select * from tempdb.dbo.bccreditcard_xx
insert into bctrans select * from tempdb.dbo.bctrans_xx
insert into bctranssub select * from tempdb.dbo.bctranssub_xx
insert into bcchqin select * from tempdb.dbo.bcchqin_xx
insert into bcarwtaxlist select * from tempdb.dbo.bcarwtaxlist_xx


