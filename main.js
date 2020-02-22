
// need tables: stockStatus
// sorted by delivery date then by sku number [sort parameters]
// every front end view has associated backend endpoint that gets exact data.
const inventoryData = [
  {
    skuNumber: '1098765-4',
    description: 'pokemon',
    location: 'west',
    available: 12,
    onSalesOrder: 2,
    onHand: 10,
    vendorItem: 'pok-777',
    onPurchaseOrder: 24,
    nextDevilery: '2020-03-01'
  },
  {
    skuNumber: '1098765-7',
    description: 'superman',
    location: 'east',
    available: 1,
    onSalesOrder: 20,
    onHand: 21,
    vendorItem: 'sup-1234',
    onPurchaseOrder: 50,
    nextDevilery: '2020-03-03'
  },
  {
    skuNumber: '1098765-21',
    description: 'spiderman',
    location: 'east',
    available: 20,
    onSalesOrder: 0,
    onHand: 20,
    vendorItem: 'spid-999',
    onPurchaseOrder: 12,
    nextDevilery: '2020-03-03'
  }
];

const inventoryJson = JSON.stringify(inventoryData);
const inventoryParse = JSON.parse(inventoryJson);

console.log('inventory data: ', inventoryData);
console.log('inventory JSON: ',inventoryJson);
console.log('inventory Parse: ', inventoryParse);

const Pool = require('pg').Pool
const pool = new Pool({
  user: 'me',
  host: 'localhost',
  database: 'api',
  password: 'password',
  port: 5432,
})

const getPurchaseOrder = (request, response) => {

  pool.query('SELECT * FROM stockStatusView ORDER BY nextDelivery ASC', (error, results) => {
    if (error) {
      throw error
    }
    response.status(200).json(results.rows)
  })
}

//create a VIEW instead form other tables. (stored select querry)

CREATE TABLE "stockStatus"(
  "skuNumber" character NOT NULL,
  "location" character(20) NOT NULL,
  "available" integer(20) NOT NULL,
  "onHand" integer(20) NOT NULL,
  "onSalesOrder" integer(20) NOT NULL,
  "onPurchaseOrder" integer(20) NOT NULL,
  "nextDevilery" DATE NOT NULL,
  CONSTRAINT "stockStatus_pk" PRIMARY KEY("skuNumber")
) WITH(
  OIDS = FALSE
);
