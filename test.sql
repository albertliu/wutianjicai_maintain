--查询所有表名

select name from sysobjects where xtype='u'

select * from sys.tables

--查询所有表名及对应架构

select t.[name] as tablename, s.[name] as [schema] from sys.tables as t,sys.schemas as s where t.schema_id = s.schema_id

--查询数据库中所有的表名及行数

SELECT a.name, b.rows

FROM sysobjects AS a INNER JOIN sysindexes AS b ON a.id = b.id

WHERE (a.type = 'u') AND (b.indid IN (0, 1))

ORDER BY b.rows DESC

--查询所有的标明及空间占用量\行数

select

object_name(id) tablename,

8*reserved/1024 reserved,

rtrim(8*dpages)+'kb' used,

8*(reserved-dpages)/1024 unused,

8*dpages/1024-rows/1024*minlen/1024 free,

rows

--,*

from sysindexes

where indid=1

order by rows desc

--收缩数据库日志文件：
--ALTER DATABASE crm_uheoo SET RECOVERY SIMPLE
--DBCC SHRINKDATABASE(crm_uheoo)
--DBCC SHRINKFILE(2)
--ALTER DATABASE crm_uheoo SET RECOVERY FULL

--ALTER DATABASE zghc SET RECOVERY SIMPLE
--DBCC SHRINKDATABASE(zghc)
--DBCC SHRINKFILE(2)
--ALTER DATABASE zghc SET RECOVERY FULL


SELECT CONVERT(varchar(20),scantime,23),COUNT(*)
  FROM [zghc].[dbo].[tiaoxingma]
  where isupload= 0 and iscan=1
 group by CONVERT(varchar(20),scantime,23)
 order by CONVERT(varchar(20),scantime,23)

--ALTER DATABASE zghc SET RECOVERY SIMPLE
--DBCC SHRINKDATABASE(zghc)
--DBCC SHRINKFILE(2)

--正广和本地数据库zghc
CREATE TABLE gc_addLogSum(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LineNum] [varchar](50) NULL,
	[ClassGroup] [varchar](50) NULL,
	[Goods_Code] [varchar](50) NULL,
	[barcode] [varchar](50) NULL,
	[regDate] [varchar](50) NULL,
	[bindNum] int default(0) NULL
)
-- =============================================
-- Author:		Albert	
-- Create date: 20161024
-- Description:	正广和生产线扫码时，写logDetail的同时，写logSum，取代程序中的代码
-- 表logsum增加一个标识列mark int default(0)
-- alter table logSum add mark int default(0)
-- =============================================
ALTER TRIGGER trig_logDetail_addLogSum
   ON  logDetail with encryption
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	declare @id int, @bind int
	select @id=b.id, @bind=b.BindNum FROM inserted a, logsum b 
		where a.LineNum=b.LineNum and a.ClassGroup=b.ClassGroup and a.Goods_Code=b.Goods_Code and CONVERT(varchar(20),cast(a.[Date] as datetime),23)=b.CreateDate
	update logSum set BindNum=ISNULL(BindNum,0)+1, mark=1 where ID=@id
	update logSum set mark=0 where ID=@id
	--记录到临时表
	insert into gc_addLogSum(LineNum,ClassGroup,Goods_Code,barcode,regDate,bindNum) select LineNum,ClassGroup,Goods_Code,barcode,CONVERT(varchar(20),cast([Date] as datetime),23),@bind from inserted
END
GO

-- =============================================
-- Author:		Albert	
-- Create date: 20161024
-- Description:	正广和生产线扫码时，更新logSum的操作只接受来自logDetail的触发器指令，忽略其他来源的对BindNum的修改
-- logsum标识列mark，如果为1，则来自logDetail的触发器
-- =============================================
ALTER TRIGGER trig_logSum_updateBindNum
   ON  logSum with encryption
   AFTER UPDATE,INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	declare @id int, @bind int, @old int, @mark int
	select @id=ID,@bind=BindNum,@mark=isnull(mark,0) from inserted
	select @old=BindNum from deleted
	select @old=ISNULL(@old,0)
	if @bind>@old and @mark=0
		update logsum set BindNum=ISNULL(@old,0) where ID=@id
END
GO
--在正广和zghc数据库中，创建链接服务器[www.uheoo.com,14333]
-- CREATE DATE: 2016-10-26
-- Description:	正广和zghc。定期将本地扫描日志文件更新到服务器。
-- Use case: exec sp_support_scan_logsum
-- =============================================
ALTER PROCEDURE [dbo].[sp_support_scan_logsum] 
AS
BEGIN
	--将新纪录写入gc_logSum
	insert into [www.uheoo.com,14333].crm_uheoo.dbo.gc_logSum(LineNum,ClassGroup,Goods_Code,createDate,bindNum,errorNum,noExistNum,shouBindNum,shouUnBindNum) 
		select a.LineNum,a.ClassGroup,a.Goods_Code,a.createDate,a.bindNum,a.errorNum,a.noExistNum,a.shouBindNum,a.shouUnBindNum from logSum a left outer join [www.uheoo.com,14333].crm_uheoo.dbo.gc_logSum b
		on a.LineNum=b.lineNum and a.ClassGroup=b.classGroup and a.Goods_Code=b.goods_Code and a.CreateDate=b.createDate and b.lineNum is null
	--更新记录
	update [www.uheoo.com,14333].crm_uheoo.dbo.gc_logSum set bindNum=a.bindNum, errorNum=a.errorNum,noExistNum=a.noExistNum,shouBindNum=a.shouBindNum,shouUnBindNum=a.shouUnBindNum from logsum a, [www.uheoo.com,14333].crm_uheoo.dbo.gc_logSum b
		where a.LineNum=b.lineNum and a.ClassGroup=b.classGroup and a.Goods_Code=b.goods_Code and a.CreateDate=b.createDate and a.BindNum<>b.lineNum
END


select count(*) from T_Searchcode
select count(*) from T_Scan where createdate>='2020-06-20'
select * from T_Scan where createdate>='2016-06-20'
select top 10 * from T_Searchcode where creatdate<='2019-02-01' order by id desc

select * into T_Sacn20150415 from T_Scan where createdate>='2013-03-11'
GO
select * into T_Sacn20171005 from T_Scan
GO
select count(*) from T_Searchcode where creatdate>='2020-08-08'

select * from T_Scan where createdate>='2020-07-15'
select top 10 * from T_Scan order by id desc
select top 50 * from [dbo].[T_Product_Code] order by id desc
select address,productNo,count(*) from [dbo].[T_Product_Code] where CreateTime>'2020-10-15' group by address,productNo
select address,productNo,count(*) from [dbo].[T_Product_Code] where CreateTime>convert(varchar(20),getDate(),23) group by address,productNo
select * from T_Searchcode where barcode='813877865586'
select * from T_Searchcode where barcode='658285882374'
select top 100 * from T_Searchcode order by id desc
select * from T_Scan where code='CzghVxHmSSyyizJyyekVWgePkVC'
select * from [dbo].[T_Product_Code] where start='50151001'
select top 10 * from [dbo].[T_Product_Code] where CreateTime>='2020-07-15'
select * from [dbo].[T_Product_Code] where CreateTime>='2020-07-16'
select convert(varchar,CreateTime,23),count(*) from [dbo].[T_Product_Code] where CreateTime>='2020-07-14' group by convert(varchar,CreateTime,23)
select b.productNo,c.goodsSn,a.*,b.*,c.* from T_Searchcode a, [T_Product_Code] b, T_Scan c where a.sn=b.Start and a.code=c.code and a.ExchangeDate>='2020-07-01' and b.productNo<>c.goodsSn
select * from T_Searchcode where ExchangeDate>='2020-07-11' and sn not in(select start from [T_Product_Code]  where CreateTime>='2020-07-11')
select * into T_Searchcode_lost0716 from T_Searchcode where ExchangeDate>='2020-07-11' and sn not in(select start from [T_Product_Code]  where CreateTime>='2020-07-11')
select top 10 * from [dbo].[T_Product_Code] where id>38891060
select * from [dbo].[T_Product_Code] where start=45894738
select a.*,b.* from T_Searchcode_lost0716 a, T_Scan b where a.code=b.code
select * from T_Searchcode where sn=50775805
select top 20 * from dal_exchange order by ID desc
select top 10 * from dal_barcode
select * from dal_exchange where code='886464366550'
delete from dal_exchange where code='658285882374'
select * from T_Searchcode where barcode='886464366550'
delete from T_Searchcode where barcode='658285882374'
insert into T_Searchcode(companyid,sn,code,barcode,creatdate) values(32,50151001,'CzghVxHmSSyyizJyyekVWgePkVC','658285882374','2020-07-26 19:06:41.593')

--truncate table T_Searchcodebak
--select * into T_Searchcodebak from T_Searchcode where creatdate>='2020-08-06'
select count(*) from T_Searchcode where creatdate<='2017-12-31'
select count(*) from T_Searchcodebak
--exec drop_T_Searchcode '2015-12-31'

SELECT    a.name   as [索引名称],a.indid
,c.name   as [表名]
,d.name   as [索引字段名]
,d.colid   as [索引字段位置]
FROM   sysindexes   a(nolock)
JOIN   sysindexkeys   b(nolock)   ON   a.id=b.id   AND   a.indid=b.indid
JOIN   sysobjects   c(nolock)   ON   b.id=c.id
JOIN   syscolumns   d(nolock)   ON   b.id=d.id   AND   b.colid=d.colid
WHERE   a.indid   NOT IN(0,255)
-- and   c.xtype='U'   and   c.status>0
AND   c.name='T_Searchcode'

select ps.database_id,
    ps.object_id,
    ps.index_id,
    ps.partition_number,
    ps.index_type_desc,
    ps.alloc_unit_type_desc,
    ps.index_depth,
    ps.index_level,
    ps.avg_fragmentation_in_percent,
    ps.fragment_count,
    ps.avg_fragment_size_in_pages,
    ps.page_count,
    ps.avg_page_space_used_in_percent,
    ps.record_count,
    ps.ghost_record_count,
    ps.version_ghost_record_count,
    ps.min_record_size_in_bytes,
    ps.max_record_size_in_bytes,
    ps.avg_record_size_in_bytes,
    ps.forwarded_record_count,
    ps.compressed_page_count
FROM sys.dm_db_index_physical_stats(DB_ID('CRM_UHEOO'),OBJECT_ID('T_Searchcode'),NULL,NULL,'Sampled') as ps

select * from dbo.check_index_for_table('Dal_Company_Barcode','CRM_UHEOO')
--ALTER INDEX [IX_T_Searchcode_SN] ON [dbo].[T_Searchcode] REBUILD PARTITION=ALL WITH (FILLFACTOR = 95, ONLINE = OFF, DATA_COMPRESSION = PAGE )


select top 10 * from Dal_Exchange order by ID desc
select convert(varchar(4),exchangedate,23) as year,count(*) as count,sum(Integral) as score from Dal_Exchange group by convert(varchar(4),exchangedate,23) order by year
--客户信息
select * from dal_customer where customername='13818119269'
--客户积分明细
select * from dal_exchange where mobile='15316057567'

update dal_customer set score=score+8000  where customername='18993393743'
select sum(score) from dal_customer
select top 100 * from dal_customer order by id desc
select customername,count(*),sum(score) from dal_customer group by customername having count(*)>1 order by CustomerName
select customername,min(recordtime) as regDate from dal_customer group by customername
select convert(varchar(4),regDate,23) as years,count(*) from
(select customername,min(recordtime) as regDate from dal_customer group by customername) a
group by convert(varchar(4),regDate,23)
order by years

select top 100 * from Bi_SmsLog order by sendtime desc
select * from Bi_SmsLog where moblies='13331987897' order by sendtime desc
--短信发送统计
select convert(varchar(4),sendtime,23) as years,count(*) from Bi_SmsLog group by convert(varchar(4),sendtime,23) order by convert(varchar(4),sendtime,23)

--CQ
select top 100 * from tiaoxingma order by scantime desc
select * from tiaoxingma where barcode='488233142651'
select top 10 * from logsum order by id desc
select * from tiaoxingma where scantime is not null and isupload=0

select count(*) from tiaoxingma  --51512031

--M 20201008 
--张总提供的发货清单，30条记录，要将系统中的订单状态标记为已发货。
select * from Dal_Order where orderNo='1560406392949'
select * from Dal_Order where OrderStatusID>0 and CompanyID=32
--将清单导入临时表dal_order_temp4
select a.* from Dal_Order a, dal_order_temp4 b where a.orderNo=b.orderno
update Dal_Order set OrderStatusID=4 from dal_order_temp4 a where Dal_Order.orderNo=a.orderno
--/M

--M 20201009
--正广和提出有扫描出的时间与实际生产时间相差3天。
--根据工厂扫码时间更新服务器时间
select * from [dbo].[T_Product_Code] where start='47821567'
--将清单导入临时表T_Product_Code_temp4
--truncate table T_Product_Code_temp4
select a.*,b.scantime from T_Product_Code a, T_Product_Code_temp4 b where a.start=b.sn and a.start='47821567'
--update T_Product_Code set CreateTime=a.scantime from T_Product_Code_temp4 a where T_Product_Code.start=a.sn
--/M
SELECT top 20 * FROM tiaoxingma as a with (nolock) where a.iscan=1 and (a.isupload=0 or a.isupload is null or a.isupload='') order by scantime desc

CREATE TABLE [dbo].[temp_tiaoxingma_tc](
	[code] [varchar](50) NOT NULL,
	[sn] [varchar](50) NULL,
	[barcode] [varchar](50) NULL,
	[iscan] [int] NULL,
	[scantime] [datetime] NULL,
	[isupload] [int] NULL,
	[uploadtime] [datetime] NULL,
	[goods_code] [varchar](50) NULL,
	[Device] [varchar](50) NULL,
	[Line] [varchar](50) NULL,
	[ClassGroup] [varchar](50) NULL,
	[Operator_Name] [varchar](50) NULL,
	[StoreID] [int] NULL,
	[isunbang] [int] NULL,
	[Address] [nvarchar](50) NULL
	) ON [PRIMARY]

GO
--insert into temp_tiaoxingma select * from tiaoxingma where scantime > '2020-01-01'

SELECT YEAR(scantime),COUNT(*) FROM tiaoxingma group by YEAR(scantime)
--insert into tiaoxingma_bak20201013 select * from tiaoxingma where scantime is null

ALTER procedure [dbo].[drop_tiaoxingma_scantime_is_null]
	@minSN varchar(20)
as
begin
	SET NOCOUNT ON;
	declare @i int, @m int
	select @i=0, @m=10000
	SET ROWCOUNT @m; --每次执行删除的条数
	WHILE 1=1
	BEGIN
		BEGIN TRAN
			DELETE FROM tiaoxingma WHERE scantime is null and sn<@minSN;
			--print @@ROWCOUNT;
			set @i=@i+1
			IF @@ROWCOUNT = 0
				BREAK;
		COMMIT;
	END
	SET ROWCOUNT 0;
end

--exec drop_tiaoxingma_scantime_is_null '43400000'

EXEC master.dbo.sp_addlinkedserver @server = N'WWW.UHEOO.COM,14333', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'WWW.UHEOO.COM,14333',@useself=N'False',@locallogin=NULL,@rmtuser=N'CRMOWUSER',@rmtpassword='N9YAhQUETE05M'

--upload this factory's scan qty and upload qty today
ALTER procedure [dbo].[writeFactoryDaily]
as
begin
	declare @qty int
	--select @qty=count(*) from [www.uheoo.com,14333].crm_uheoo.dbo.[T_Product_Code] where CreateTime>convert(varchar(20),getDate(),23) and address='长青饮料厂'
	insert into [www.uheoo.com,14333].crm_uheoo.dbo.gc_factory_daily
	select CONVERT(varchar(20),getDate(),23),max(address),goods_code,COUNT(*),SUM(case when isupload=1 then 1 else 0 end),0,avg(DATEDIFF(SS,scantime,uploadtime)),getDate() from tiaoxingma where scantime>CONVERT(varchar(20),getDate(),23) and iscan=1 group by goods_code
	update [www.uheoo.com,14333].crm_uheoo.dbo.gc_factory_daily set qtyRemote=a.c from (select productNo, count(*) as c from [www.uheoo.com,14333].crm_uheoo.dbo.[T_Product_Code]  where CreateTime>convert(varchar(20),getDate(),23) and address='长青饮料厂' group by productNo) a
	where uploadDate=CONVERT(varchar(20),getDate(),23) and goods=a.productNo and factory='长青饮料厂'
end

--truncate table temp_tiaoxingma
select count(*) from temp_tiaoxingma with(nolock)
select start,count(*) from [T_Product_Code] group by start having count(*)>1
select * from [dbo].[T_Product_Code] where start=50121799
select * from [dbo].temp_tiaoxingma where sn=50121799
select a.* from [dbo].[T_Product_Code] a, temp_tiaoxingma b where a.CreateTime>convert(varchar(20),dateadd(d,-1,getDate()),23)  and a.address='苏州阳山厂'
and a.start=b.sn
select a.start,count(*) from [dbo].[T_Product_Code] a, temp_tiaoxingma b where a.CreateTime>convert(varchar(20),dateadd(d,-1,getDate()),23)  and a.address='苏州阳山厂'
and a.start=b.sn group by a.start having count(*)>1

select * from [www.uheoo.com,14333].crm_uheoo.dbo.gc_factory_daily
--exec writeFactoryDaily
--truncate table gc_factory_daily
--凌晨上传的数据（前一天的，滞后）
select top 100 * from [T_Product_Code] where CreateTime>'2020-10-15' and CreateTime<'2020-10-15 06:00:00' and address='太仓泰富厂' order by ID desc
--将前一天滞后的数据修改为正确的时间
--update [T_Product_Code] set CreateTime='2020-10-14 19:00:00' where CreateTime>'2020-10-15' and CreateTime<'2020-10-15 06:00:00' and address='太仓泰富厂'
--查看每天每个工厂的扫码-上传数量。工厂每天23:45自动发送。
select * from v_gc_factory_daily order by uploadDate desc
--今天上传的数据
select address,productNo,count(*),min(createtime),max(createtime) from [dbo].[T_Product_Code] where CreateTime>convert(varchar(20),getDate(),23) group by address,productNo
--昨天上传的数据
select address,productNo,count(*),min(createtime),max(createtime) from [dbo].[T_Product_Code] where CreateTime>convert(varchar(20),dateadd(d,-1,getDate()),23) group by address,productNo

select COUNT(*) from tiaoxingma where iscan=1 and scantime > CONVERT(varchar(20),getDate(),23)
select * from temp_tiaoxingma where createtime is null
--update temp_tiaoxingma set createtime = b.createtime from [dbo].[T_Product_Code] b where b.CreateTime>convert(varchar(20),getDate(),23) and b.address='长青饮料厂' and temp_tiaoxingma.sn=b.start
select *  from [dbo].[T_Product_Code] where Start=48112664
select * from temp_tiaoxingma where sn=48112664    --长青厂10.16日出现231个重复标签（已经被其他生产线激活过）

--2020-01-01 ~ 2020-10-18 重码情况统计
select a.sn as '序列号',a.barcode as '二维码',a.scantime as '苏州厂激活',b.scantime as '太仓厂激活', null as '长青厂激活' from temp_tiaoxingma_sz a, temp_tiaoxingma_tc b where a.sn=b.sn
union select a.sn,a.barcode,a.scantime as '苏州厂激活',null as '太仓厂激活',b.scantime as '长青厂激活' from temp_tiaoxingma_sz a, temp_tiaoxingma_cq b where a.sn=b.sn
union select a.sn,a.barcode,null as '苏州厂激活',a.scantime as '太仓厂激活',b.scantime as '长青厂激活' from temp_tiaoxingma_tc a, temp_tiaoxingma_cq b where a.sn=b.sn
select *  from [dbo].[T_Product_Code] where CreateTime>'2020-10-18' and address='长青饮料厂' and start not in
(select sn from temp_tiaoxingma with(nolock))

--会员注册数量及积分情况统计
select year(recordtime),count(*),sum(score),sum(usedscore) from (
select customername,count(*) as count,sum(score) as score,sum(usedscore) as usedscore,min(recordtime) as recordtime from dal_customer where companyid=32 and len(customername)>4 group by customername
) a group by year(recordtime)
--会员扫码数量统计
select convert(varchar(4),exchangedate,23) as year,count(*) as count,sum(Integral) as score from Dal_Exchange where companyid=32 group by convert(varchar(4),exchangedate,23) order by year

select * from dal_customer where customername=' 13916033350'
select top 10 * from Dal_Exchange where companyid=32 order by ID desc
