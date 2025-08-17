class DocumentsController < ApplicationController
  before_action :set_doc, only: %i[ show update destroy ]
  before_action :set_org, only: %i[ show ]

  def show
    if @document
      content = generate_document_content(@document, @organization)
      
      render json: {
        document: @document,
        organization: @organization,
        generated_content: content
      }, status: :ok
    else
      render json: { error: 'Document not found' }, status: :not_found
    end
  end

  def create
    type = get_type(params[:type])
    @document = type.new(doc_params)
    @document.user = current_user

    if @document.save
      render json: {
        status: 'success',
        message: 'Document successfully created',
        data: {
          id: @document.id,
          created_at: Time.current.iso8601
        }
      }, status: :ok
    else
      render json: {
        status: 'error',
        message: 'Failed to create document',
        errors: @document.errors
      }, status: :unprocessable_entity
    end
  end

  def update
    if @document.update(doc_params)
      render json: {
        status: 'success',
        message: 'Document successfully updated',
        data: {
          id: @document.id,
          updated_at: Time.current.iso8601
        }
      }, status: :ok
    else
      render json: {
        status: 'error',
        message: 'Failed to update document',
        errors: @document.errors
      }, status: :unprocessable_entity
    end
  end

  def destroy
    if @document.destroy
      render json: {
        status: 'success',
        message: 'Document successfully deleted',
        data: {
          id: @document.id,
          deleted_at: Time.current.iso8601
        }
      }, status: :ok
    else
      render json: {
        status: 'error',
        message: 'Failed to delete document',
        errors: @document.errors
      }, status: :unprocessable_entity
    end
  end

  private
    def set_org 
      @organization = Organization.find_by(user: current_user)
    end

    def set_doc
      type = get_type(params[:type])
      @document = type.find_by(user: current_user)
    end

    def get_type(type)
      {
        'terms_of_service' => TermsOfService,
        'privacy_policy' => PrivacyPolicy,
        'cookie_policy' => CookiePolicy,
        'disclaimer' => Disclaimer,
        'acceptable_use_policy' => AcceptableUsePolicy
      }[type]
    end

    def doc_params
      case params[:type]
      when 'terms_of_service'
        params.expect(document: [
          :title, :effective_date, :acceptance_required, :minimum_age,
          :governing_law, :jurisdiction, :dispute_resolution, :user_data_collection,
          :account_termination_notice_days, :refund_policy, :service_availability,
          :user_generated_content_policy
        ])
      when 'privacy_policy'
        params.expect(document: [
          :title, :effective_date, :data_types_collected, :cookies_used,
          :third_party_sharing, :international_transfers, :user_rights_access,
          :user_rights_deletion, :user_rights_portability, :data_retention_period,
          :contact_method, :gdpr_compliant, :ccpa_compliant
        ])
      when 'cookie_policy'
        params.expect(document: [
          :title, :effective_date, :essential_cookies, :analytics_cookies,
          :marketing_cookies, :preference_cookies, :third_party_cookies,
          :cookie_consent_required, :cookie_banner_type, :retention_periods,
          :opt_out_methods
        ])
      when 'disclaimer'
        params.expect(document: [
          :title, :effective_date, :disclaimer_type, :liability_limitation,
          :warranty_disclaimer, :accuracy_disclaimer, :external_links_disclaimer,
          :professional_advice_disclaimer
        ])
      when 'acceptable_use_policy'
        params.expect(document: [
          :title, :effective_date, :prohibited_content, :prohibited_activities,
          :user_responsibilities, :enforcement_actions, :reporting_violations,
          :content_moderation, :age_restrictions, :commercial_use_allowed
        ])
      else
        params.expect(document: [])
      end
    end

    def generate_document_content(document, organization)
      case document.class.name
      when 'TermsOfService'
        generate_terms_of_service_content(document, organization)
      when 'PrivacyPolicy'
        generate_privacy_policy_content(document, organization)
      when 'CookiePolicy'
        generate_cookie_policy_content(document, organization)
      when 'Disclaimer'
        generate_disclaimer_content(document, organization)
      when 'AcceptableUsePolicy'
        generate_acceptable_use_policy_content(document, organization)
      else
        "Content generation not implemented for #{document.class.name}"
      end
    end

    def generate_terms_of_service_content(document, organization)
      content = <<~TERMS
        # #{document.title}

        **Effective Date:** #{document.effective_date}

        These Terms of Service ("Terms") govern your use of the services provided by #{organization.legal_name} ("#{organization.name}", "we", "us", or "our").

        ## 1. Acceptance of Terms
        By accessing or using our services, you agree to be bound by these Terms.
        #{document.acceptance_required? ? "You must explicitly accept these terms to use our services." : ""}

        ## 2. Eligibility
        #{document.minimum_age ? "You must be at least #{document.minimum_age} years old to use our services." : "There are no age restrictions for using our services."}

        ## 3. User Data
        #{document.user_data_collection? ? "We collect and process user data as described in our Privacy Policy." : "We do not collect personal user data."}

        ## 4. Account Termination
        #{document.account_termination_notice_days ? "We will provide #{document.account_termination_notice_days} days notice before terminating your account." : "Account termination may occur without notice."}

        ## 5. Refund Policy
        #{document.refund_policy&.humanize || "No refund policy specified."}

        ## 6. Service Availability
        #{document.service_availability&.humanize || "Best effort service availability."}

        ## 7. User Generated Content
        #{document.user_generated_content_policy&.humanize || "User generated content policy not specified."}

        ## 8. Governing Law
        These Terms are governed by the laws of #{document.governing_law}.

        ## 9. Jurisdiction
        Any disputes will be resolved in #{document.jurisdiction}.

        ## 10. Dispute Resolution
        #{document.dispute_resolution&.humanize || "Standard litigation process applies."}

        ## Contact Information
        For questions about these Terms, contact us at #{organization.email}.

        #{organization.name}
        #{organization.address}
        #{organization.city}, #{organization.state} #{organization.postal_code}
        #{organization.country}
      TERMS

      content
    end

    def generate_privacy_policy_content(document, organization)
      content = <<~PRIVACY
        # #{document.title}

        **Effective Date:** #{document.effective_date}

        #{organization.legal_name} ("#{organization.name}", "we", "us", or "our") respects your privacy and is committed to protecting your personal data.

        ## 1. Data We Collect
        #{document.data_types_collected}

        ## 2. Cookies
        #{document.cookies_used? ? "We use cookies as described in our Cookie Policy." : "We do not use cookies."}

        ## 3. Third Party Sharing
        #{document.third_party_sharing? ? "We may share your data with third parties under certain circumstances." : "We do not share your data with third parties."}

        ## 4. International Transfers
        #{document.international_transfers? ? "Your data may be transferred internationally." : "Your data remains within your jurisdiction."}

        ## 5. Your Rights
        #{document.user_rights_access? ? "- Right to access your data\n" : ""}
        #{document.user_rights_deletion? ? "- Right to delete your data\n" : ""}
        #{document.user_rights_portability? ? "- Right to data portability\n" : ""}

        ## 6. Data Retention
        #{document.data_retention_period ? "We retain your data for #{document.data_retention_period} days." : "Data retention period not specified."}

        ## 7. Contact Us
        Contact us via #{document.contact_method}: #{organization.email}

        ## 8. Compliance
        #{document.gdpr_compliant ? "This policy is GDPR compliant.\n" : ""}
        #{document.ccpa_compliant ? "This policy is CCPA compliant.\n" : ""}

        #{organization.dpo_name ? "Data Protection Officer: #{organization.dpo_name} (#{organization.dpo_email})" : ""}
      PRIVACY

      content
    end

    def generate_cookie_policy_content(document, organization)
      content = <<~COOKIES
        # #{document.title}

        **Effective Date:** #{document.effective_date}

        This Cookie Policy explains how #{organization.legal_name} uses cookies and similar technologies.

        ## Types of Cookies We Use
        #{document.essential_cookies? ? "- **Essential Cookies**: Required for basic website functionality\n" : ""}
        #{document.analytics_cookies? ? "- **Analytics Cookies**: Help us understand how visitors use our site\n" : ""}
        #{document.marketing_cookies ? "- **Marketing Cookies**: Used to deliver relevant advertisements\n" : ""}
        #{document.preference_cookies? ? "- **Preference Cookies**: Remember your settings and preferences\n" : ""}

        ## Third Party Cookies
        #{document.third_party_cookies? ? "We may use third-party cookies from our partners and service providers." : "We do not use third-party cookies."}

        ## Cookie Consent
        #{document.cookie_consent_required? ? "We require your consent before using non-essential cookies." : "Cookie consent is not required for our current cookie usage."}
        #{document.cookie_banner_type ? "We use a #{document.cookie_banner_type.humanize} approach for cookie consent." : ""}

        ## Retention Periods
        #{document.retention_periods || "Cookie retention periods vary by type and purpose."}

        ## Opt-Out Methods
        #{document.opt_out_methods || "Contact us to opt out of non-essential cookies."}

        ## Contact Information
        For questions about our cookie usage, contact us at #{organization.email}.
      COOKIES

      content
    end

    def generate_disclaimer_content(document, organization)
      content = <<~DISCLAIMER
        # #{document.title}

        **Effective Date:** #{document.effective_date}

        This disclaimer applies to all services provided by #{organization.legal_name}.

        ## Type of Disclaimer
        This is a #{document.disclaimer_type} disclaimer.

        ## Limitations
        #{document.liability_limitation? ? "- Our liability is limited as permitted by law\n" : ""}
        #{document.warranty_disclaimer? ? "- We provide no warranties, express or implied\n" : ""}
        #{document.accuracy_disclaimer? ? "- We do not guarantee the accuracy of information\n" : ""}
        #{document.external_links_disclaimer? ? "- We are not responsible for external linked content\n" : ""}
        #{document.professional_advice_disclaimer? ? "- This does not constitute professional advice\n" : ""}

        ## Contact Information
        For questions about this disclaimer, contact us at #{organization.email}.
      DISCLAIMER

      content
    end

    def generate_acceptable_use_policy_content(document, organization)
      content = <<~AUP
        # #{document.title}

        **Effective Date:** #{document.effective_date}

        This Acceptable Use Policy governs your use of #{organization.legal_name} services.

        ## Prohibited Content
        #{document.prohibited_content}

        ## Prohibited Activities
        #{document.prohibited_activities}

        ## User Responsibilities
        #{document.user_responsibilities}

        ## Enforcement
        #{document.enforcement_actions || "Violations may result in account suspension or termination."}

        ## Reporting Violations
        #{document.reporting_violations || "Report violations to #{organization.email}."}

        ## Content Moderation
        #{document.content_moderation? ? "We actively moderate user content." : "Content is not actively moderated."}

        ## Age Restrictions
        #{document.age_restrictions? ? "Age restrictions apply to certain services." : "No age restrictions apply."}

        ## Commercial Use
        #{document.commercial_use_allowed? ? "Commercial use is permitted under certain conditions." : "Commercial use is not permitted."}

        ## Contact Information
        For questions about this policy, contact us at #{organization.email}.
      AUP

      content
    end
  end