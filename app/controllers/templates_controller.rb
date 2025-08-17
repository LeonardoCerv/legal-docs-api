class TemplatesController < ApplicationController
  allow_unauthenticated_access only: [:show]
  
  before_action :validate_template_type, only: [:show]

  def show
    if authenticated?
      render json: { template: get_template_with_user_data(params[:type]) }
    else
      render json: { template: get_basic_template(params[:type]) }
    end
  end

  private

  def validate_template_type
    unless valid_template_types.include?(params[:type])
      render json: { error: 'Invalid template type' }, status: :bad_request
    end
  end

  def valid_template_types
    %w[terms_of_service privacy_policy cookie_policy disclaimer acceptable_use_policy]
  end

  def get_template_with_user_data(type)
    template = get_basic_template(type)
    org = current_user&.organization
    
    if org
      template_content = template[:content]
      template_content = template_content.gsub('[COMPANY_NAME]', org.name || '[COMPANY_NAME]')
      template_content = template_content.gsub('[CONTACT_EMAIL]', org.email || '[CONTACT_EMAIL]')
      template_content = template_content.gsub('[COMPANY_ADDRESS]', org.address || '[COMPANY_ADDRESS]')
      template_content = template_content.gsub('[EFFECTIVE_DATE]', Date.current.strftime('%B %d, %Y'))
      
      template.merge({
        content: template_content,
        populated: true,
        organization_data: {
          name: org.name,
          email: org.email,
          address: org.address
        }
      })
    else
      template.merge(populated: false)
    end
  end

  def get_basic_template(type)
    templates = {
      'terms_of_service' => {
        title: "Terms of Service",
        type: "terms_of_service",
        content: generate_terms_template,
        form_fields: [
          { name: 'company_name', label: 'Company Name', type: 'text', required: true },
          { name: 'contact_email', label: 'Contact Email', type: 'email', required: true },
          { name: 'governing_law', label: 'Governing Law/Jurisdiction', type: 'text', required: true },
          { name: 'limitation_of_liability', label: 'Limitation of Liability Amount', type: 'text', required: false }
        ]
      },
      'privacy_policy' => {
        title: "Privacy Policy",
        type: "privacy_policy",
        content: generate_privacy_template,
        form_fields: [
          { name: 'company_name', label: 'Company Name', type: 'text', required: true },
          { name: 'contact_email', label: 'Contact Email', type: 'email', required: true },
          { name: 'data_retention_period', label: 'Data Retention Period', type: 'text', required: true },
          { name: 'third_party_services', label: 'Third-party Services Used', type: 'textarea', required: false }
        ]
      },
      'cookie_policy' => {
        title: "Cookie Policy",
        type: "cookie_policy",
        content: generate_cookie_template,
        form_fields: [
          { name: 'company_name', label: 'Company Name', type: 'text', required: true },
          { name: 'website_url', label: 'Website URL', type: 'url', required: true },
          { name: 'analytics_tools', label: 'Analytics Tools Used', type: 'text', required: false }
        ]
      },
      'disclaimer' => {
        title: "Disclaimer",
        type: "disclaimer",
        content: generate_disclaimer_template,
        form_fields: [
          { name: 'company_name', label: 'Company Name', type: 'text', required: true },
          { name: 'service_type', label: 'Type of Service/Product', type: 'text', required: true },
          { name: 'disclaimer_scope', label: 'Scope of Disclaimer', type: 'textarea', required: false }
        ]
      },
      'acceptable_use_policy' => {
        title: "Acceptable Use Policy",
        type: "acceptable_use_policy",
        content: generate_aup_template,
        form_fields: [
          { name: 'company_name', label: 'Company Name', type: 'text', required: true },
          { name: 'service_description', label: 'Service Description', type: 'textarea', required: true },
          { name: 'prohibited_activities', label: 'Specific Prohibited Activities', type: 'textarea', required: false }
        ]
      }
    }
    
    templates[type] || { error: "Template not found" }
  end

  def generate_terms_template
    <<~TEMPLATE
      # Terms of Service

      **Effective Date:** [EFFECTIVE_DATE]

      Welcome to [COMPANY_NAME]. These terms and conditions outline the rules and regulations for the use of [COMPANY_NAME]'s services.

      ## 1. Acceptance of Terms
      By accessing and using our services, you accept and agree to be bound by the terms and provision of this agreement.

      ## 2. Services Description
      [COMPANY_NAME] provides [SERVICE_DESCRIPTION]. We reserve the right to modify or discontinue our services at any time.

      ## 3. User Responsibilities
      Users are responsible for maintaining the confidentiality of their account information and for all activities under their account.

      ## 4. Prohibited Uses
      You may not use our services for any unlawful purpose or to solicit others to perform unlawful acts.

      ## 5. Limitation of Liability
      [COMPANY_NAME] shall not be liable for any indirect, incidental, special, consequential, or punitive damages.

      ## 6. Governing Law
      These terms shall be governed by and construed in accordance with the laws of [GOVERNING_LAW].

      ## 7. Contact Information
      If you have any questions about these Terms of Service, please contact us at [CONTACT_EMAIL].
    TEMPLATE
  end

  def generate_privacy_template
    <<~TEMPLATE
      # Privacy Policy

      **Effective Date:** [EFFECTIVE_DATE]

      This Privacy Policy describes how [COMPANY_NAME] collects, uses, and shares your information when you use our services.

      ## 1. Information We Collect
      We collect information you provide directly to us, such as when you create an account or contact us.

      ## 2. How We Use Your Information
      We use the information we collect to provide, maintain, and improve our services.

      ## 3. Information Sharing
      We do not sell, trade, or otherwise transfer your personal information to third parties without your consent.

      ## 4. Data Security
      We implement appropriate security measures to protect your personal information.

      ## 5. Data Retention
      We retain your information for [DATA_RETENTION_PERIOD] or as long as necessary to provide our services.

      ## 6. Your Rights
      You have the right to access, update, or delete your personal information.

      ## 7. Contact Us
      If you have questions about this Privacy Policy, contact us at [CONTACT_EMAIL].
    TEMPLATE
  end

  def generate_cookie_template
    <<~TEMPLATE
      # Cookie Policy

      **Effective Date:** [EFFECTIVE_DATE]

      This Cookie Policy explains how [COMPANY_NAME] uses cookies and similar technologies on [WEBSITE_URL].

      ## 1. What Are Cookies
      Cookies are small text files stored on your device when you visit our website.

      ## 2. How We Use Cookies
      We use cookies to improve your browsing experience and analyze website traffic.

      ## 3. Types of Cookies We Use
      - Essential cookies: Required for the website to function properly
      - Analytics cookies: Help us understand how visitors use our website
      - Functional cookies: Remember your preferences and settings

      ## 4. Managing Cookies
      You can control cookies through your browser settings.

      ## 5. Third-Party Cookies
      We may use third-party services like [ANALYTICS_TOOLS] that also set cookies.

      ## 6. Contact Us
      For questions about our Cookie Policy, contact us at [CONTACT_EMAIL].
    TEMPLATE
  end

  def generate_disclaimer_template
    <<~TEMPLATE
      # Disclaimer

      **Effective Date:** [EFFECTIVE_DATE]

      ## 1. General Information
      The information provided by [COMPANY_NAME] is for general informational purposes only.

      ## 2. No Professional Advice
      The content on our platform does not constitute professional advice.

      ## 3. Accuracy of Information
      While we strive to provide accurate information, we make no representations or warranties about its completeness or accuracy.

      ## 4. Limitation of Liability
      [COMPANY_NAME] will not be liable for any errors or omissions in this information or for any losses or damages arising from its use.

      ## 5. External Links
      Our service may contain links to external websites. We have no control over and assume no responsibility for their content.

      ## 6. Changes to Disclaimer
      We reserve the right to modify this disclaimer at any time.

      ## 7. Contact Information
      Questions about this disclaimer should be sent to [CONTACT_EMAIL].
    TEMPLATE
  end

  def generate_aup_template
    <<~TEMPLATE
      # Acceptable Use Policy

      **Effective Date:** [EFFECTIVE_DATE]

      This Acceptable Use Policy governs your use of [COMPANY_NAME]'s services.

      ## 1. Permitted Uses
      Our services may be used for lawful purposes in accordance with these terms.

      ## 2. Prohibited Activities
      You may not use our services to:
      - Violate any applicable laws or regulations
      - Infringe on intellectual property rights
      - Transmit harmful or malicious content
      - Attempt to gain unauthorized access to our systems

      ## 3. Content Standards
      All content must be appropriate and not violate the rights of others.

      ## 4. Enforcement
      We reserve the right to suspend or terminate accounts that violate this policy.

      ## 5. Reporting Violations
      Report policy violations to [CONTACT_EMAIL].

      ## 6. Changes to Policy
      We may update this policy periodically to reflect changes in our practices.
    TEMPLATE
  end
end
