--<ScriptOptions statementTerminator=";"/>

CREATE DATABASE "DB1"
	CCSID EBCDIC;

CREATE  TABLESPACE "TS1"
	IN DB1
	CCSID EBCDIC
	LOCKSIZE ANY
	MAXROWS 255;

CREATE  TABLESPACE "TS2"
	IN DB1
	CCSID EBCDIC
	LOCKSIZE ANY
	MAXROWS 255;

CREATE  TABLESPACE "ts3"
	IN DB1
	CCSID EBCDIC
	LOCKSIZE ANY
	MAXROWS 255;

CREATE  TABLESPACE "ts4"
	IN DB1
	CCSID EBCDIC
	LOCKSIZE ANY
	MAXROWS 255;

CREATE TABLE "Schema"."Customer" (
		"Cust_No" SMALLINT NOT NULL, 
		"Cust_Name" CHAR(5), 
		"Cust_Addr" CHAR(5), 
		CONSTRAINT "Customer_PK" PRIMARY KEY
		("Cust_No")
	)
	IN "DB1"."TS1"
	AUDIT NONE
	DATA CAPTURE CHANGES 
	CCSID EBCDIC;

CREATE TABLE "Schema"."Order" (
		"Order_No" SMALLINT NOT NULL, 
		"Cust_No" SMALLINT NOT NULL, 
		CONSTRAINT "Order_PK" PRIMARY KEY
		("Cust_No", 
		 "Order_No")
	)
	IN "DB1"."TS2"
	AUDIT NONE
	DATA CAPTURE NONE 
	CCSID EBCDIC;

CREATE TABLE "Schema"."Order_item" (
		"Order_Item_No" SMALLINT NOT NULL, 
		"Cust_No" SMALLINT NOT NULL, 
		"Order_No" SMALLINT NOT NULL, 
		"Product_No" SMALLINT NOT NULL, 
		CONSTRAINT "Order_item_PK" PRIMARY KEY
		("Cust_No", 
		 "Order_No", 
		 "Product_No", 
		 "Order_Item_No")
	)
	IN "DB1"."ts3"
	AUDIT NONE
	DATA CAPTURE NONE 
	CCSID EBCDIC;

CREATE TABLE "Schema"."Product" (
		"Product_No" SMALLINT NOT NULL, 
		CONSTRAINT "Product_PK" PRIMARY KEY
		("Product_No")
	)
	IN "DB1"."ts4"
	AUDIT NONE
	DATA CAPTURE NONE 
	CCSID EBCDIC;

CREATE UNIQUE INDEX "Schema"."Customer_PK"
	ON "Schema"."Customer"
	("Cust_No");

CREATE UNIQUE INDEX "Schema"."Order_PK"
	ON "Schema"."Order"
	("Cust_No", 
	 "Order_No");

CREATE UNIQUE INDEX "Schema"."Order_item_PK"
	ON "Schema"."Order_item"
	("Cust_No", 
	 "Order_No", 
	 "Product_No", 
	 "Order_Item_No");

CREATE UNIQUE INDEX "Schema"."Product_PK"
	ON "Schema"."Product"
	("Product_No");

ALTER TABLE "Schema"."Order" ADD CONSTRAINT "Order_Customer_FK" FOREIGN KEY
	("Cust_No")
	REFERENCES "Schema"."Customer"
	("Cust_No")
	ON DELETE CASCADE;

ALTER TABLE "Schema"."Order_item" ADD CONSTRAINT "Order_item_Order_FK" FOREIGN KEY
	("Cust_No", 
	 "Order_No")
	REFERENCES "Schema"."Order"
	("Cust_No", 
	 "Order_No")
	ON DELETE CASCADE;

ALTER TABLE "Schema"."Order_item" ADD CONSTRAINT "Order_item_Product_FK" FOREIGN KEY
	("Product_No")
	REFERENCES "Schema"."Product"
	("Product_No")
	ON DELETE CASCADE;

