class DocumentsController < ApplicationController
  allow_unauthenticated_access only: [:show]
  
  before_action :require_authentication!, except: [:show]
  before_action :set_document, only: [:update, :destroy]
  before_action :validate_document_type, only: [:show, :create]

  def show
    if authenticated?
      document = find_user_document(params[:type])
      if document
        render json: { document: document, user_data: current_user.organization&.as_json }
      else
        render json: { template: get_template_with_user_data(params[:type]) }
      end
    else
      render json: { template: get_basic_template(params[:type]) }
    end
  end

  def create
    document_class = get_document_class(params[:type])
    document = document_class.new(document_params.merge(user: current_user))
    
    if document.save
      render json: { document: document }, status: :created
    else
      render json: { errors: document.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @document.update(document_params)
      render json: { document: @document }
    else
      render json: { errors: @document.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @document.destroy
    head :no_content
  end

  private

  def set_document
    document_types = [
      current_user.terms_of_services,
      current_user.privacy_policies,
      current_user.cookie_policies,
      current_user.disclaimers,
      current_user.acceptable_use_policies
    ]
    
    @document = document_types.flat_map(&:to_a).find { |doc| doc.id == params[:id].to_i }
    
    unless @document
      render json: { error: 'Document not found' }, status: :not_found
    end
  end

  def validate_document_type
    unless valid_document_types.include?(params[:type])
      render json: { error: 'Invalid document type' }, status: :bad_request
    end
  end

  def valid_document_types
    %w[terms_of_service privacy_policy cookie_policy disclaimer acceptable_use_policy]
  end

  def get_document_class(type)
    {
      'terms_of_service' => TermsOfService,
      'privacy_policy' => PrivacyPolicy,
      'cookie_policy' => CookiePolicy,
      'disclaimer' => Disclaimer,
      'acceptable_use_policy' => AcceptableUsePolicy
    }[type]
  end

  def find_user_document(type)
    document_class = get_document_class(type)
    document_class.find_by(user: current_user)
  end

  def get_template_with_user_data(type)
    template = get_basic_template(type)
    org = current_user.organization
    
    if org
      template.merge({
        company_name: org.name,
        company_email: org.email,
        company_address: org.address,
      })
    else
      template
    end
  end

  def get_basic_template(type)
    templates = {
      'terms_of_service' => {
        title: "Terms of Service",
        content: "These terms and conditions outline the rules and regulations for the use of [COMPANY_NAME]'s Website...",
        placeholders: {
          company_name: "[COMPANY_NAME]",
          effective_date: "[EFFECTIVE_DATE]",
          contact_email: "[CONTACT_EMAIL]"
        }
      },
      'privacy_policy' => {
        title: "Privacy Policy",
        content: "This Privacy Policy describes how [COMPANY_NAME] collects, uses, and shares your information...",
        placeholders: {
          company_name: "[COMPANY_NAME]",
          effective_date: "[EFFECTIVE_DATE]",
          contact_email: "[CONTACT_EMAIL]"
        }
      },
    }
    
    templates[type] || { error: "Template not found" }
  end

  def document_params
    params.permit(:title, :content, :effective_date, :additional_data)
  end
end
