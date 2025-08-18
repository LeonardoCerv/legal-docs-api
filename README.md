![legal-doc-api](/legalDocsAPI.png)

![Ruby](https://img.shields.io/badge/Ruby-AE1401?logo=ruby&logoColor=white)
![Rails](https://img.shields.io/badge/Rails-AE1401?logo=rubyonrails&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-003B57?logo=sqlite&logoColor=white)
![API](https://img.shields.io/badge/REST%20API-blue)
[![API Docs](https://img.shields.io/badge/Swagger-6ABA23?logo=swagger&logoColor=white)](https://legaldocs.leonardocerv.hackclub.app/api-docs/)
![License](https://img.shields.io/badge/License-MIT-brown)

A rails API for creating, managing, and serving tailored legal documents including Terms of Service, Privacy Policy, Cookie Policy, Disclaimer, and Acceptable Use Policy.

## How to Use

[![API docs](https://img.shields.io/badge/Open%20API%20documentation%20(swagger)-6ABA23?logo=swagger&style=for-the-badge&logoColor=white)](https://legaldocs.leonardocerv.hackclub.app/api-docs/)

### Organizations
Organizations represent the legal entity that owns the documents. Each user can create only one organization which should have:
- Company details (name, legal name, industry, business type)
- Contact information (address, email, phone, website)
- Legal settings (data retention period, jurisdiction)

Organizations are a requisite before creating any legal documents because it provides some of the neccessary information on the documents.

### Documents
The API currently supports the following legal document types, contact me if you think you can help add more!
- **Terms of Service**: Legal agreements between your organization and users that outline rules, responsibilities, and limitations for using your service
- **Privacy Policy**: Documents that explain how your organization collects, uses, stores, and protects user data and personal information
- **Cookie Policy**: Specific policies detailing what cookies your website uses, their purpose, and how users can manage cookie preferences
- **Disclaimer**: Legal statements that limit your organization's liability and clarify the scope of responsibility for your services or content
- **Acceptable Use Policy**: Guidelines that define what constitutes appropriate and inappropriate use of your services or platform

### Templates
Templates are basic and broad documents that can be used for your organization. They include:
- Standard legal language and clauses
- Placeholder fields for organization-specific information
- Industry-specific variations where applicable
- Compliance with common legal requirements

Use Templates as a quick and easy way to generate your documents, then customize them with your organization's specific details and requirements.

## Quick Start

check out the deployed public version here:

[![API docs](https://img.shields.io/badge/Public%20Deployed%20API-AE1401?logo=rubyonrails&logoColor=white&style=for-the-badge)](https://legaldocs.leonardocerv.hackclub.app/)

or follow these steps to install this project locally:

### Prerequisites

- Ruby 3.4.4 or higher
- Rails 8.0.2 or higher
- SQLite3

### Installation

1. **Clone the repo**
   ```bash
   git clone https://github.com/LeonardoCerv/legal-docs-api.git
   cd legal-docs-api
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Setup the database**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the server**
   ```bash
   rails server
   ```

   All done! Your local API will now be available at `http://localhost:3000`

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.