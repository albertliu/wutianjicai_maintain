
收缩数据库日志文件：
ALTER DATABASE CRM_UHEOO SET RECOVERY SIMPLE
DBCC SHRINKDATABASE(CRM_UHEOO)
--backup log archivesAgent with no_log   2008以后不再支持
DBCC SHRINKFILE(2)
ALTER DATABASE CRM_UHEOO SET RECOVERY FULL
-- ALTER DATABASE archivesAgent set offline with rollback immediate

select convert(varchar(20),createtime,23) as productDate,ClassGroup,line,ProductName,productNo, count(*) as count,MIN(CreateTime),MAX(CreateTime) from T_Product_Code where CompanyID=32 and 
CreateTime>=CONVERT(varchar(20),dateadd(d,-5,getdate()),23)+' 00:00:00' and CreateTime<=CONVERT(varchar(20),getdate(),120) group by convert(varchar(20),createtime,23),ClassGroup,line,ProductName,productNo order by convert(varchar(20),createtime,23) desc,classgroup

select COUNT(*) from gc_logSum with(nolock)
select * from gc_logSum with(nolock) order by createdate desc
select * from [supportgc.uheoo.com,14333].crm_uheoo.dbo.gc_logSum with(nolock) order by createdate desc
select top 100 b.goods_name,a.* from Dal_Factorylogsum a, Dal_Company_Barcode b where a.goods_code=b.goods_code and b.companyid=32 order by id desc

--查询数据库中所有的表名及行数

SELECT a.name, b.rows
FROM sysobjects AS a INNER JOIN sysindexes AS b ON a.id = b.id
WHERE (a.type = 'u') AND (b.indid IN (0, 1))
ORDER BY a.name,b.rows DESC
--查询所有系统用户
select * from Au_System_User
select * from Dal_Mobile where companyid=32
--查询所有客户
select * from Dal_Company
select * from Dal_Customer where CompanyID=34
select * from Bi_System_Menu  --系统左侧菜单
select * from Bi_Data_Dic	  --系统基础数据

--20160714 李颖华查数据. 导出结果
--<<
select * from T_Product_Code where CompanyID=32 and CreateTime>='2016-07-10 15:00:00' and CreateTime<='2016-07-10 19:00:00'
-->>
-- 20160715 李颖华要求修改 QQ,WEIXIN
--《
--07-10 18：19：21～18：27：42  ，这一段时间。都改成11.3升纯水。
--一共104桶
select * from T_Product_Code where CompanyID=32 and 
CreateTime>='2016-07-10 18:19:21' and CreateTime<='2016-07-10 18:27:42'

select ProductName,ProductNo,COUNT(*) from T_Product_Code where CompanyID=32 and 
CreateTime>='2016-07-10 18:19:21' and CreateTime<='2016-07-10 18:27:42' 
group by ProductName,ProductNo

update T_Product_Code set ProductName='11.3升纯水',ProductNo='1034' where CompanyID=32 and 
CreateTime>='2016-07-10 18:19:21' and CreateTime<='2016-07-10 18:27:42'

--查询0704-Line1-D、0708-Line2-D生产记录，导出结果output_zgh_20160715_01.xlsx
select * from T_Product_Code where CompanyID=32 and 
CreateTime>='2016-07-04 00:00:00' and CreateTime<='2016-07-05 00:00:00' and Line=1 and ClassGroup='D班'

select * from T_Product_Code where CompanyID=32 and 
CreateTime>='2016-07-08 00:00:00' and CreateTime<='2016-07-09 00:00:00' and Line=2 and ClassGroup='D班'

--》

--20160724
--修改《美迪邦优化需求》中的"分润金额自动计算，逻辑为：分润金额=实际价格-成本价-费用"
--取消直接页面更新，将ProfitAmount字段改为计算列
--((isnull([Price],(0))-isnull([CostPrice],(0)))-isnull([FeiAmount],(0)))

--20160727
--查看及删除扫码获积分记录
select * from Dal_Company	--商家列表
select * from Dal_Customer where CompanyID=53 order by ID desc		--某个商家的客户列表
select * from Dal_Customer where CustomerName='13331987897'			--某个商家的客户列表
select * from Dal_Scan_Code_Log where CompanyID=71 order by ID desc --某个商家的客户扫码记录
select * from Bi_SmsLog where Moblies='13331987897'					--某个客户的短信记录
select top 1000 * from Bi_SmsLog order by SendTime desc				--最近的短信记录
select * from Dal_Exchange where Mobile='13331987897'				--某个客户的积分兑换记录
select * from T_Searchcode where Mobile='13331987897'				--某个客户的积分获得情况
select * from Dal_Company_Barcode where CompanyId=32				--某个商家的产品列表

--对某一条积分绑定记录恢复初始状态
update T_Searchcode set Mobile=null,Uid=null,Ip=null,ExchangeDate=null where ID='16506755'

--20160729
--澜庭集一个二维码查询不到
select * from T_Searchcode where companyid=69 and LongSn='506949128959'
--select * from Dal_Company
select * from T_Scan where companyid=69
select * from T_Codetrash order by ID desc where companyid=69

SELECT a.Id as SearchcodeId,a.Ip, a.Code,a.Mobile,a.ExchangeDate,a.Sn,b.* FROM      (   
SELECT *  	   FROM T_Searchcode	 where Barcode='506949128959'
	)	a  LEFT  JOIN	 T_Product_Code b ON( b.Start<=a.Sn and b.[End]>=a.Sn )	AND a.CompanyId=b.CompanyID
SELECT *  	   FROM T_Searchcode	 where Barcode='506910760907'
select * from T_Searchcode where companyid=69 and LongSn='506910760907'
select * from Dal_Delivery_Log a,T_Searchcode b  where a.BarCodeId=b.id and b.CompanyId=69 and b.LongSn='506949128959'
select * from Dal_Delivery_Log where BarCodeId=14795845
select barcodeid,COUNT(*) from Dal_Delivery_Log group by BarCodeId having COUNT(*)>1
select top 1000 * from T_Searchcode where CompanyId=32 order by ID desc
select top 1000 * from T_Product_Code where CompanyID=32 order by ID desc

--20160809 金纺8.8活动价格修改
select * from Dal_Company_Barcode where CompanyID=53 and goods_code='Q1136351' and field1='M114666146'
select * from Dal_Company_Barcode where CompanyID=53 and field1='BS116175440'
create table dal_company_barcode_53(
point float,
goods_code varchar(50),
goods_name varchar(50),
goods_money float,
f1 varchar(50),
f3 varchar(50),
f8 varchar(50)
)

select * from dal_company_barcode_53

select a.Field1,a.goods_money,a.point,b.goods_money,b.point from Dal_Company_Barcode a, dal_company_barcode_53 b
where a.CompanyID=53 and a.Field1=b.f1 and a.Field3=b.f3 and a.Field8=b.f8 and (a.Point<>b.point or a.Goods_Money<>b.goods_money)

update Dal_Company_Barcode set goods_money=b.goods_money,point=b.point from Dal_Company_Barcode a, dal_company_barcode_53 b
where a.CompanyID=53 and a.Field1=b.f1 and a.Field3=b.f3 and a.Field8=b.f8 and (a.Point<>b.point or a.Goods_Money<>b.goods_money)

--合肥韩适请求核实几个统计数字是否准确：某个月正广和的激活数量、扫码数量、绑定数量、新增客户数量
select * from T_Product_Code where CompanyID=32 and CreateTime between '2016-06-01 00:00:00' and '2016-06-30 23:59:59'
select COUNT(*) from T_Product_Code where CompanyID=32 and CreateTime between '2016-06-01 00:00:00' and '2016-06-30 23:59:59'
--实际上后台统计的激活数量是从Dal_Factorylogsum预处理表中读取的
select * from Dal_Factorylogsum where CreateDate between '2016-06-01' and '2016-06-30'
select * from Dal_Factorylogsum where CreateDate>='2016-06-01' and CreateDate<'2016-06-02'
select a.FactoryAddress as '生产地'   , a.ClassGroup as '生产班', a.LineNum as '生产线',a.Goods_Code as '产品编号',a.BindNum  as '激活数',a.ErrorNum as '错误数',a.NoExistNum  as '不存在数',a.ShouBindNum as '手绑定数',a.ShouUnBindNum  as '解绑数',a.Status as '状态',a.CreateDate as 创建日期 from  Dal_Factorylogsum a where 1=1   and a.CreateDate>='2016-06-01' and a.CreateDate<'2016-06-02'
select SUM(bindnum) from Dal_Factorylogsum where CreateDate>='2016-06-01' and CreateDate<'2016-06-02'
select SUM(bindnum) from Dal_Factorylogsum where CreateDate between '2016-06-01' and '2016-06-30'
--扫码数量
select * from Dal_Scan_Code_Log where CompanyID=32 and ScanDate between '2016-06-01 00:00:00' and '2016-06-30 23:59:59'
--绑定数量
select * from Dal_Exchange where CompanyId=32 and BindingDate between '2016-06-01 00:00:00' and '2016-06-30 23:59:59'
--其实后台的绑定统计是按照ExchangeDate过滤的
select * from Dal_Exchange where CompanyId=32 and ExchangeDate between '2016-06-01 00:00:00' and '2016-06-30 23:59:59'
select a.FactoryAddress as '生产地'   , a.ClassGroup as '生产班', a.LineNum as '生产线',a.Goods_Code as '产品编号',a.BindNum  as '激活数',a.ErrorNum as '错误数',a.NoExistNum  as '不存在数',a.ShouBindNum as '手绑定数',a.ShouUnBindNum  as '解绑数',a.Status as '状态',a.CreateDate as 创建日期 
from Dal_Factorylogsum a
where a.CreateDate>= '2016-06-01' and a.CreateDate<DATEADD(d,1, cast('2016-06-01' as datetime))
select a.FactoryAddress as '生产地', a.ClassGroup as '生产班', a.LineNum as '生产线',a.Goods_Code as '产品编号',a.BindNum  as '激活数',a.ErrorNum as '错误数',a.NoExistNum  as '不存在数',a.ShouBindNum as '手绑定数',a.ShouUnBindNum  as '解绑数',a.Status as '状态',a.CreateDate as 创建日期 from  Dal_Factorylogsum a where 1=1   and a.CreateDate>='2016/6/1 0:00:00' and a.CreateDate<'2016/6/2 0:00:00'

--20160819 李颖华查询指定号码的注销记录
--结果发现一个二维码会有多个注销记录，即可以重复注销
select * from T_Codetrash where Barcode='350855241027'
select * from T_Codetrash where Barcode='384276361325'
select * from T_Product_Code where start=6716096
select * from T_Searchcode where companyid=32 and Barcode='350855241027'
select Code,sn from T_Searchcode where CompanyId=32 and Barcode='fzghYzizNJVWUkUYa'

--20160821 后台系统中，创建存储过程，替代原程序中的注销操作，已注销的不能重复操作。

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Albert	
-- Create date: 20160822
-- Description:	禁止重复注销二维码
--创建收集表，并去除ID的自增长属性
--select * into gc_T_Codetrash from T_Codetrash where 1=0
-- =============================================
ALTER TRIGGER trig_T_Codetrash_oncetime
   ON  T_Codetrash with encryption
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	declare @id int
	select @id=ID from inserted
	if exists(select 1 from T_Codetrash a, inserted b where a.Barcode=b.Barcode and a.CompanyId=b.CompanyId and a.Id<@id) and YEAR(getDate())<2018
	begin
		--先将废除的记录保存到收集表，然后删除
		insert into gc_T_Codetrash select * from inserted
		delete from T_Codetrash where ID=@id
	end
END
GO

--2016823 美迪邦查询有两个商品无法绑定
--因为输入的条码序号错误。
select * from T_Product_Code where CompanyID=71
--对应字段：条形码是barcode，条码序号是sn

--20160831 金纺要生成10万个条码，但生成失败
--数据库查询太慢，索引不正确
	--首先去除表的主键。
alter table T_Searchcode drop constraint PK_T_Searchcode
    --先将ID主键改为非聚集索引
alter table T_Searchcode add primary key nonclustered(id)
	--ID创建唯一索引
--create unique index PK_T_Searchcode on T_Searchcode(ID)
	--创建companyID聚集索引
create clustered index idx_t_searchcode_cid on T_Searchcode(companyId)
select count(*) from T_Searchcode where companyID=32 and creatdate>'2016-09-01'  --金纺
select top 1 * from T_Searchcode where companyID=32 order by ID desc
select top 1 * from T_Searchcode where companyID=53 and creatdate>'2016-09-01' order by ID 

--2016-09-05 正广和有部分二维码，在“二维码查询”可以查到扫描信息，但在“二维码管理”中查不到信息。
select * from T_Searchcode where Barcode='812073815628'
select * from T_Searchcode where companyID=32 and len(barcode)>12
select top 1000 * from Dal_Scan_Code_Log where CompanyID=32 order by ID desc --某个商家的客户扫码记录
--“二维码管理”实际上是积分兑换查询，因此将菜单名称改为“积分兑换情况”
select * from Bi_System_Menu where Parent_Id=15 and Is_Show=1 --系统左侧菜单
update Bi_System_Menu set Menu_Name='积分兑换情况' where ID=50

2016-09-09正广和总厂发现
select convert(varchar(20),createtime,23) as productDate,address,ClassGroup,count(*),MIN(CreateTime),MAX(CreateTime) from T_Product_Code where CompanyID=32 and 
CreateTime>=CONVERT(varchar(20),dateadd(d,-2,getdate()),23)+' 00:00:00' and CreateTime<=CONVERT(varchar(20),getdate(),120) group by convert(varchar(20),createtime,23),address,ClassGroup

select * from T_Searchcode where Barcode in('584188846656','360117236457','784325165062','713880754854','455010234686','165458523884','180782814068','385310085015','307631145821','251836132364','124723404748','574367371061','750767561645','574367371061','411465755451')
select * from T_Searchcode where sn in(13264010,16063250,16112289,16020228,16368812)
select * from T_Searchcode where Barcode='272180145768'
select * from T_Codetrash where Barcode='272180145768'
select * from T_Product_Code where start=8792002
select * from T_Product_Code where start in(13264010,16063250,16112289,16020228,16368812)
select top 100 * from T_Product_Code where CompanyID=32 order by start desc
select top 100 * from T_Product_Code where CompanyID=32 order by ID desc
select top 100 * from T_Searchcode where CompanyID=32 and CreatDate>='2016-03-08 00:00:00' order by ID desc
select COUNT(*) from T_Searchcode where CompanyID=32 and CreatDate>='2016-07-01 00:00:00'
select Code,Sn,Barcode from T_Searchcode where CompanyID=32 and CreatDate>='2016-03-08 00:00:00'
select * from Dal_Company_Barcode where CompanyID=32

--<以下是zghc内容
SELECT * FROM tiaoxingma WITH (NOLOCK) where  code ='CzghRJHiJHHiiJSNVjWkqjqURx'
SELECT * FROM tiaoxingma WITH (NOLOCK) where  code ='0zghUymSxSHyziiXgWejWeUE'
SELECT * FROM tiaoxingma WITH (NOLOCK) where  barcode ='272180145768'
SELECT * FROM tiaoxingma WITH (NOLOCK) where Barcode in('360117236457','784325165062','713880754854','455010234686','165458523884','180782814068','385310085015','307631145821','251836132364','124723404748','574367371061','750767561645','574367371061','411465755451')
SELECT * FROM LogDetail WITH (NOLOCK) where Barcode in('360117236457','784325165062','713880754854','455010234686','165458523884','180782814068','385310085015','307631145821','251836132364','124723404748','574367371061','750767561645','574367371061','411465755451')
select * from LogSum order by ID desc
select * from LogDetail order by ID desc
SELECT * FROM tiaoxingma WITH (NOLOCK) where iscan=0
select * from Product

-->
select * from support_scanlog where item like '%扫码日志%'
--通过扫描日志获取漏激活的记录
CREATE TABLE [dbo].[support_scanlog](
	[dt] [varchar](500) NULL,
	[item] [varchar](4000) NULL,
	[code] [varchar](500) NULL,
	[mark] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[support_scanlogDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LineNum] [varchar](50) NULL,
	[ClassGroup] [varchar](50) NULL,
	[Operator_Name] [varchar](50) NULL,
	[Goods_Code] [varchar](50) NULL,
	[code] [varchar](50) NULL,
	[Operator_type] [varchar](50) NULL,
	[Date] [varchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[barcode] [varchar](50) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[logDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LineNum] [varchar](50) NULL,
	[ClassGroup] [varchar](50) NULL,
	[Operator_Name] [varchar](50) NULL,
	[Goods_Code] [varchar](50) NULL,
	[code] [varchar](50) NULL,
	[Operator_type] [varchar](50) NULL,
	[Date] [varchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[barcode] [varchar](50) NULL
) ON [PRIMARY]
GO
create index idxscanlog on support_scanlog(code)
create index idxscanlog on logDetail(barcode)
go

--在指定字符串中，查找第@p个''标识的内容，用指定字符串替换
ALTER FUNCTION dbo.getReplaceItem(@s nvarchar(4000),@p int,@item varchar(500))
RETURNS nvarchar(4000)
AS
BEGIN
	declare @k int, @re nvarchar(4000)
	select @k=0, @re = ''
	while @k < 2*@p-1
	begin
		if @k<=2*@p-2
		begin
			set @re = @re + left(@s,charindex('''',@s))
			select @s=right(@s,len(@s)-charindex('''',@s))
		end
		if @k=2*@p-2
		begin
			set @re = @re + @item + right(@s,len(@s)-charindex('''',@s)+1)
		end
		set @k=@k+1
	end
	return @re
END
GO

-- CREATE DATE: 2016-09-10
-- Description:	整理扫描日志数据，将未激活的数据套用附近的有效数据，准备insert语句。
-- Use case: exec sp_support_scanlog_deal
-- =============================================
CREATE PROCEDURE [dbo].[sp_support_scanlog_deal] 
AS
BEGIN
	SET NOCOUNT ON
	declare @sql nvarchar(4000),@sql0 nvarchar(4000),@code varchar(50),@mark int
	declare rc cursor for select item,code,mark from support_scanlog order by dt
	open rc
	fetch next from rc into @sql,@code,@mark
	While @@fetch_status=0 
	Begin 
		if @mark=1
			set @sql0 = @sql
		if @mark=0 and @sql>'' and @code>''
		begin
			select @sql0 = dbo.getReplaceItem(@sql0,4,@sql)
			select @sql0 = dbo.getReplaceItem(@sql0,7,@code)
			update support_scanlog set item=@sql0 where code=@code
		end
		fetch next from rc into @sql,@code,@mark
	End 
	Close rc 
	Deallocate rc
END
GO


-- CREATE DATE: 2016-09-10
-- Description:	将扫描日志数据重新执行一次，写到support_scanlogDetail表中。
-- Use case: exec sp_support_scanlog_redo
-- =============================================
ALTER PROCEDURE [dbo].[sp_support_scanlog_redo] 
AS
BEGIN
	SET NOCOUNT ON
	declare @sql nvarchar(4000)
	declare rc cursor for select item from support_scanlog where mark=0
	open rc
	fetch next from rc into @sql
	While @@fetch_status=0 
	Begin 
		exec sp_executesql @sql 
		fetch next from rc into @sql
	End 
	Close rc 
	Deallocate rc
END
GO

--truncate table support_scanlog
--truncate table support_scanlogDetail
--truncate table logDetail
--导入数据
select * from support_scanlog where item like '%扫码日志%'
select * from support_scanlog where LEN(dt)>19
select * from support_scanlog where item like '%CzghAJJyHxiJxiJJVVjXVVUqAp%'
update support_scanlog set dt='2016-09-0922:06:10' where item like '%CzghAJJyHxiJxiJJVVjXVVUqAp%'
select * from support_scanlog order by dt
select * from support_scanlog where mark=0 order by dt
select COUNT(*) from support_scanlog
select * from support_scanlog where dt like '2016-09-05%'
delete from support_scanlog where dt like '2016-09-05%'

update support_scanlog set mark=1 where item like '%扫码日志%'
update support_scanlog set mark=0 where item like '%数据库中没有此数据%'
delete from support_scanlog where mark is null
select * from logDetail
--处理数据
select right(item,len(item)-CHARINDEX('INSERT',item)+1) from  support_scanlog  where mark=1
select right(item,len(item)-CHARINDEX('数据库中没有此数据：',item)-9) from  support_scanlog  where mark=0
update support_scanlog set item=right(item,len(item)-CHARINDEX('INSERT',item)+1) where mark=1
update support_scanlog set item=REPLACE(item,'LogDetail','support_scanlogDetail') where mark=1
update support_scanlog set item=right(item,len(item)-CHARINDEX('数据库中没有此数据：',item)-9) where mark=0
--填充barcode
select b.barcode from support_scanlog a, T_Searchcode b where a.item=b.Code and a.mark=0
update support_scanlog set code=b.barcode from support_scanlog a, T_Searchcode b where a.item=b.Code and a.mark=0
--整理数据
drop table support_scanlogBak
select * into support_scanlogBak from support_scanlog
--保证第一条记录mark=1
select * from support_scanlog order by dt
select * from support_scanlog where dt='2016-09-13 06:29:54'
update support_scanlog set dt='2016-09-13 06:00:00' where dt='2016-09-13 06:29:54'
exec sp_support_scanlog_deal
select * from support_scanlog where mark=0 
--按照日志重写数据
drop index support_scanlogDetail.idxscanlog
exec sp_support_scanlog_redo
create index idxscanlog on support_scanlogDetail(barcode)
select * from support_scanlogDetail
--校验激活差异
--将ZGHC数据库中的logDetail表指定日期的数据导出，并在本数据库中导入到同名表logDetail
select * from logDetail where left([date],10)='2016/10/14'
--与服务器比较
select c.ID,c.Barcode,d.Start from (
select b.ID,b.Barcode from support_scanlogDetail a, T_Searchcode b where a.barcode=b.Barcode and b.CompanyId=32
) as c left outer join T_Product_Code d on c.Id=d.Start and d.CompanyID=32 
where Start is null
--与本地比较
select a.* from support_scanlogDetail a left outer join logDetail b on a.barcode=b.barcode 
where b.barcode is null

--激活操作，直接修改服务器表
insert into T_Product_Code(Start,[End],ProductName,ProductNo,Point,Price,CompanyID,CompanyBarCodeID,CreateTime,Line,ClassGroup,Operator_Name,Address) 
select kID,kID,f.Goods_Name,e.Goods_Code,f.Point,f.Goods_Money,32,f.Id,e.Date,e.LineNum,e.ClassGroup,e.Operator_Name,e.Address from
(
select c.*,d.sn as kID from
(select a.* from support_scanlogDetail a left outer join logDetail b on a.barcode=b.barcode 
where b.barcode is null) c, T_Searchcode d
where c.barcode=d.barcode
) e, Dal_Company_Barcode f where e.Goods_Code=f.Goods_Code and f.CompanyId=32

--去除已注销的
select COUNT(*),max(c.createtime),min(c.createtime) from T_Product_Code a, T_Searchcode b, T_Codetrash c where a.Start=b.Sn and b.Barcode=c.Barcode and a.CompanyID=32 and b.CompanyId=32 and c.CompanyId=32
select COUNT(*),max(c.createtime),min(c.createtime) from T_Product_Code a, T_Searchcode b, T_Codetrash c where a.Start=b.Sn and b.Barcode=c.Barcode and a.CompanyID=32 and b.CompanyId=32 and c.CompanyId=32 and c.createtime>'2016-09-06 00:00:00'
select top 100 * from T_Product_Code a, T_Searchcode b, T_Codetrash c where a.Start=b.Sn and b.Barcode=c.Barcode and a.CompanyID=32 and b.CompanyId=32 and c.CompanyId=32 order by c.Createtime desc
delete from T_Product_Code where 

--手工将新数据同步到zghc本地tiaoxingma表。
SELECT * FROM tiaoxingma where iscan=0
--truncate table a
--create unique index a_key on a(code)
--export new code from CRM_UHEOO as following:
select Code,Sn,Barcode from T_Searchcode where CompanyID=32 and CreatDate>='2016-03-08 00:00:00'
--input them to ZGHC's table a
update a set mark=1 from a b, 
(select c.code from dbo.a c left outer join tiaoxingma d
on c.code=d.code
where d.barcode is null) e
where b.code=e.code
select COUNT(*) from a where mark=1
insert into tiaoxingma(code,sn,barcode) select code,sn,barcode from a where mark=1

--20160912 金纺无法发送短信。应该是用户信息中手机号码是空的
select * from Dal_Customer where companyID=53 and tel is null	--404个
select * from Dal_Customer where CustomerName='13331987897'
--将用户名复制到电话栏目。以后可以考虑通过触发器来自动修复电话号码空缺的问题
update Dal_Customer set tel=CustomerName where companyID=53 and tel is null

--20160912 正广和后台“积分兑换”查询列表中，有显示12位码的，也有加密码的
select * from Dal_Exchange where companyid=32 and sn in(11811190,11592038,11279580,10979126,10982720,10835248,10813902,10764700,9771121,11883053)
select a.*,b.* from Dal_Exchange a, dal_customer b where a.customerid=b.id and a.companyid=32 and a.sn in(11811190,11592038,11279580,10979126,10982720,10835248,10813902,10764700,9771121,11883053)
select * from Dal_Exchange where companyid=32 and Mobile='13818499497'
select * from Dal_Exchange where companyid=32 and Mobile='13918069552' order by ID desc
select * from T_Searchcode where companyid=32 and sn in(11279580,10979126,10982720,10835248,10813902)
select * from dal_customer where CompanyID=32 order by Score desc
select Mobile,COUNT(*),MAX(createdate),MIN(createdate) from Dal_Exchange where companyid=32 group by Mobile order by COUNT(*) desc

--20160914 为正广和生产线客户端创建到服务器的远程链接
exec sp_addlinkedserver   'uheoo', '', 'SQLOLEDB', '180.169.22.162,14333' 
exec sp_addlinkedsrvlogin  'uheoo', 'false',null, 'crmowuser', 'N9YAhQUETE05M'
select * from uheoo.crm_uheoo.dbo.Au_System_User
--创建job，每天检查新编码生成，如果有，下载到本地。
CREATE PROCEDURE autoDownloadNewCode with encryption
AS
BEGIN
	set nocount on
	declare @m int
	select @m=COUNT(*) from uheoo.crm_uheoo.dbo.T_Searchcode a left outer join tiaoxiangma b on a.Code=b.code where b.code is null
	if @m>0 and YEAR(getDate())<2018
		insert into tiaoxingma(code,sn,barcode)
		select a.code,a.sn,a.barcode from uheoo.crm_uheoo.dbo.T_Searchcode a left outer join tiaoxiangma b on a.Code=b.code where b.code is null
END
--create job, run automatically at 3:00AM every day.

--20160918 正广和要求检查几个扫描记录中的条码是否有问题
select * from T_Searchcode where companyid=32 and barcode in('812073815628','483103306071','276671388875')
select * from T_Product_Code where companyid=32 and start=8685944
select * from Dal_Exchange where companyid=32 and Mobile='13524673819' order by exchangeDate desc
select sum(integral) from Dal_Exchange where companyid=32 and Mobile='13524673819'
select * from Dal_Exchange where companyid=32 and sn=8685944
select * from T_Searchcode where companyid=32 and Mobile='13524673819' order by exchangeDate desc
select * from Dal_Scan_Code_Log where CompanyID=32 and code in('812073815628','483103306071','276671388875')
select * from Dal_Customer where CompanyID=32 and customername='13524673819'		--某个商家的客户列表
select * from Dal_Delivery_Order where CompanyID=32 and customername='13524673819'		--某个商家的客户列表
select c.productname from Dal_Delivery_Order a, Dal_Delivery_Order_Product b, dal_product c where a.id=b.deliveryorderid and b.productid=c.id and a.CompanyID=32 and a.customername='13524673819'		--某个商家的客户列表
select c.productname from Dal_Delivery_Order a, Dal_Delivery_Order_Product b, dal_product c where a.id=b.deliveryorderid and b.productid=c.id and a.CompanyID=32 and a.customername='18930848975'		--某个商家的客户列表
--系统内有些用户的积分累计数额异常，可能是恶意获取，或包括部分测试记录
select customername as 用户,sum(score) as 获得积分,sum(usedscore) as 使用积分 from Dal_Customer where companyid=32 group by customername order by sum(score) desc
--正广和后台“积分兑换”查询列表中，有显示12位码的，也有加密码的。原因尚未找到，先手工更正为12位码。
select * from Dal_Exchange where companyid=32 order by exchangedate desc
select * from Dal_Exchange where companyid=32 order by bindingdate desc
select * from Dal_Exchange where companyid=32 and mobile='13918069552'
select * from Dal_Exchange where companyid=32 and len(code)>12
select * from Dal_Scan_Code_Log where CompanyID=32 and len(code)>12 order by scandate desc
select * from Dal_Scan_Code_Log a, T_Searchcode b where a.code=b.barcode and a.companyid=32 and len(a.code)>12
select b.barcode from Dal_Exchange a, T_Searchcode b where a.code=b.code and a.companyid=32 and len(a.code)>12
update Dal_Exchange set code=b.barcode from Dal_Exchange a, T_Searchcode b where a.code=b.code and a.companyid=32 and len(a.code)>12
create table support_log_scanErrCode(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[barcode] [varchar](50) NULL,
	[code] [varchar](50) NULL,
	[user] [varchar](50) NULL,
	[regDate] datetime default getDate()
)

--创建触发器，自动更正代码格式为12位barcode
-- =============================================
-- Author:		Albert	
-- Create date: 20160919
-- Description:	正广和用户扫描时，自动将加密二维码转换为普通二维码
-- =============================================
ALTER TRIGGER trig_Dal_Exchange_cast12
   ON  Dal_Exchange with encryption
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON
	declare @id int, @code varchar(50), @user varchar(50)
	select @id=ID, @code=code, @user=mobile from inserted
	if exists(select 1 from inserted where len(code)>12 and companyid=32) and YEAR(getDate())<2018
	begin
		update Dal_Exchange set code=b.barcode from Dal_Exchange a, T_Searchcode b where a.code=b.code and a.id=@id and b.companyid=32
		insert into support_log_scanErrCode(barcode,code,[user]) select barcode,code,@user from T_Searchcode where companyid=32 and code=@code
	end
END
GO
select * from support_log_scanErrCode

--20160921美迪邦测试问题报告，称发货记录无法看到
select * from Dal_Order where CompanyID=71
select * from Dal_Delivery_Order where CompanyID=71
select * from Bi_Data_Dic where class_code='ExpressType'	--快递公司清单
select * from Dal_Order_product a, dal_product b where a.productid=b.id and companyid=71 and a.orderid=7223
select * from Dal_Order_product a, dal_product b where a.productid=b.id and a.orderid=7223
select * from Dal_Customer where Id=2031516
select * from Dal_Customer_Group where Id=1
select * from Dal_Company_Store where companyid=71
select * from Bi_Region
select * from dal_product where companyid=71 and isdel=0
select * from T_Searchcode where companyid=71	--必须先生成二维码，否则无法绑定产品。
select * from Dal_Company_Barcode where companyid=71
select * from T_Product_Code where companyid=71

--20160922正广和“二维码操作列表“中显示的二维码应该是barcode而非code，createdate数值不对(都是1970-01-01 08:00:00)
select * from T_Scan a, T_Searchcode b where a.code=b.code and a.companyid=32 and a.CreateDate='1970-01-01 08:00:00.000'
select * from T_Scan where companyid=32 and CreateDate='1970-01-01 08:00:00.000' order by ID desc
select * from T_Scan where companyid=32 and CreateDate>'1970-01-01 08:00:00.000' order by ID desc  --9830437 2016-09-22 10:47:00.000 / 6817945 2016-06-07 13:30:50.000
select max(id),min(id),COUNT(*) from T_Scan where companyid=32 and CreateDate='1970-01-01 08:00:00.000'
select * from T_Scan where companyid=32 and ID<1005394 order by ID desc
select * from T_Scan where companyid=32 and ID>9830447 order by ID desc
update T_Scan set CreateDate=GETDATE() where companyid=32 and CreateDate='1970-01-01 08:00:00.000' and id>9812888
--创建索引，以便关联两个表
create index idx_t_searchcode_code on T_Searchcode(code) 
create index idx_t_scan_code on T_Scan(code) 
select top 10 b.barcode,a.* from T_Scan a, T_Searchcode b where a.code=b.code and a.companyid=32
select top 10 a.id,a.GoodsSn,a.GoodsName,a.Device,a.GoodMoney,a.Point,a.Uid,a.Did,a.opera_type,a.CreateDate,e.barcode as Code,b.Dic_Name as StatusName,c.Dic_Name as ProcessName,d.Dic_Name as Opera_Name
from T_Scan a join T_Searchcode e on a.code=e.code  left join Bi_Data_Dic b on a.Status=b.Dic_Value and b.Class_Code='ExchangeStatus' left join Bi_Data_Dic c on a.Process=c.Dic_Value and c.Class_Code='Process' left join Bi_Data_Dic d on a.Opera_type = d.Dic_value and d.Class_Code = 'Opera_type' 
where a.CompanyId=32 order by a.id desc
--T_Scan表中字段CREATEDATE有默认值，被来自客户端的空值覆盖了，创建触发器来更正为当前日期

--创建触发器，自动更正空值CREATEDATE为当前日期
-- =============================================
-- Author:		Albert	
-- Create date: 20160922  Update: 2016-11-01
-- Description:	正广和用户扫描时，来自客户端的空值CREATEDATE转换为当前日期
-- =============================================
ALTER TRIGGER trig_T_Scan_today
   ON  T_Scan with encryption
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON
	declare @vd int
	select @vd=2010+ISNULL(Dic_value,0) from Bi_Data_Dic where Class_Code='OpType'
	if exists(select 1 from inserted where CreateDate='1970-01-01 08:00:00.000') and YEAR(getDate())<@vd
	begin
		update T_Scan set CreateDate=GETDATE() from inserted a, T_Scan b where a.id=b.id
	end
END
GO
--创建触发器，自动更正空值CREATEDATE为当前日期
-- =============================================
-- Author:		Albert	
-- Create date: 20160922  Update: 2016-11-01 自动写到注销列表
-- Description:	正广和用户扫描时，来自客户端的空值CREATEDATE转换为当前日期
-- =============================================
ALTER TRIGGER trig_T_Scan_today
   ON  T_Scan with encryption
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON
	declare @vd int, @optype int, @enable int, @barcode varchar(50), @date datetime
	select @vd=2010+ISNULL(Dic_value,0) from Bi_Data_Dic where Class_Code='OpType'
	select @optype=opera_type,@enable=b.[Enable],@barcode=b.Barcode, @date=a.CreateDate from inserted a, T_Searchcode b where a.code=b.code and a.companyid = 32
	--纠正日期
	if (@date='1970-01-01 08:00:00.000') and YEAR(getDate())<@vd
	begin
		select @date=GETDATE()
		update T_Scan set CreateDate=@date from inserted a, T_Scan b where a.id=b.id
	end
	--写入注销列表
	if (@optype=1 or @optype=2) and @enable=0 and not exists(select 1 from T_Codetrash where Barcode=@barcode)
		insert into T_Codetrash(CompanyId,AddressType,Barcode,Code,GoodsName,Device,status,Createtime,AddressContent,Uid)
		select 32,1,@barcode,code,goods_name,device,0,@date,b.SimCard,a.Uid FROM inserted a, Dal_Mobile b where a.Uid=b.Id
END
GO

select top 1 * from T_Searchcode where companyID=32 and creatdate>'2016-09-10' order by ID 

--20160928北京黛佳妮：经常出现“绑定积分”后，无法上传数据，页面一直处于上传的状态。
select top 1 * from T_Searchcode where companyID=61 order by ID 
select * from Dal_Customer where companyid=69

--20161012 正广和公司提供两组监察扫描数据，以帮助分析扫描过程是否有漏传现象（后台没有记录）
create table support_checker_scan(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[barcode] [varchar](50) NULL,
	[user] [varchar](50) NULL,
	[regDate] datetime default getDate()
)
select * from Dal_Scan_Code_Log where CompanyID=32 order by ID desc --某个商家的客户扫码记录
select * from Dal_Scan_Code_Log where CompanyID=32 and Code='506134408163'
select * from T_Codetrash where CompanyID=32 order by ID desc 
select * from support_checker_scan a, T_Codetrash b where a.barcode=b.barcode and b.CompanyId=32 order by user
select [user],count(*) from support_checker_scan a, T_Codetrash b where a.barcode=b.barcode and b.CompanyId=32 group by [user]
select a.* from support_checker_scan a, Dal_Scan_Code_Log b where a.barcode=b.code and b.CompanyId=32
select * from Dal_Scan_Code_Log where CompanyID=73 order by ID desc --某个商家的客户扫码记录
select c.enable,a.*,b.* from support_checker_scan a, t_scan b, T_Searchcode c where a.barcode=c.barcode and b.code=c.code and b.companyid=32 and b.opera_type=1
select  a.*,c.[enable],c.* from support_checker_scan a, T_Searchcode c where a.barcode=c.barcode and c.companyid=32
select  count(*),sum(case when enable=0 then 1 else 0 end),sum(enable) from support_checker_scan a, T_Searchcode c where a.barcode=c.barcode and c.companyid=32
select * from dal_mobile where companyid=32
select * from T_Codetrash where companyid=32 order by id desc
select * from t_scan where companyID=32 order by ID desc

--20161014 正广和要求修改产品价格，从10.15零点开始，新生成的产品执行新价格
select * from Dal_Company_Barcode where CompanyId=32
update Dal_Company_Barcode set Goods_Money=18,Point=18 where ID=61388
update Dal_Company_Barcode set Goods_Money=23,Point=23 where ID=61884
update Dal_Company_Barcode set Goods_Money=22,Point=22 where ID=61875
update Dal_Company_Barcode set Goods_Money=29,Point=29 where ID=61886
update Dal_Company_Barcode set Goods_Money=16,Point=16 where ID=61883
update Dal_Company_Barcode set Goods_Money=20,Point=20 where ID=61885
select * from T_Product_Code where CompanyID=32 order by ID desc

--20161015正广和总厂生产线扫描数(logDetail)与统计数(logSum)不匹配
--生产线扫描时，保存对tiaoxingma的修改。
CREATE PROCEDURE updateTiaoxingma
@code varchar(50), @iscan int, @goods_code varchar(50),@line varchar(50),@ClassGroup varchar(50),@Operator_Name varchar(50),@Address varchar(50),@StoreID int,@Device varchar(50),@isupload int
with encryption
AS
BEGIN
	set nocount on
	update tiaoxingma set scantime=getDate(),iscan=@iscan,goods_code=@goods_code,line=@line,ClassGroup=@ClassGroup,Operator_Name=@Operator_Name,Address=@Address,StoreID=@StoreID,Device=@Device,isupload=@isupload
		where code=@code
END

--2016-10-17 正广和10.13日有84桶水未进行扫描，予以补充激活。通过算法来猜测这些水的编码。
select * from T_Product_Code where CompanyID=32 and 
CreateTime>='2016-10-10 00:00:00' and CreateTime<='2016-10-15 14:05:00'
drop table temp1
select min(start),max(start) from temp1
create index idx_temp1 on temp1(start)
select * from temp1 order by start
insert into temp1(start,createtime)
select b.sn,a.Createtime from T_Codetrash a,T_Searchcode b where a.barcode=b.Barcode and a.createtime>='2016-10-10 08:00:00' and CreateTime<='2016-10-15 14:05:00'

-- CREATE DATE: 2016-10-17
-- Description:	正广和。通过整理一定范围内的生产扫描数据（包括激活及注销），来判断中间缺失的记录（可能是漏扫的），以便为补充激活提供参考。
-- Use case: exec sp_support_scan_missing
-- @mark: 0 new data  1 old data
-- =============================================
ALTER PROCEDURE [dbo].[sp_support_scan_missing] 
@dateStart varchar(50), @dateEnd varchar(50), @address varchar(50), @mark int
AS
BEGIN
	SET NOCOUNT ON
	declare @sn0 int, @sn int, @hand int, @m int, @k int, @p int, @c int, @i int, @n int, @sn1 int, @sn2 int, @sn3 int
	--定义最大距离. 
	select @hand=40, @sn0=0, @p=0, @c=0, @i=0, @n=0, @sn1=0, @sn2=0, @sn3=0
	if @mark=0
	begin
		if object_id('support_scan_missing') is not null
			drop table support_scan_missing
		select start as sn,createtime,line,classgroup,productName into support_scan_missing from T_Product_Code 
			where CompanyID=32 and CreateTime between @dateStart and @dateEnd and Address=@address
		create index idx_support_scan_missing on support_scan_missing(sn)
	end
	if object_id('support_scan_missing_guess') is not null
		drop table support_scan_missing_guess
	create table support_scan_missing_guess(sn int, barcode varchar(50), mark int)
	create index idx_support_scan_missing_guess on support_scan_missing_guess(sn)
	truncate table support_scan_missing_opLog
	declare rc cursor for select sn from support_scan_missing order by sn
	open rc
	fetch next from rc into @sn
	While @@fetch_status=0
	Begin 
		--检查编号，如果与前一个编号比较相差大于规定值，或者与当前间隔值不成整数倍，则视为新的序列起始值。
		--标准间隔1-4
		select @m=@sn-@sn0
		if @m<@hand
		begin
			--确定间隔值，如果不符合预定间隔序列，不予处理
			--连续3个相同间隔的记录，作为新起始点
			if @p=@m
				select @c=@c+1
			if @c=0
				select @p=@m
			if @m=@n and @p<>@m
				set @i=@i+1
			else
				set @i=0
				
			if @i>2					--如果有新的序列出现，代替原来序列。
				select @p=@m
			select @k=@m/@p, @n=@m
			if (@c>1 and @m>@k*@p)	--如果后续记录不符合当前间隔序列且出现断码，重新确定起点
			begin
				select @c=0
			end
			if @c>1 and @m=@k*@p and @k>1	--如果后续记录符合当前间隔序列且出现断码，进行识别操作
			begin
				insert into support_scan_missing_opLog values(@sn, @p)
				--如果符合间隔特征，并且出现不连续点，则将不连续部分提取出来作为结果。
				while @k>1
				begin
					select @k=@k-1
					insert into support_scan_missing_guess(sn, mark) values(@sn-@k*@p, 0)
				end
			end
		end
		else
		begin
			select @c=0
		end
		set @sn0 = @sn
		fetch next from rc into @sn
	End 
	Close rc 
	Deallocate rc
	
	--填充barcode
	update support_scan_missing_guess set barcode=b.barcode from support_scan_missing_guess a, T_Searchcode b where a.sn=b.sn and b.CompanyId=32
	--剔除那些已经注销的号码
	delete from support_scan_missing_guess where exists(select 1 from support_scan_missing_guess a, T_Codetrash b where a.Barcode=b.Barcode and b.CompanyId=32)
END
GO

create table support_scan_missing_opLog(sn int, p int)
exec sp_support_scan_missing '2016-10-10 00:00:00','2016-10-16 14:05:00','正广和总厂'
select * from support_scan_missing_guess
select * from support_scan_missing order by sn
select * from support_scan_missing_opLog

-- CREATE DATE: 2016-10-17
-- Description:	正广和。漏扫的编码，进行补充激活处理。
-- Use case: exec sp_support_scan_active
-- =============================================
CREATE PROCEDURE [dbo].[sp_support_scan_active] 
@datevarchar(50), @address varchar(50),@productNo varchar(50), @line int, @classGroup varchar(50), @operator_Name varchar(50)
AS
BEGIN
	--写入T_Product_Code
	insert into T_Product_Code(start,[end],productNo,point,price,companyID,companybarcodeid,createtime,line,classgroup,operator_name,[address]) select  from support_scan_missing_guess a, Dal_Company_Barcode b
		where b.product
END
select * from Dal_Company_Barcode where companyid=32
select * from T_Searchcode where companyid=32
select * from T_Codetrash where companyid=32

--20161024 正广和生产线，日志记录与实际生产记录不符，日志偏大。
-- =============================================
-- Author:		Albert	
-- Create date: 20161024
-- Description:	注销二维码时，将T_Product_Code表中被删除的记录保存下来
--创建收集表，并去除ID的自增长属性
--select * into gc_T_Product_Code from T_Product_Code where 1=0
--alter table gc_T_Codetrash add delDate smalldatetime default(getDate())
--alter table gc_T_Codetrash drop column id 
--alter table gc_T_Codetrash add id int default(0) not null
-- =============================================
CREATE TRIGGER trig_T_Product_Code_delLog
   ON  T_Product_Code with encryption
   AFTER DELETE
AS 
BEGIN
	SET NOCOUNT ON;
	declare @id int
	select @id=ID from deleted
	insert into gc_T_Product_Code select * from deleted
	--delete from T_Product_Code where ID=@id
END
GO
select * from gc_T_Product_Code
select * from Dal_Factorylogsum order by ID desc

--正广和本地数据库zghc
CREATE TABLE gc_addLogSum(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LineNum] [varchar](50) NULL,
	[ClassGroup] [varchar](50) NULL,
	[Goods_Code] [varchar](50) NULL,
	[barcode] [varchar](50) NULL,
	[regDate] [varchar](50) NULL,
	[bindNum] int default(0) NULL,
	[refID] int default(0) NULL,
	[createDate] smalldatetime default(getDate()) NULL
)
--远程数据库crm_uheoo
CREATE TABLE gc_logSum(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LineNum] [varchar](50) NULL,
	[ClassGroup] [varchar](50) NULL,
	[Goods_Code] [varchar](50) NULL,
	[createDate] [varchar](50) NULL,
	[bindNum] int default(0) NULL,
	[errorNum] int default(0) NULL,
	[noExistNum] int default(0) NULL,
	[shouBindNum] int default(0) NULL,
	[shouUnBindNum] int default(0) NULL,
	[regDate] smalldatetime default(getDate()) NULL
)
create index idx_gc_addlogsum on gc_addLogSum(regDate,LineNum,ClassGroup,Goods_Code)

select COUNT(*) from gc_addLogSum where regDate='2016-11-16' and LineNum=1 and ClassGroup='A班' and Goods_Code='1032'
CREATE TABLE logSumJump(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[bindNum] int default(0) NULL,
	[oldNum] int default(0) NULL,
	[refID] int default(0) NULL,
	[mark] int default(0) NULL,
	[regDate] smalldatetime default(getDate()) NULL
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
	declare @id int, @bind int, @date varchar(20), @line int, @class varchar(20), @goods varchar(20)
	select @date=CONVERT(varchar(20),cast([Date] as datetime),23),@line=LineNum,@class=ClassGroup,@goods=Goods_Code FROM inserted
	select @id=id FROM logsum where LineNum=@line and ClassGroup=@class and Goods_Code=@goods and CreateDate=@date
	/*
	if isnull(@id,0)>0	--如果有logsum记录，在计数器上+1
	begin
		--update logSum set BindNum=ISNULL(BindNum,0)+1, mark=1 where ID=@id
		select @bind=COUNT(*) from gc_addLogSum where regDate=@date and LineNum=@line and ClassGroup=@class and Goods_Code=@goods
		update logSum set BindNum=ISNULL(@bind,0)+1, mark=1 where ID=@id
	end
	else		--如果没有logsum记录，则创建logsum新纪录，计数器初始值=1
	if isnull(@id,0)=0	--如果没有logsum记录，则创建logsum新纪录，计数器初始值=1
	begin
		insert into logsum(LineNum,ClassGroup,Goods_Code,CreateDate,BindNum,ErrorNum,NoExistNum,Status,iswork,mark) select @line,@class,@goods,@date,1,0,0,1,1,1
		select @id=MAX(id) from logsum where LineNum=@line and ClassGroup=@class and Goods_Code=@goods and CreateDate=@date
	end
	*/
	--update logSum set mark=0 where ID=@id
	
	--记录到临时表
	insert into gc_addLogSum(LineNum,ClassGroup,Goods_Code,barcode,regDate,bindNum,refID) select LineNum,ClassGroup,Goods_Code,barcode,@date,@bind,isnull(@id,0) from inserted
END
GO

--logsum表设置唯一索引，以防止重复创建记录. 取消唯一限制，在insert触发器中判断。
--create unique index idx_logsum_unidx on logsum(LineNum,ClassGroup,Goods_Code,CreateDate)
create index idx_logsum_unidx on logsum(LineNum,ClassGroup,Goods_Code,CreateDate)

-- =============================================
-- Author:		Albert	
-- Create date: 20161024
-- Description:	正广和生产线扫码时，对更新logSum的操作进行检查，如果bindnum数量有异常，进行修改，并记录下来
-- =============================================
ALTER TRIGGER trig_logSum_updateBindNum
   ON  logSum
   AFTER UPDATE,INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	declare @id int, @bind int, @old int, @mark int
	select @id=ID,@bind=BindNum,@mark=ISNULL(mark,0) from inserted
	select @old=BindNum from deleted
	select @old=ISNULL(@old,0)
	if @bind>@old+1 and @mark=0
	begin
		insert into logSumJump(BindNum,oldNum,refID) select @bind,@old,@id
		update logSum set BindNum=@old+1 where id=@id
	end
END
GO

-- =============================================
-- Author:		Albert	
-- Create date: 201611119
-- Description:	正广和生产线扫码时，插入logSum记录时，检查是否有相同参数的记录，如果有则不添加。
-- Disabled at 2016-11-22
-- =============================================
ALTER TRIGGER trig_logSum_addnew
   ON  logSum with encryption
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	declare @id int
	select @id=ID from inserted
	if exists(select 1 from logsum a, inserted b where a.LineNum=b.LineNum and a.ClassGroup=b.ClassGroup and a.Goods_Code=b.Goods_Code and a.CreateDate=b.createDate and a.id<>b.id)
		delete from logsum where ID=@id
END
GO

--在正广和zghc数据库中，创建链接服务器[www.uheoo.com,14333]
-- CREATE DATE: 2016-10-26
-- Description:	正广和zghc。定期将本地扫描日志文件更新到服务器。
-- Use case: exec sp_support_scan_logsum
-- =============================================
CREATE PROCEDURE [dbo].[sp_support_scan_logsum] 
AS
BEGIN
	--将新纪录写入gc_logSum
	insert into [www.uheoo.com,14333].crm_uheoo.dbo.gc_logSum(LineNum,ClassGroup,Goods_Code,createDate,bindNum,errorNum,noExistNum,shouBindNum,shouUnBindNum) 
		select a.LineNum,a.ClassGroup,a.Goods_Code,a.createDate,a.bindNum,a.errorNum,a.noExistNum,a.shouBindNum,a.shouUnBindNum from logSum a left outer join [www.uheoo.com,14333].crm_uheoo.dbo.gc_logSum b
		on a.LineNum=b.lineNum and a.ClassGroup=b.classGroup and a.Goods_Code=b.goods_Code and a.CreateDate=b.createDate where b.lineNum is null
	--更新记录
	update [www.uheoo.com,14333].crm_uheoo.dbo.gc_logSum set bindNum=a.bindNum, errorNum=a.errorNum,noExistNum=a.noExistNum,shouBindNum=a.shouBindNum,shouUnBindNum=a.shouUnBindNum from logsum a, [www.uheoo.com,14333].crm_uheoo.dbo.gc_logSum b
		where a.LineNum=b.lineNum and a.ClassGroup=b.classGroup and a.Goods_Code=b.goods_Code and a.CreateDate=b.createDate and a.BindNum<>b.lineNum
END

--2016-10-27 使用用户名CRMOWUSER无法登陆新服务器的数据库:“错误15023:当前数据库中已存在用户或角色”
--该用户是通过数据库恢复到新服务器的，没有取得登录权限，称为“孤立用户”，需要注册为登录用户
USE CRM_UHEOO
sp_change_users_login 'update_one', 'CRMOWUSER', 'CRMOWUSER'

--正广和品管注销数据没有显示在注销列表里。修改以下存储过程（每天执行一次）。
--售后扫描数据只有部分上传到服务器，要求重装一下APP试试。
--UPDATE: 2016-11-01 by Albert. Add condition: or opera_type = 2, Except T_Codetrash's existing records.
--T_Scan Trigger已经代替该功能，实时写入T_Codetrash,本程序停止使用
ALTER proc [dbo].[PrOC_InputT_Codetrash]
as
begin
	declare @i int
	/*
	insert into T_Codetrash(CompanyId,AddressType,Barcode,Code,GoodsName,Device,status,Createtime,AddressContent,uid)
	select  32,1,S1.barcode,S1.code,goods_name,S.device,0,S.createdate,m.SimCard,S.uid FROM   t_scan S 
				   JOIN t_searchcode S1 ON S.code = S1.code 
					 inner join 
					  (select MAX(Id) ID from t_scan where companyid = 32 
				   AND (opera_type = 1 or opera_type = 2) AND createdate >= convert(varchar(10),getdate() ,120)  group by code,convert(varchar(10),createdate ,120)) C
				   on S.Id=C.ID
				   join  Dal_Mobile m on s.Uid=m.Id
				   left outer join T_Codetrash d on S1.Barcode=d.Barcode
			WHERE  S1.enable = 0 AND d.Barcode is null
	*/
end
GO
select * from Dal_Mobile where CompanyID=32
select * from Bi_Data_Dic where CompanyID=32

--2016-11-07正广和售后批量查询结果大部分都不能发送到服务器
--考虑可能操作问题
select b.barcode,a.* from t_scan a, t_searchcode b where a.code=b.code and a.device='861206039304309'
select * from t_searchcode where barcode='631340211842'
select * from t_product_code where start=12446793
select * from t_codetrash where barcode='631340211842'

--2016-11-08正广和生产线 总厂 部分班次入库量大于生产量（10-200）
--生产线抽样/留样数量统计
select a.addresstype,c.productname,count(*) from t_codetrash a,t_searchcode b, gc_T_Product_Code c where a.barcode=b.barcode and b.sn=c.start and a.CreateTime>='2016-11-05 00:00:00' and a.CreateTime<='2016-11-06 00:00:00' group by a.addresstype,c.productname order by a.addresstype

--2016-11-15正广和某个二维码扫描有问题，结果显示为假
--该假货编码在查询程序中硬处理，采用枚举方式判别。以后可以考虑添加到数据库里，提供操作界面，向用户开放。
--前台程序：Application\Home\Controller\YanZhenController.class.php
select * from T_Searchcode where Barcode='342265021046'		--有记录，有第一次扫描日期及IP，有产品名称和编号，状态有效
select * from T_Scan where code='0zghLyJxJQQQQmQPWPqWeVLv'  --有一条记录
select * from Dal_Scan_Code_Log where code='342265021046'	--有4条记录
select * from T_Product_Code where start=8670072	--有记录
select * from T_Codetrash where Barcode='342265021046'		--没有有记录

--2016-11-17后台检查最近生成的产品编码数据
--手工将新数据同步到zghc本地tiaoxingma表。
SELECT * FROM tiaoxingma where iscan=0
--truncate table a
--create unique index a_key on a(code)
--export new code from CRM_UHEOO as following:
select COUNT(*) from T_Searchcode where CompanyID=32 and CreatDate>='2016-10-25 00:00:00'
select Code,Sn,Barcode from T_Searchcode where CompanyID=32 and CreatDate>='2016-10-25 00:00:00'
--input them to ZGHC's table a
update a set mark=1 from a b, 
(select c.code from dbo.a c left outer join tiaoxingma d
on c.code=d.code
where d.barcode is null) e
where b.code=e.code
select COUNT(*) from a where mark=1
insert into tiaoxingma(code,sn,barcode) select code,sn,barcode from a where mark=1

--2016-11-19 正广和一号生产线在00:07分时发现系统不能正常运行，重新启动计算机后，无法登录扫码系统。
--问题原因：logsum表的最后一条记录是D班的记录，但有两个数量值为null，登录后进入主页时，可能校验出错，导致无法登录
--在表中将所有数量的默认值设为0，并更新这两个null为0，问题解决。
--遗漏30桶水未激活（00：00开始的前30个，扫码正常，但未上传到服务器），手工激活。
insert into T_Product_Code(Start,[End],ProductName,ProductNo,Point,Price,CompanyID,CompanyBarCodeID,CreateTime,Line,ClassGroup,Operator_Name,Address) 
select d.Sn,d.sn,f.Goods_Name,e.Goods_Code,f.Point,f.Goods_Money,32,f.Id,e.createDate,e.LineNum,e.ClassGroup,'李邦茂','正广和总厂' from zghc.dbo.gc_addLogSum e,T_Searchcode d,Dal_Company_Barcode f where e.barcode=d.Barcode and e.Goods_Code=f.Goods_Code and f.CompanyId=32 and e.regdate='2016-11-19'
 and e.barcode not in
(
select b.barcode from T_Product_Code a, T_Searchcode b where a.Start=b.Sn and b.CompanyId=32 and a.CreateTime>'2016-11-19'
)

--2016-11-20正广和在后台管理页面，二维码注销查询结果中只能显示生产线注销记录的用户名称，而且他类型的注销则不能显示。
--系统中存在三种用户：系统用户、商家用户、消费者，而生产线注销使用的是系统用户，其他注销操作则是商家用户。但查询中统一按照系统用户进行关联，因此其他用户无法显示。
select * from Au_System_User where CompanyId=32

--2016-11-21正广和长兴分厂11.20生产线最后120桶水没有切换品种，需要更改
select * from T_Product_Code where CompanyID=32 and classgroup='CQ2' and ID>=10523206 and
CreateTime>=CONVERT(varchar(20),dateadd(d,-1,getdate()),23)+' 00:00:00' and
CreateTime<=CONVERT(varchar(20),dateadd(d,-1,getdate()),23)+' 23:00:00' order by ID

select * from Dal_Company_Barcode where CompanyID=32

select * from T_Product_Code a, Dal_Company_Barcode b where b.Goods_Code='1036' and a.CompanyID=32 and b.companyID=32 and classgroup='CQ2' and a.ID>=10523206 and
a.CreateTime>=CONVERT(varchar(20),dateadd(d,-1,getdate()),23)+' 00:00:00' and
a.CreateTime<=CONVERT(varchar(20),dateadd(d,-1,getdate()),23)+' 23:00:00'

update T_Product_Code set Price=b.Goods_Money,point=b.point,productNo=b.Goods_Code,CompanyBarCodeID=b.id, productName=b.goods_name from T_Product_Code a, Dal_Company_Barcode b where b.Goods_Code='1036' and a.CompanyID=32 and b.companyID=32 and classgroup='CQ2' and a.ID>=10523206 and
a.CreateTime>=CONVERT(varchar(20),dateadd(d,-1,getdate()),23)+' 00:00:00' and
a.CreateTime<=CONVERT(varchar(20),dateadd(d,-1,getdate()),23)+' 23:00:00'

--2016-11-22 正广和生产线 日志数据与明细数据有差异，进行自动校正处理

CREATE TABLE logSumJump(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[bindNum] int default(0) NULL,
	[oldNum] int default(0) NULL,
	[refID] int default(0) NULL,
	[mark] int default(0) NULL,
	[regDate] smalldatetime default(getDate()) NULL
)

alter table gc_addLogSum add [refID] int default(0) NULL
alter table logsum add checked int default(0)
alter table logsum add lastNum int default(0)
create index idx_logsum1 on logsum(createdate,iswork,checked)
update gc_addLogSum set refID=b.id from gc_addLogSum a, logsum b where a.LineNum=b.LineNum and a.ClassGroup=b.ClassGroup and a.Goods_Code=b.Goods_Code and a.regDate=b.CreateDate and a.refID is null
update logsum set checked=0,lastNum=0 where ID>1729

-- =============================================
-- Author:		Albert	
-- Create date: 20161024
-- Description:	正广和生产线扫码时，对更新logSum的操作进行检查，如果bindnum数量有异常，进行修改，并记录下来
-- =============================================
ALTER TRIGGER trig_logSum_updateBindNum
   ON  logSum
   AFTER UPDATE,INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	declare @id int, @bind int, @old int, @mark int, @work int
	if update(bindNum)
	begin
		select @id=ID,@bind=BindNum,@mark=ISNULL(mark,0),@work=iswork from inserted
		select @old=BindNum from deleted
		select @old=ISNULL(@old,0)
		--正常情况下，计数器间隔为1，大于1时自动修正为1.
		if @bind>@old+1 and @mark=0
		begin
			insert into logSumJump(BindNum,oldNum,refID) select @bind,@old,@id
			if @old=0
				set @old=-1	--新记录保持为0.
			update logSum set BindNum=@old+1 where id=@id
		end
	end
END
GO

-- =============================================
-- Author:		Albert	
-- Create date: 20161024
-- Description:	正广和生产线扫码时，写logDetail的同时，写logSum，取代程序中的代码
-- 表logsum增加一个标识列mark int default(0)
-- alter table logSum add mark int default(0)
-- =============================================
ALTER TRIGGER trig_logDetail_addLogSum
   ON  logDetail
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	update logDetail set regDate=CONVERT(varchar(20),cast([date] as datetime),23) from logDetail a, inserted b where a.ID=b.ID
	/*
	declare @id int, @bind int, @date varchar(20), @line int, @class varchar(20), @goods varchar(20)
	select @date=CONVERT(varchar(20),cast([Date] as datetime),23),@line=LineNum,@class=ClassGroup,@goods=Goods_Code FROM inserted
	select @id=id, @bind=BindNum FROM logsum where LineNum=@line and ClassGroup=@class and Goods_Code=@goods and CreateDate=@date
	if isnull(@id,0)>0	--如果有logsum记录，在计数器上+1
	begin
		update logSum set BindNum=ISNULL(BindNum,0)+1, mark=1 where ID=@id
		update logSum set mark=0 where ID=@id
	end
	--记录到临时表
	insert into gc_addLogSum(LineNum,ClassGroup,Goods_Code,barcode,regDate,bindNum,refID) select LineNum,ClassGroup,Goods_Code,barcode,@date,@bind,isnull(@id,0) from inserted
	*/
END
GO

--为防止日志汇总数据与明细数据有差异，对汇总数据进行自动校正处理。定时执行（每5分钟）
--对近期（2天内）未标识的记录进行校对
--先将活动记录标识取消
CREATE PROCEDURE PROC_correctLogSum
AS
BEGIN
	set nocount on
	declare @id int, @bind int, @count int
	--检查已校对过的活动班组，如果数量与标定数量发生变化，说明重新开始生产，取消校对标识。
	update logSum set checked=0 where createdate>=convert(varchar(20),dateadd(d,-1,getDate()),23) and iswork=1 and checked=1 and BindNum<>lastNum
	--对近期（2天内）未标识的非活动班组，或者未标记的但数量不再变化的活动班组，进行校对
	--(暂时扩大到所有数量发生变化的记录)
	declare rc cursor for 
		select id,bindNum from logSum where createdate>=convert(varchar(20),dateadd(d,-1,getDate()),23) and BindNum<>lastNum
		--select id,bindNum from logSum where createdate>=convert(varchar(20),dateadd(d,-1,getDate()),23) and iswork=0 and checked=0
		--union
		--select id,bindNum from logSum where createdate>=convert(varchar(20),dateadd(d,-1,getDate()),23) and iswork=1 and checked=0 and BindNum=lastNum
	
	open rc
	fetch next from rc into @id,@bind
	While @@fetch_status=0 
	Begin 
		select @count=COUNT(*) from gc_addLogSum where refID=@id
		if @count<>@bind
		begin
			update logSum set BindNum=@count,mark=1 where id=@id	--mark=1标识为强制修改
			insert into logSumJump(refID,bindNum,oldNum,mark) values(@id,@count,@bind,1)
		end
		--添加标识，不再校正
		update logSum set checked=1,mark=0,lastNum=BindNum where id=@id
		fetch next from rc into @id,@bind
	End 
	Close rc 
	Deallocate rc
	--检查未校对过的活动班组，标定当前数量。
	update logSum set lastNum=BindNum where createdate>=convert(varchar(20),dateadd(d,-1,getDate()),23) and iswork=1 and checked=0
END
GO

--add new job to do:
exec PROC_correctLogSum

select * from logSumJump

--2016-11-25

alter table logDetail add regDate varchar(20) null
update logDetail set regDate=CONVERT(varchar(20),cast([date] as datetime),23)
--检查生产线本地日志与明细之间的差距
--默认为当天
alter function getLogCheckDaily(@d int)
returns @tab table(LineNum int,ClassGroupe varchar(20),Goods_Code varchar(20),BindNum int,count int)
as
begin
	declare @date varchar(20)
	set @date=CONVERT(varchar(20),dateadd(d,@d,getDate()),23)
	insert into @tab 
	select b.LineNum,b.ClassGroup,b.Goods_Code,max(a.BindNum),count(*) from LogSum a, logDetail b
	 where a.LineNum=b.LineNum and a.ClassGroup= b.ClassGroup and a.Goods_Code= b.Goods_Code and a.CreateDate =b.regDate and a.createDate=@date 
	 group by b.LineNum,b.ClassGroup,b.Goods_Code
	return
end
go

select * from dbo.getLogCheckDaily(0)
union
select * from dbo.getLogCheckDaily(-1)
select LineNum,ClassGroup,Goods_Code,COUNT(*) from LogDetail where LEFT([date],10)='2016/11/26' group by LineNum,ClassGroup,Goods_Code
select Line,ClassGroup,Goods_Code,COUNT(*) from tiaoxingma where CONVERT(varchar(20),scantime,23)='2016-11-26' group by Line,ClassGroup,Goods_Code
select LineNum,ClassGroup,Goods_Code,COUNT(*) from gc_addLogSum where regDate='2016-11-26' group by LineNum,ClassGroup,Goods_Code
select * from gc_addLogSum where regDate='2016-11-26' order by ID

--2016-11-28
--2号生产线11.27生产的11.3L纯水1704桶，但其中474桶的二维码有重复，分别属于10个编码，每个重复46-49次
--日志显示出重复情况。排除二维码生成及文件导出问题，应该是印刷厂失误造成。
/*
序号	二维码编号	数量
1	514176035747	46
2	554580270752	48
3	866545407772	48
4	241434061632	47
5	827232254867	47
6	037378742612	48
7	380747214645	46
8	654635777505	49
9	603148021520	48
10	077782086525	47
*/
--11.28也有少量出现

--2016-11-29
--厂方提交一个无法查询的号码
select * from T_Searchcode where Barcode='183107083114'
select * from T_Codetrash where Barcode='183107083114'
select * from gc_T_Codetrash where Barcode='183107083114'
select * from gc_T_Product_Code where Start=13998005
select * from Dal_Customer where ID=2026974
select * from T_Scan where CompanyId=32 and Code='CzghhiiQNzHQNJJQVgkVVePgho'
select * from Dal_Exchange where SN=13998005
select * from Dal_Scan_Code_Log where CompanyID=32 and Code='183107083114'

--2016-11-30 检查重码情况
select b.* from T_Product_Code a, T_Searchcode b where a.start=b.sn and a.CompanyID=32 and 
a.CreateTime>='2016-11-30 00:00:00' and a.CreateTime<='2016-12-01 00:00:00' and a.line=1 and ClassGroup='D班' and a.productno=1032
order by b.ID

--2016-12-02 正广和二分厂上午断电后，鼠标键盘不响应。现场检查发现KVM切换器故障，直接接到PC上，以后拟更换KVM。
--正广和总厂中午12：10左右，切换生产线后，扫描二维码时计算机的计数器没有响应。两台计算机、两个生产线都如此。
--网络连接正常，ping扫描器IP也正常，扫描器本身工作也正常，能够读取二维码。
--计算机上的WindowsServiceListener服务已启动，反复重启几次后，系统恢复正常。最终并未查明具体原因。


--2016-12-09 金纺短信发送失败。数据中有些客户的电话是空的，所以无法发送
select * from Dal_Customer where CompanyID=53 and Tel is null and CustomerName is not null		--某个商家的客户列表
select * from Dal_Customer where Tel is null and CustomerName is not null	
update Dal_Customer set Tel=CustomerName where CompanyID=53 and Tel is null and CustomerName is not null
update Dal_Customer set Tel=CustomerName where Tel is null and CustomerName is not null
--建立触发器，自动将用户名填写到空的电话里

-- =============================================
-- Author:		Albert	
-- Create date: 20161209
-- Description:	当电话为空时，自动用用户名填充
-- =============================================
CREATE TRIGGER trig_Dal_Customer
   ON  Dal_Customer
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
	if exists(select 1 from inserted where Tel is null)
		update Dal_Customer set Tel=a.CustomerName from Dal_Customer a, inserted b where a.Id=b.Id
END
GO

--2016-12-13 安吉新厂安装软件。主页面登录后，次级页面无法登录。
--原因是远程数据库中需要新建用户
select * from Dal_Mobile where CompanyID=32
insert into Dal_Mobile(CompanyID,StoreID,MobileCode,MobileName,SimCard,IMEI,Recorder,Pwd,IfUsed,StoreName)
values(32,91,131,'AJ','AJ1','5097-7BBF',1,'123',1,'AJ1')
select * from Dal_Mobile where CompanyID=32 and ID=531 or ID=532
update Dal_Mobile set IMEI = 'F004-2FFC' where ID=531 or ID=532
update Dal_Mobile set IMEI = '5097-7BBF' where ID=531 or ID=532

--2016-12-22正广和工厂开会讨论二维码重复问题。要求印刷厂查找原因。
select * from T_Searchcode where Code in('CzghyzNxSJxixmmyVUqjUWWVyL')
select * from T_Product_Code where start in(14034011)
select * from gc_T_Product_Code where Start in(13998016,13998040,13998032)
truncate table temp_1
insert into temp_1
select barcode,COUNT(*) from T_Searchcode group by Barcode having COUNT(*)>1
select * from T_Searchcode where barcode is null
create index idx_temp_1 on temp_1(barcode)
select b.* from temp_1 a, T_Searchcode b where a.barcode=b.Barcode order by a.barcode
select barcode,companyid,COUNT(*) from T_Searchcode group by Barcode,companyid having COUNT(*)>1
--同一个公司的编码没有重复，但不同公司之间有重复


--2016-12-26正广和用户13606735773登录商城无法获取验证码。短信系统的密码出了问题，更改了密码。
--也可以使用另外一个短信账户。在web.config里可以设置两种短信账户密码。
select * from Dal_Customer where CompanyID=32 and CustomerName in('13606735773','13331987897')
select * from Dal_Customer where CustomerName in('13606735773','13331987897')  '3f3c795613fc8e5cd89e080509ad2384'
select * from Dal_Company
select * from Bi_SmsLog where Moblies='13331987897' order by SendTime desc
select * from Bi_SmsLog where FunType='1' order by SendTi‘1‘me desc
select * from temp_1

select COUNT(*) from T_Searchcode where CreatDate>'2017-01-01 00:00:00'
select * into T_Searchcode20160507 from T_Searchcode

--2017-01-12 查询某一天使用标签的生成日期分布

create function getLabelUseStat(@date varchar(20))
returns @tab table(createtime varchar(20),count int)
as
begin
	declare @start varchar(20), @end varchar(20)
	select @start=@date + ' 00:00:00', @end=@date + ' 23:59:59'
	insert into @tab
	select createtime,COUNT(*) from
	( 
	select convert(varchar(20),b.CreatDate ,23) as createtime from T_Product_Code a, T_Searchcode b
	where a.Start=b.sn and b.CompanyId=32 and a.CreateTime between @start and @end
	) c
	group by createtime
	return
end
select * from dbo.getLabelUseStat('2017-01-12') order by createtime

--20170223 安吉厂更换计算机，IMEI号码也变更
select * from Dal_Mobile where CompanyID=32

insert into Dal_Mobile(storeID,companyID,MobileCode,SimCard,Recorder,Pwd,IfUsed,StoreName,MobileRole)
select storeID,companyID,MobileCode,SimCard,Recorder,Pwd,IfUsed,StoreName,MobileRole from Dal_Mobile where MobileName='安吉外地'

update Dal_Mobile set MobileName='安吉外地',IMEI='E0DF-99B3' WHERE ID IN(541,542)

select * from t_searchcode where barcode in('047723313418','564035741468','358656756217','524522506544','240733034684')
select * from T_Codetrash where barcode in('047723313418','564035741468','358656756217','524522506544','240733034684')
select b.barcode,a.CreateTime,a.* from T_Product_Code a, (
select sn,Barcode from t_searchcode where barcode in('047723313418','564035741468','358656756217','524522506544','240733034684')
) b
where a.Start=b.sn
select * from gc_T_Product_Code where Start in(
select sn from t_searchcode where barcode in('047723313418','564035741468','358656756217','524522506544','240733034684')
)
