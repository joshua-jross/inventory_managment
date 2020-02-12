CREATE TABLE "stockItem" (
	"skuNumber" character(30) NOT NULL,
	"description" character(50) NOT NULL,
	"weight" DECIMAL(20) NOT NULL,
	"dimensions" character(20) NOT NULL,
	"active" BOOLEAN NOT NULL,
	"created" TIMESTAMP NOT NULL,
	CONSTRAINT "stockItem_pk" PRIMARY KEY ("skuNumber")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "vendorItem" (
	"itemNumber" character(30) NOT NULL,
	"description" character(50) NOT NULL,
	"vendorName" character(30) NOT NULL,
	"preferred" BOOLEAN NOT NULL,
	"minOrderSize" integer(20) NOT NULL,
	"leadTimeDays" integer(20) NOT NULL,
	"refSkuNumber" integer(20) NOT NULL,
	"active" BOOLEAN(20) NOT NULL,
	"created" TIMESTAMP NOT NULL,
	CONSTRAINT "vendorItem_pk" PRIMARY KEY ("itemNumber")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "vendorPriceList" (
	"itemNumber" character(30) NOT NULL,
	"priceA" money(20) NOT NULL,
	"minQtyA" integer(20) NOT NULL,
	"priceB" money(20) NOT NULL,
	"minQtyB" integer(20) NOT NULL,
	"priceC" money(20) NOT NULL,
	"minQtyC" integer(20) NOT NULL,
	"priceD" money(20) NOT NULL,
	"minQtyD" integer(20) NOT NULL,
	"refSkuNumber" character(30) NOT NULL,
	"active" BOOLEAN(20) NOT NULL,
	"created" TIMESTAMP NOT NULL,
	CONSTRAINT "vendorPriceList_pk" PRIMARY KEY ("itemNumber")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "stockStatus" (
	"skuNumber" character NOT NULL,
	"location" character(20) NOT NULL,
	"available" integer(20) NOT NULL,
	"onHand" integer(20) NOT NULL,
	"onSalesOrder" integer(20) NOT NULL,
	"onPO" integer(20) NOT NULL,
	"nextDevilery" DATE NOT NULL,
	CONSTRAINT "stockStatus_pk" PRIMARY KEY ("skuNumber")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "mrp" (
	"skuNumber" character(30) NOT NULL,
	"location" character(20) NOT NULL,
	"aveDailyUse" integer(20) NOT NULL,
	"reorderPoint" character(20) NOT NULL,
	"safetyStockPercent" integer(20) NOT NULL,
	"aveLeadTime" integer(20) NOT NULL,
	"standardQty" integer(20) NOT NULL,
	"active" BOOLEAN NOT NULL,
	"created" TIMESTAMP NOT NULL,
	CONSTRAINT "mrp_pk" PRIMARY KEY ("skuNumber")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "transactionLog" (
	"id" serial NOT NULL,
	"transactionType" character(20) NOT NULL,
	"reference" character(20) NOT NULL,
	"referenceDate" DATE NOT NULL,
	"quantity" integer(20) NOT NULL,
	"price" money NOT NULL,
	"skuNumber" character(30) NOT NULL,
	"location" character(20) NOT NULL,
	"customerName" character(30) NOT NULL,
	"shipDate" DATE NOT NULL,
	"vendorItemNumber" character(30) NOT NULL,
	"deliveryDate" bigint NOT NULL,
	"created" TIMESTAMP NOT NULL,
	CONSTRAINT "transactionLog_pk" PRIMARY KEY ("id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "retailPriceList" (
	"skuNumber" character(30) NOT NULL,
	"retailPriceA" money(20) NOT NULL,
	"retailPriceB" money(20) NOT NULL,
	"retailPriceC" money(20) NOT NULL,
	"retailPriceD" money(20) NOT NULL,
	"active" BOOLEAN NOT NULL,
	"created" TIMESTAMP NOT NULL,
	CONSTRAINT "retailPriceList_pk" PRIMARY KEY ("skuNumber")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "stockLocations" (
	"name" character(20) NOT NULL,
	"active" BOOLEAN NOT NULL,
	"created" TIMESTAMP NOT NULL,
	CONSTRAINT "stockLocations_pk" PRIMARY KEY ("name")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "customerList" (
	"name" character(30) NOT NULL,
	"addressLine1" character(30) NOT NULL,
	"addressLine2" character(30) NOT NULL,
	"city" character(30) NOT NULL,
	"state" character(30) NOT NULL,
	"zip code" character(20) NOT NULL,
	"active" BOOLEAN NOT NULL,
	"created" TIMESTAMP NOT NULL,
	CONSTRAINT "customerList_pk" PRIMARY KEY ("name")
) WITH (
  OIDS=FALSE
);





ALTER TABLE "vendorPriceList" ADD CONSTRAINT "vendorPriceList_fk0" FOREIGN KEY ("itemNumber") REFERENCES "vendorItem"("itemNumber");

ALTER TABLE "stockStatus" ADD CONSTRAINT "stockStatus_fk0" FOREIGN KEY ("skuNumber") REFERENCES "stockItem"("skuNumber");

ALTER TABLE "mrp" ADD CONSTRAINT "mrp_fk0" FOREIGN KEY ("skuNumber") REFERENCES "stockItem"("skuNumber");
ALTER TABLE "mrp" ADD CONSTRAINT "mrp_fk1" FOREIGN KEY ("location") REFERENCES "stockLocations"("name");

ALTER TABLE "transactionLog" ADD CONSTRAINT "transactionLog_fk0" FOREIGN KEY ("skuNumber") REFERENCES "stockItem"("skuNumber");
ALTER TABLE "transactionLog" ADD CONSTRAINT "transactionLog_fk1" FOREIGN KEY ("location") REFERENCES "stockLocations"("name");
ALTER TABLE "transactionLog" ADD CONSTRAINT "transactionLog_fk2" FOREIGN KEY ("customerName") REFERENCES "customerList"("name");
ALTER TABLE "transactionLog" ADD CONSTRAINT "transactionLog_fk3" FOREIGN KEY ("vendorItemNumber") REFERENCES "vendorItem"("itemNumber");

ALTER TABLE "retailPriceList" ADD CONSTRAINT "retailPriceList_fk0" FOREIGN KEY ("skuNumber") REFERENCES "stockItem"("skuNumber");



