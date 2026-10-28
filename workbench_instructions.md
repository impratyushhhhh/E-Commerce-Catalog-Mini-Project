# MySQL Workbench 8.0 CE Guide: Amazon E-Commerce Mini-Project

This guide provides instructions for managing the Amazon-style E-Commerce database (`ecommerce_db`) using **MySQL Workbench 8.0 CE**.

---

## 1. Database Architecture & Relationships

The database schema supports **Hibernate `JOINED` Inheritance** for the catalog, customer checkout with **Cash on Delivery (COD)**, and administrative order tracking.

```mermaid
erDiagram
    Product ||--o| Laptop : "extends (id = id)"
    Product ||--o| TShirt : "extends (id = id)"
    Customer ||--o{ Orders : "places"
    Product ||--o{ Orders : "contains"

    Product {
        BIGINT id PK "AUTO_INCREMENT"
        VARCHAR name
        DECIMAL price "10, 2"
        TEXT description
        VARCHAR category
        INT stock
    }

    Laptop {
        BIGINT id PK_FK "REFERENCES Product(id)"
        VARCHAR brand
        VARCHAR processor
        INT ram_gb
        INT storage_gb
    }

    TShirt {
        BIGINT id PK_FK "REFERENCES Product(id)"
        VARCHAR size
        VARCHAR color
        VARCHAR material
    }

    Customer {
        BIGINT id PK "AUTO_INCREMENT"
        VARCHAR name
        INT age
        VARCHAR phone
        VARCHAR email
        TEXT address
        TIMESTAMP created_at
    }

    Orders {
        BIGINT id PK "AUTO_INCREMENT"
        VARCHAR order_number UK
        BIGINT customer_id FK "REFERENCES Customer(id)"
        BIGINT product_id FK "REFERENCES Product(id)"
        INT quantity
        DECIMAL total_amount "10, 2"
        VARCHAR payment_method "COD"
        VARCHAR order_status "PLACED"
        TIMESTAMP order_date
    }

    AdminUser {
        BIGINT id PK "AUTO_INCREMENT"
        VARCHAR username UK
        VARCHAR password
        VARCHAR full_name
    }
```

---

## 2. Setting Up in MySQL Workbench 8.0 CE

### Step 2.1: Open Connection
1. Launch **MySQL Workbench 8.0 CE**.
2. Connect to your local instance (`localhost:3306`).
3. Username: `root` &bull; Password: `Pratyush123`.

### Step 2.2: Execute `schema.sql`
1. Go to **File** > **Open SQL Script...** (or `Ctrl + Shift + O`).
2. Select:
   `c:\Users\Prat\OneDrive\Documents\Project\AIP Pro\schema.sql`
3. Click the **Lightning Bolt** (`Execute`) icon or press `Ctrl + Shift + Enter`.
4. In the **Action Output** pane, confirm all tables and seed records are created with green checkmarks.

### Step 2.3: Verify Tables in the Schemas Navigator
1. On the left panel, click the **Schemas** tab.
2. Click **Refresh**.
3. Expand **`ecommerce_db`** > **Tables**:
   * `Product`: Base catalog table
   * `Laptop`: Subclass table (FK `id` -> `Product.id`)
   * `TShirt`: Subclass table (FK `id` -> `Product.id`)
   * `Customer`: Customers registered at checkout
   * `Orders`: Placed orders linked to Customer & Product
   * `AdminUser`: Administrator credentials (`admin` / `admin123`)

---

## 3. Verification SQL Queries in Workbench

Run these queries in a SQL Tab (`Ctrl + T`) to verify the data:

### Query 1: View Catalog (Hibernate Polymorphic JOIN)
```sql
USE ecommerce_db;

SELECT 
    p.id, p.name, p.category, p.price, p.stock,
    l.brand, l.processor, l.ram_gb,
    t.size, t.color
FROM Product p
LEFT JOIN Laptop l ON p.id = l.id
LEFT JOIN TShirt t ON p.id = t.id;
```

### Query 2: Inspect Placed Orders with Customer & Delivery Details
```sql
USE ecommerce_db;

SELECT 
    o.order_number,
    o.order_date,
    c.name AS customer_name,
    c.age,
    c.phone,
    c.email,
    c.address AS delivery_address,
    p.name AS product_purchased,
    o.quantity,
    o.total_amount,
    o.payment_method,
    o.order_status
FROM Orders o
INNER JOIN Customer c ON o.customer_id = c.id
INNER JOIN Product p ON o.product_id = p.id
ORDER BY o.order_date DESC;
```

### Query 3: Check Admin Account
```sql
USE ecommerce_db;

SELECT id, username, full_name, created_at 
FROM AdminUser;
```

---

## 4. Default Admin Credentials
* **Username**: `admin`
* **Password**: `admin123`
* **Login URL**: `http://localhost:8080/ecommerce-catalog/admin/login`
