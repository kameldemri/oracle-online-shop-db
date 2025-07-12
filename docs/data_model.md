# Data Model

This document explains the relational structure and scalability decisions behind the main tables in the Oracle Online Shop Database.

## Design Roles

- **General-purpose structure:** Independent to regions and shop types.
- **Clean Normalization:**
- **Extensibility**: Adding more regions, products, categories, etc. doesn't break the existing logic.

---

## Users, Customers & Roles

### Roles

### Users

Core entity representing all **application-level accounts** (admin, user) based on a `role` (FK -> `roles`).

### Customers

> This structure enables us to separate **platform identity** from **customer behavior**.

---

## Geographical Design: Country → Wilaya → City -> Address

Built with **real-world regional support** in mind.

**This hierarchy allows us to:**

- Support **any country** or **region-specific rules**.
- Build accurate shipping flows.
- Display full address info.

---

## Orders & Shop Flow (preview)

---

## Lookup Tables
