# SQL Stored Procedures

This repository contains SQL stored procedures designed for basic invoicing and client data management.  
The procedures demonstrate validation logic, conditional handling, and parameterized queries using **MySQL**.

---

## Database
- **DBMS:** MySQL
- **Schema used:** `sql_invoicing`

---

## Stored Procedures

###  `make_payment`
This procedure records a payment for a specific invoice while validating the payment amount.

#### 🔧 Parameters
| Parameter | Type | Description |
|--------|------|------------|
| `invoice_id` | INT | Invoice identifier |
| `payment_amount` | DECIMAL(9,2) | Payment amount (must be > 0) |
| `payment_date` | DATE | Date of payment |

#### ⚙️ Logic
- Validates that the payment amount is greater than zero
- Raises an SQL error if the amount is invalid
- Updates the invoice with the payment amount and date

####  SQL Code
```sql
CREATE DEFINER=`root`@`localhost` PROCEDURE `make_payment`(
    invoice_id INT,
    payment_amount DECIMAL(9,2),
    payment_date DATE
)
BEGIN
    IF payment_amount <= 0 THEN
        SIGNAL SQLSTATE '22003'
        SET MESSAGE_TEXT = 'Invalid payment amount';
    END IF;

    UPDATE invoices i
    SET
        i.payment_total = payment_amount,
        i.payment_date = payment_date
    WHERE i.invoice_id = invoice_id;
END;
