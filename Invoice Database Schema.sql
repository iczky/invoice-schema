CREATE TABLE "seller" (
  "id" serial PRIMARY KEY,
  "nama_toko" varchar(100),
  "address_seller" varchar(100),
  "created_at" timestamp,
  "updated_at" timestamp
);

CREATE TABLE "product" (
  "id" serial PRIMARY KEY,
  "product_name" varchar(100),
  "weight" int,
  "price" decimal(10,2),
  "address_seller" varchar(100),
  "seller_id" int
);

CREATE TABLE "addresses_customer" (
  "id" serial PRIMARY KEY,
  "province" varchar(100),
  "kabupaten" varchar(100),
  "address" varchar(100),
  "postal_code" int,
  "customer_id" int
);

CREATE TABLE "customer" (
  "id" serial PRIMARY KEY,
  "name_customer" varchar(100),
  "email" varchar(100),
  "no_phone" varchar(15)
);

CREATE TABLE "orders" (
  "id" serial PRIMARY KEY,
  "customer_id" int,
  "order_date" date,
  "status" varchar(20),
  "shipping_address_id" int,
  "billing_address_id" int,
  "total_price" decimal(10,2),
  "apply_promo" int,
  "created_at" timestamp DEFAULT (CURRENT_DATE),
  "updated_at" timestamp DEFAULT (CURRENT_DATE)
);

CREATE TABLE "order_item" (
  "id" serial PRIMARY KEY,
  "order_id" int,
  "product_id" int,
  "quantity" int,
  "weight_total" int,
  "unit_price" decimal(10,2),
  "created_at" timestamp DEFAULT (CURRENT_DATE),
  "updated_at" timestamp DEFAULT (CURRENT_DATE)
);

CREATE TABLE "courier" (
  "id" serial PRIMARY KEY,
  "name" varchar(100),
  "contact_info" varchar(100)
);

CREATE TABLE "invoice" (
  "id" serial PRIMARY KEY,
  "order_id" int,
  "invoice_date" date,
  "total_price" decimal(10,2),
  "total_insurance_price" decimal(10,2),
  "total_cost_delivery" decimal(10,2),
  "discount" decimal(10,2),
  "tax" decimal(10,2),
  "courier_id" int,
  "payment_id" int,
  "created_at" timestamp DEFAULT (CURRENT_DATE)
);

CREATE TABLE "payment" (
  "id" serial PRIMARY KEY,
  "payment_status" varchar(20),
  "payment_method" varchar(50)
);

CREATE TABLE "promo" (
  "id" serial PRIMARY KEY,
  "promo_name" varchar(50),
  "promo_cutoff" timestamp,
  "promo_cashback" int
);

ALTER TABLE "product" ADD FOREIGN KEY ("seller_id") REFERENCES "seller" ("id");

ALTER TABLE "addresses_customer" ADD FOREIGN KEY ("customer_id") REFERENCES "customer" ("id");

ALTER TABLE "orders" ADD FOREIGN KEY ("customer_id") REFERENCES "customer" ("id");

ALTER TABLE "orders" ADD FOREIGN KEY ("shipping_address_id") REFERENCES "addresses_customer" ("id");

ALTER TABLE "orders" ADD FOREIGN KEY ("billing_address_id") REFERENCES "addresses_customer" ("id");

ALTER TABLE "orders" ADD FOREIGN KEY ("apply_promo") REFERENCES "promo" ("id");

ALTER TABLE "order_item" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("id");

ALTER TABLE "order_item" ADD FOREIGN KEY ("product_id") REFERENCES "product" ("id");

ALTER TABLE "invoice" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("id");

ALTER TABLE "invoice" ADD FOREIGN KEY ("courier_id") REFERENCES "courier" ("id");

ALTER TABLE "invoice" ADD FOREIGN KEY ("payment_id") REFERENCES "payment" ("id");
