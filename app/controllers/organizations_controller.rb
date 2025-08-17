class OrganizationsController < ApplicationController
  before_action :require_authentication!
  before_action :set_organization, only: [:show, :update]

  def show
    if @organization
      render json: { organization: @organization }
    else
      render json: { message: 'No organization found. Create one first.' }, status: :not_found
    end
  end

  def create
    if current_user.organization.present?
      render json: { error: 'Organization already exists. Use PUT to update.' }, status: :unprocessable_entity
      return
    end

    @organization = current_user.build_organization(organization_params)
    
    if @organization.save
      render json: { organization: @organization }, status: :created
    else
      render json: { errors: @organization.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @organization
      if @organization.update(organization_params)
        render json: { organization: @organization }
      else
        render json: { errors: @organization.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'No organization found. Create one first.' }, status: :not_found
    end
  end

  private

  def set_organization
    @organization = current_user.organization
  end

  def organization_params
    params.permit(
      :name, 
      :email, 
      :phone, 
      :address, 
      :city, 
      :state, 
      :zip_code, 
      :country, 
      :website, 
      :description,
      :industry,
      :company_size,
      :legal_structure
    )
  end
end
