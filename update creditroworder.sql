drop table tempdb.dbo.Fbcreditcard
drop table tempdb.dbo.fixrow
go 

declare @month int
declare @year int

set @month = 1
set @year = 2010
select * into tempdb.dbo.Fbcreditcard
 from nebula.bcnp.dbo.bccreditcard 
	where roworder in 
	(select creditroworder 
		from bccreditpasssub 
		where month(docdate)=@month
			and year(docdate)=@year
	)

select x.roworder,
(select top 1 roworder 
	from bccreditcard 
	where docno = x.sourceno and creditcardno = x.creditcardno and confirmno =x.confirmno) as updatecreditroworder
into tempdb.dbo.fixrow
 from 
(
select a.roworder,a.docno ,a.linenumber,b.bankcode,b.creditcardno,b.docno sourceno,b.credittype,b.confirmno
	from bccreditpasssub a left join   
		tempdb.dbo.fbcreditcard b on a.creditroworder=b.roworder
	where month(a.docdate)=@month and year(a.docdate)=@year
) X 


update bccreditpasssub 
set creditroworder = 
	(select updatecreditroworder 
		from tempdb.dbo.fixrow ee 
		where ee.roworder=bccreditpasssub.roworder
	)
where month(docdate)=@month and year(docdate)=@year