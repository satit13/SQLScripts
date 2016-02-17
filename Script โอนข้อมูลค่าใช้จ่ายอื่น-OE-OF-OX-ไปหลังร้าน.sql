
drop table tempdb.dbo.expense_index
drop table tempdb.dbo.bcinputtax_expense
drop table tempdb.dbo.bcotherexpense
drop table tempdb.dbo.bctrans_expense
drop table tempdb.dbo.bctranssub_expense
drop table tempdb.dbo.bcpaymoney_expense
drop table tempdb.dbo.bcinputtax_expense

go 

select docno 
into tempdb.dbo.expense_index
from nebula.bcnp.dbo.bcotherexpense 
where (docno like '%OT%' or docno like '%OE%' or docno like '%OX%' or docno like '%OF%' )
 	and year(docdate)=2015
	and month(docdate)between 6 and 6 


select * into tempdb.dbo.bcotherexpense	
	from nebula.bcnp.dbo.bcotherexpense where docno in (select docno from tempdb.dbo.expense_index)
select * into tempdb.dbo.bctrans_expense
	 from nebula.bcnp.dbo.bctrans where docno in (select docno from tempdb.dbo.expense_index)
select * into tempdb.dbo.bctranssub_expense
	 from nebula.bcnp.dbo.bctranssub where docno in (select docno from tempdb.dbo.expense_index)
select * into tempdb.dbo.bcpaymoney_expense
	 from nebula.bcnp.dbo.bcpaymoney where docno in (select docno from tempdb.dbo.expense_index)
select * into tempdb.dbo.bcinputtax_expense 
	  from nebula.bcnp.dbo.bcinputtax where docno in (select docno from tempdb.dbo.expense_index)


alter table tempdb.dbo.bcotherexpense drop column roworder
alter table tempdb.dbo.bctrans_expense drop column roworder
alter table tempdb.dbo.bctranssub_expense drop column roworder
alter table tempdb.dbo.bcpaymoney_expense drop column roworder
alter table tempdb.dbo.bcinputtax_expense drop column roworder



delete bcotherexpense where docno in  (select docno from tempdb.dbo.expense_index)
delete bctrans where docno in  (select docno from tempdb.dbo.expense_index)
delete bctranssub where docno in  (select docno from tempdb.dbo.expense_index)
delete bcpaymoney where docno in  (select docno from tempdb.dbo.expense_index)
delete bcinputtax where docno in  (select docno from tempdb.dbo.expense_index)

insert into bcotherexpense select * from  tempdb.dbo.bcotherexpense 
insert into bctrans select * from  tempdb.dbo.bctrans_expense 
insert into bctranssub select * from  tempdb.dbo.bctranssub_expense 
insert into bcpaymoney select * from  tempdb.dbo.bcpaymoney_expense 
insert into bcinputtax select * from  tempdb.dbo.bcinputtax_expense 






