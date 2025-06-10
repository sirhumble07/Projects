# 📝 Azure Sentinel SIEM Tracker (Notion Template)

## 📌 Overview
This Notion template is designed to **track the deployment and security monitoring** of **Azure Sentinel**. Use it to organize setup steps, analytics rules, incident response actions, and security insights.

---

## 🚀 Deployment Checklist
### **1️⃣ Initial Setup**
- [ ] Create **Log Analytics Workspace** in Azure.
- [ ] Deploy **Azure Sentinel** and attach to the workspace.
- [ ] Enable **Azure Defender for Cloud**.

### **2️⃣ Data Sources & Integration**
- [ ] Connect **Azure Activity Logs**.
- [ ] Integrate **VM security logs**.
- [ ] Enable **Identity Protection logs**.

### **3️⃣ Analytics & Incident Response**
- [ ] Configure **custom analytics rules** (KQL-based).
- [ ] Set up **Azure Sentinel Playbooks** for automation.
- [ ] Monitor **security incidents & alerts**.

### **4️⃣ Documentation & Reporting**
- [ ] Export **monitoring dashboards**.
- [ ] Document **incident handling procedures**.
- [ ] Review **playbook effectiveness**.

---

## 📡 Data Connectors
🔗 **Active Integrations**
- **Azure Activity Logs** 🏢  
- **Virtual Machine Logs** 🖥️  
- **Identity Protection Logs** 🔐  
- **Office 365 Security Data** 📧  

---

## 📊 Analytics Rules
🔍 **Custom Threat Detection Rules**
| Rule Name | Query Type | Action |
|-----------|-----------|--------|
| Suspicious VM Login | KQL | Alert & Notify |
| Repeated Failed Logins | KQL | Trigger Playbook |
| Data Exfiltration Detection | KQL | Send Incident Report |

---

## 🚨 Incident Response Playbooks
✅ **Automated Actions**
- 🚀 **Send alerts to Microsoft Teams**
- 🔄 **Trigger remediation actions**
- 📧 **Email security analysts**

---

## 📌 Security Notes
⚠ **Review firewall rules regularly**  
⚡ **Enable Just-in-Time (JIT) access for VMs**  
🔒 **Ensure role-based access control (RBAC)**  

---

## 📄 References
🔗 [Azure Sentinel Documentation](https://learn.microsoft.com/en-us/azure/sentinel/)  
🔗 [KQL Query Guide](https://learn.microsoft.com/en-us/azure/data-explorer/kusto/query/)  

---