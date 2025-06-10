# Deployment Steps

## 📌 Overview
This document outlines the **step-by-step process** for setting up Azure governance and access control, ensuring efficient resource management and security compliance.

---

## 🚀 Step 1: Create a Management Group and Subscription
1. Sign in to the [Azure Portal](https://portal.azure.com/).
2. Navigate to **Management Groups** and click **Create**.
3. Provide:
   - **Management Group Name**
   - **Parent Management Group** (if applicable)
4. Click **Review + Create** and confirm.

5. Go to **Subscriptions** and create a new one (if needed).
6. Associate the subscription with the management group.

---

## 💰 Step 2: Define Budgets and Cost Alerts
1. Navigate to **Cost Management + Billing**.
2. Select **Budgets** and click **Create Budget**.
3. Configure:
   - **Amount limit**
   - **Time range** (monthly/quarterly/yearly)
   - **Alert recipients** (email, webhook)
4. Click **Save** to apply cost monitoring.

---

## 🔖 Step 3: Apply Tags to Resources
1. Navigate to **Resource Groups** or individual resources.
2. Click **Tags** and add:
   - **Key** (e.g., `Environment`)
   - **Value** (e.g., `Production`, `Dev`, `Test`)
3. Apply tagging rules for governance and cost tracking.

---

## 🛡️ Step 4: Create and Assign Azure Policies
1. Navigate to **Azure Policy**.
2. Click **Definitions** to browse built-in policies.
3. Create or customize policies for:
   - **Resource compliance**
   - **Security baselines**
   - **Cost management**
4. Assign policies to **Management Groups, Subscriptions, or Resource Groups**.
5. Review compliance results.

---

## 🔑 Step 5: Configure RBAC Roles
1. Navigate to **Access Control (IAM)**.
2. Click **Add Role Assignment**.
3. Select:
   - **Role (e.g., Owner, Contributor, Reader)**
   - **Scope (Management Group, Subscription, Resource Group)**
   - **Assign users or groups**
4. Click **Save** to enforce access control.

---

## 📄 Step 6: Document and Visualize the Structure
1. Create an **architecture diagram** using **Azure Architecture Center**.
2. Document governance policies in **Wiki or Notion**.
3. Export audit logs and access control settings for future reference.

---

## 📌 Summary
By following these steps, you will have:
- **A structured governance model** with management groups and subscriptions.
- **Cost management controls** to prevent budget overruns.
- **Tags and policies for compliance enforcement**.
- **RBAC security configurations** ensuring proper access control.

> ⚠ **Security Tip:** Regularly audit policies, cost alerts, and role assignments to maintain governance effectiveness.

---