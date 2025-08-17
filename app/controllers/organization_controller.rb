class OrganizationController < ApplicationController
  before_action :set_org, only: %i[ show update destroy ]

  def show
    if @organization
      render json: @organization, status: :ok
    else
      render json: { error: 'Organization not found' }, status: :not_found
    end
  end

  def create
    @organization = Organization.new(org_params)
    @organization.user = current_user

    if @organization.save
      render json: {
        status: 'success',
        message: 'Organization successfully created',
        data: {
          id: @organization.id,
          created_at: Time.current.iso8601
        }
      }, status: :ok
    else
      render json: {
        status: 'error',
        message: 'Failed to create organization',
        errors: @organization.errors
      }, status: :unprocessable_entity
    end
  end

  def update
    if @organization.update(org_params)
      render json: {
        status: 'success',
        message: 'Organization successfully updated',
        data: {
          id: @organization.id,
          updated_at: Time.current.iso8601
        }
      }, status: :ok
    else
      render json: {
        status: 'error',
        message: 'Failed to update organization',
        errors: @organization.errors
      }, status: :unprocessable_entity
    end
  end

  def destroy
    if @organization.destroy
      render json: {
        status: 'success',
        message: 'Organization successfully deleted',
        data: {
          id: @organization.id,
          deleted_at: Time.current.iso8601
        }
      }, status: :ok
    else
      render json: {
        status: 'error',
        message: 'Failed to delete organization',
        errors: @organization.errors
      }, status: :unprocessable_entity
    end
  end

  private
    def set_org
      @organization = Organization.find_by(user: current_user)
    end

    def org_params
      params.expect(organization: [ 
        :name, :legal_name, :industry, :business_type, :address, :city, 
        :state, :country, :postal_code, :phone, :email, :website, 
        :registration_number, :tax_id, :dpo_name, :dpo_email, 
        :gdpr_representative, :data_retention_period 
      ])
    end
end