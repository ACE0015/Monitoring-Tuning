/*
This query text was retrieved from showplan XML, and may be truncated.
*/

SELECT * FROM [Sales].[SalesOrderDetail] WHERE [OrderQty]=1

CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>] 
ON [Sales].[SalesOrderDetail] ([OrderQty]) 
INCLUDE 
  ([CarrierTrackingNumber],
  [ProductID],
  [SpecialOfferID],
  [UnitPrice],
  [UnitPriceDiscount],
  [LineTotal],
  [rowguid],
  [ModifiedDate])

--facing already exist error sooo

IF NOT EXISTS 
  (SELECT * 
  FROM sys.indexes
  WHERE
    name = 'IX_SalesOrderDetail_OrderQTY_Auto')
BEGIN
  CREATE INDEX
    IX_SalesOrderDetail_OrderQTY_Auto
  ON 
    Sales.SalesOrderDetail(OrderQty);

  PRINT
    'Index was missing and has now been created!'
END
ELSE
--This part will run if index is found
BEGIN
  PRINT
    'Index already exists. NO action taken.';
END