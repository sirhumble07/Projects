# Deployment Steps

This document outlines the steps required to deploy a secure Azure environment with a **Virtual Network (VNet), Virtual Machine (VM), and Bastion Host** while ensuring **controlled access** and **security best practices**.

---

## 🚀 Step 1: Create Resource Group and VNet
1. Sign in to the [Azure Portal](https://portal.azure.com/).
2. Navigate to **Resource Groups** and click **Create**.
3. Provide:
   - **Resource Group Name**
   - **Region**
4. Click **Review + Create** and confirm.

5. Go to **Virtual Networks** and click **Create**.
6. Configure:
   - **Name**
   - **Address Space**
   - **Subnets**
7. Click **Review + Create** and confirm.

---

## 🖥️ Step 2: Deploy a VM in a Private Subnet
1. Navigate to **Virtual Machines** and click **Create**.
2. Select:
   - **Resource Group**
   - **VM Name**
   - **Region**
   - **Image** (e.g., Windows Server 2022, Ubuntu)
   - **Size**
   - **Networking**: Ensure VM is placed in a **private subnet** (no public IP).
3. Configure **Admin Account**.
4. Click **Review + Create** and confirm.

---

## 🔐 Step 3: Deploy Azure Bastion Host in Same VNet
1. Navigate to **Azure Bastion** and click **Create**.
2. Select:
   - **Resource Group**
   - **Bastion Name**
   - **Region**
   - **VNet**
   - **Subnet** (`AzureBastionSubnet`, `/27` required)
3. Click **Review + Create** and confirm.

---

## ⚡ Step 4: Remove Public IP from VM
1. Navigate to **Virtual Machines** > **Networking**.
2. Locate **Public IP**.
3. Click **Dissociate** to remove the public IP.
4. Confirm changes.

---

## ✅ Step 5: Test Access via Bastion
1. Navigate to **Virtual Machines**.
2. Select the VM.
3. Click **Connect** > **Bastion**.
4. Enter credentials and confirm secure access.

---

## 🔄 Step 6: Configure Just-in-Time (JIT) VM Access
1. Navigate to **Microsoft Defender for Cloud** > **Just-in-Time VM Access**.
2. Select your VM and enable JIT access.
3. Define allowed **ports**, **protocols**, and **duration**.
4. Click **Apply** to enforce JIT security.

---

## 📌 Summary
By following these steps, you will have:
- A **secure Azure VNet** with a private VM.
- **No public exposure**, using **Azure Bastion** for access.
- **Just-in-Time security** configured for controlled VM access.

> ⚠ **Security Tip:** Always follow best practices and monitor access logs regularly.

