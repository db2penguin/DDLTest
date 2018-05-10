--<ScriptOptions statementTerminator=";"/>

DROP TABLESPACE "DB1"."TS1";

DROP TABLESPACE "DB1"."TS2";

DROP DATABASE "DB1";

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

CREATE UNIQUE INDEX "Schema"."Customer_PK"
	ON "Schema"."Customer"
	("Cust_No");

CREATE UNIQUE INDEX "Schema"."Order_PK"
	ON "Schema"."Order"
	("Cust_No", 
	 "Order_No");

ALTER TABLE "Schema"."Order" ADD CONSTRAINT "Order_Customer_FK" FOREIGN KEY
	("Cust_No")
	REFERENCES "Schema"."Customer"
	("Cust_No")
	ON DELETE CASCADE;

