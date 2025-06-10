# Deployment Steps

This document outlines the high-level steps to deploy a Virtual Machine (VM) in Microsoft Azure, configure backup and disaster recovery (DR), and test failover scenarios.

---

## 📦 VM Deployment in Azure

1. Sign in to the [Azure Portal](https://portal.azure.com/).
2. Navigate to **Virtual Machines** and select **Create**.
3. Fill in the required details:
   - **Resource Group**
   - **VM Name**
   - **Region**
   - **Image** (e.g., Windows Server 2022)
   - **Size**
4. Configure **Administrator Account** and **Networking** settings.
5. Review and **Create** the VM.

---

## 🛡️ Create Recovery Services Vault

1. In the Azure Portal, search for **Recovery Services Vaults**.
2. Select **+ Create**.
3. Enter the **Vault Name**, **Resource Group**, and **Region**.
4. Review and **Create** the vault.

---

## 💾 Enable Backup on VM

1. Open the **Recovery Services Vault**.
2. Under **Getting Started**, choose **Backup**.
3. Select:
   - **Where is your workload running?** → Azure
   - **What do you want to back up?** → Virtual Machine
4. Click **Backup** and select the target VM.
5. Define a **Backup Policy** or use the default.
6. Enable the backup.

---

## 🌐 Configure Azure Site Recovery to Secondary Region

1. Go to the **Recovery Services Vault**.
2. Under **Site Recovery**, select **+ Replicate**.
3. Choose:
   - **Source**: Azure
   - **Source Location**: Primary region
   - **Target Location**: Secondary region
4. Select the VM to replicate.
5. Configure the **Replication Settings**.
6. Enable replication.

---

## 🔄 Simulate Failover and Test Restore

1. In the **Recovery Services Vault**, under **Site Recovery**, select **Replicated Items**.
2. Choose the replicated VM.
3. Click **Test Failover**.
4. Select a **Recovery Point** and **Target Network**.
5. Monitor the failover operation.
6. Validate VM functionality in the secondary region.
7. Perform a **Clean up test failover** after validation.

---

## 📑 Document Backup Policies and DR Plan

- Record:
  - Backup schedules
  - Retention policies
  - Vault configuration
  - Recovery Point Objective (RPO) / Recovery Time Objective (RTO)
  - Failover and failback procedures
- Save documentation in your designated **documentation repository** or **wiki**.

---

## ✅ Summary

By following these steps, you will have:
- A VM running in Azure
- Backup and retention policies configured
- Azure Site Recovery set up for cross-region protection
- Tested failover and restore capabilities
- A documented DR plan and backup policy for operational readiness

---

> 📌 **Note:** Always validate your configurations and compliance requirements for production workloads.
