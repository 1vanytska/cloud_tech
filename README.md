# ☁️ AZ-104 Microsoft Azure Administrator Labs

This repository contains the implementation of hands-on labs for the **AZ-104: Microsoft Azure Administrator** certification course. Each lab is organized in a separate folder and, where possible, automated using **Terraform** to ensure reproducibility and infrastructure-as-code best practices.

## ⚙️ Technologies Used

- **Terraform** — for infrastructure provisioning and automation  
- **Azure CLI** — for tasks not supported by Terraform  
- **Azure Portal** — for manual configuration, monitoring, and log analysis  

## 📚 Lab Index

| Module                         | Lab Title                                      | Terraform |
|--------------------------------|------------------------------------------------|-----------|
| Identity                       | Lab 01: Manage Microsoft Entra ID Identities   | ✅         |
| Governance & Compliance        | Lab 02a: Manage Subscriptions and RBAC         | ✅         |
| Governance & Compliance        | Lab 02b: Manage Governance via Azure Policy    | ✅         |
| Azure Resources                | Lab 03: ARM Templates                          | ✅         |
| Virtual Networking             | Lab 04: Implement Virtual Networking           | ✅         |
| Intersite Connectivity         | Lab 05: Implement Intersite Connectivity       | ✅         |
| Network Traffic Management     | Lab 06: Implement Network Traffic Management   | ✅         |
| Azure Storage                  | Lab 07: Manage Azure Storage                   | ✅         |
| Virtual Machines               | Lab 08: Manage Virtual Machines                | ✅         |
| PaaS Compute Options           | Lab 09a–c: Web Apps, Containers, Container Apps| ✅         |
| Data Protection                | Lab 10: Implement Data Protection              | ✅         |
| Monitoring                     | Lab 11: Implement Monitoring                   | ✅         |

> ⚠️ Some labs include tasks that cannot be fully automated via Terraform (e.g., alert testing, log queries, or portal-only configurations). These steps were completed manually in the Azure Portal and documented accordingly.

## 🔗 Useful Links

- [AZ-104 Official Certification Guide](https://learn.microsoft.com/en-us/certifications/exams/az-104/)
- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [AZ-104 Lab Source (Microsoft Learning)](https://microsoftlearning.github.io/AZ-104-MicrosoftAzureAdministrator/)
