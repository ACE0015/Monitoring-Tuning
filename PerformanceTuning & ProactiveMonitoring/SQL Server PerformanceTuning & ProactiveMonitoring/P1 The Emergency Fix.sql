USE AdventureWorks2022;

--Finding the sales record for the WHEYPROTEIN with OrderQty = 2

SELECT *
FROM
  Sales.SalesOrderDetail
WHERE
  OrderQty = 2 ;

--Include Actual Execution Plan
--Thick Arrow = Carrying lots of unneeded stuff = SLOW