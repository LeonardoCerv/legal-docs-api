require 'swagger_helper'

RSpec.describe 'Organization Management API', type: :request do

  path '/organization' do

    get('Retrieve organization information') do
      tags 'Your Organization'
      description 'Get the organization details for the authenticated user. Each user can have one organization associated with their account.'
      produces 'application/json'
      security [bearerAuth: []]
      
      parameter name: 'Authorization', in: :header, type: :string, 
                description: 'JWT token for authentication'

      response(200, 'Organization information retrieved successfully') do
        schema type: :object,
               properties: {
                 id: { type: :integer, example: 1 },
                 name: { type: :string, example: 'Tech Solutions Inc' },
                 legal_name: { type: :string, example: 'Tech Solutions Incorporated' },
                 industry: { type: :string, example: 'Technology' },
                 business_type: { 
                   type: :string, 
                   enum: ['sole_proprietorship', 'partnership', 'llc', 'corporation', 'nonprofit', 'government', 'other'],
                   example: 'corporation' 
                 },
                 address: { type: :string, example: '123 Business Ave' },
                 city: { type: :string, example: 'San Francisco' },
                 state: { type: :string, example: 'CA' },
                 country: { type: :string, example: 'United States' },
                 postal_code: { type: :string, example: '94105' },
                 phone: { type: :string, example: '+1-555-123-4567' },
                 email: { type: :string, format: :email, example: 'contact@techsolutions.com' },
                 website: { type: :string, format: :uri, example: 'https://www.techsolutions.com' },
                 registration_number: { type: :string, example: 'REG123456789' },
                 tax_id: { type: :string, example: 'TAX987654321' },
                 dpo_name: { type: :string, example: 'Jane Smith' },
                 dpo_email: { type: :string, format: :email, example: 'dpo@techsolutions.com' },
                 gdpr_representative: { type: :string, example: 'EU Rep Services Ltd' },
                 data_retention_period: { type: :integer, example: 365 },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               }

        let(:Authorization) { 'Bearer valid_jwt_token' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'Organization not found') do
        schema type: :object,
               properties: {
                 error: { 
                   type: :string, 
                   example: 'Organization not found' 
                 }
               },
               required: ['error']

        let(:Authorization) { 'Bearer valid_jwt_token' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('Create organization profile') do
      tags 'Your Organization'
      description 'Create a new organization profile for the authenticated user. This information is used to personalize generated legal documents. Each user can only have one organization.'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]
      
      parameter name: 'Authorization', in: :header, type: :string, 
                description: 'JWT token for authentication'
      
      parameter name: :organization_data, in: :body, schema: {
        type: :object,
        properties: {
          organization: {
            type: :object,
            properties: {
              name: { type: :string, description: 'Common business name', example: 'Tech Solutions Inc' },
              legal_name: { type: :string, description: 'Official legal name', example: 'Tech Solutions Incorporated' },
              industry: { type: :string, description: 'Industry sector', example: 'Technology' },
              business_type: { 
                type: :string, 
                enum: ['sole_proprietorship', 'partnership', 'llc', 'corporation', 'nonprofit', 'government', 'other'],
                description: 'Type of business entity',
                example: 'corporation' 
              },
              address: { type: :string, description: 'Street address', example: '123 Business Ave' },
              city: { type: :string, description: 'City name', example: 'San Francisco' },
              state: { type: :string, description: 'State or province', example: 'CA' },
              country: { type: :string, description: 'Country name', example: 'United States' },
              postal_code: { type: :string, description: 'ZIP or postal code', example: '94105' },
              phone: { type: :string, description: 'Contact phone number', example: '+1-555-123-4567' },
              email: { type: :string, format: :email, description: 'Primary contact email', example: 'contact@techsolutions.com' },
              website: { type: :string, format: :uri, description: 'Company website URL', example: 'https://www.techsolutions.com' },
              registration_number: { type: :string, description: 'Business registration number', example: 'REG123456789' },
              tax_id: { type: :string, description: 'Tax identification number', example: 'TAX987654321' },
              dpo_name: { type: :string, description: 'Data Protection Officer name', example: 'Jane Smith' },
              dpo_email: { type: :string, format: :email, description: 'Data Protection Officer email', example: 'dpo@techsolutions.com' },
              gdpr_representative: { type: :string, description: 'GDPR representative organization', example: 'EU Rep Services Ltd' },
              data_retention_period: { type: :integer, description: 'Default data retention period in days', example: 365 }
            },
            required: ['name', 'legal_name', 'industry', 'business_type', 'address', 'city', 'country', 'email']
          }
        },
        required: ['organization']
      }

      response(200, 'Organization created successfully') do
        schema type: :object,
               properties: {
                 status: { type: :string, example: 'success' },
                 message: { type: :string, example: 'Organization successfully created' },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer, example: 1 },
                     created_at: { type: :string, format: 'date-time' }
                   }
                 }
               },
               required: ['status', 'message', 'data']

        let(:Authorization) { 'Bearer valid_jwt_token' }
        let(:organization_data) { 
          { 
            organization: {
              name: 'Test Company',
              legal_name: 'Test Company Inc',
              industry: 'Technology',
              business_type: 'corporation',
              address: '123 Test St',
              city: 'Test City',
              country: 'Test Country',
              email: 'test@example.com'
            }
          } 
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(422, 'Validation error') do
        schema type: :object,
               properties: {
                 status: { type: :string, example: 'error' },
                 message: { type: :string, example: 'Failed to create organization' },
                 errors: { type: :object, example: { "name" => ["can't be blank"] } }
               },
               required: ['status', 'message', 'errors']

        let(:Authorization) { 'Bearer valid_jwt_token' }
        let(:organization_data) { { organization: { name: '' } } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('Update organization information') do
      tags 'Your Organization'
      description 'Update the organization profile for the authenticated user. Only the fields provided in the request will be updated.'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]
      
      parameter name: 'Authorization', in: :header, type: :string, 
                description: 'JWT token for authentication'
      
      parameter name: :organization_data, in: :body, schema: {
        type: :object,
        properties: {
          organization: {
            type: :object,
            properties: {
              name: { type: :string, example: 'Tech Solutions Inc' },
              legal_name: { type: :string, example: 'Tech Solutions Incorporated' },
              industry: { type: :string, example: 'Technology' },
              business_type: { 
                type: :string, 
                enum: ['sole_proprietorship', 'partnership', 'llc', 'corporation', 'nonprofit', 'government', 'other'],
                example: 'corporation' 
              },
              address: { type: :string, example: '123 Business Ave' },
              city: { type: :string, example: 'San Francisco' },
              state: { type: :string, example: 'CA' },
              country: { type: :string, example: 'United States' },
              postal_code: { type: :string, example: '94105' },
              phone: { type: :string, example: '+1-555-123-4567' },
              email: { type: :string, format: :email, example: 'contact@techsolutions.com' },
              website: { type: :string, format: :uri, example: 'https://www.techsolutions.com' },
              registration_number: { type: :string, example: 'REG123456789' },
              tax_id: { type: :string, example: 'TAX987654321' },
              dpo_name: { type: :string, example: 'Jane Smith' },
              dpo_email: { type: :string, format: :email, example: 'dpo@techsolutions.com' },
              gdpr_representative: { type: :string, example: 'EU Rep Services Ltd' },
              data_retention_period: { type: :integer, example: 365 }
            }
          }
        },
        required: ['organization']
      }

      response(200, 'Organization updated successfully') do
        schema type: :object,
               properties: {
                 status: { type: :string, example: 'success' },
                 message: { type: :string, example: 'Organization successfully updated' },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer, example: 1 },
                     updated_at: { type: :string, format: 'date-time' }
                   }
                 }
               },
               required: ['status', 'message', 'data']

        let(:Authorization) { 'Bearer valid_jwt_token' }
        let(:organization_data) { { organization: { name: 'Updated Company Name' } } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(422, 'Validation error') do
        schema type: :object,
               properties: {
                 status: { type: :string, example: 'error' },
                 message: { type: :string, example: 'Failed to update organization' },
                 errors: { type: :object, example: { "email" => ["is not a valid email"] } }
               },
               required: ['status', 'message', 'errors']

        let(:Authorization) { 'Bearer valid_jwt_token' }
        let(:organization_data) { { organization: { email: 'invalid-email' } } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('Delete organization') do
      tags 'Your Organization'
      description 'Permanently delete the organization profile for the authenticated user. This action cannot be undone and will also delete all associated documents.'
      produces 'application/json'
      security [bearerAuth: []]
      
      parameter name: 'Authorization', in: :header, type: :string, 
                description: 'JWT token for authentication'

      response(200, 'Organization deleted successfully') do
        schema type: :object,
               properties: {
                 status: { type: :string, example: 'success' },
                 message: { type: :string, example: 'Organization successfully deleted' },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer, example: 1 },
                     deleted_at: { type: :string, format: 'date-time' }
                   }
                 }
               },
               required: ['status', 'message', 'data']

        let(:Authorization) { 'Bearer valid_jwt_token' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(422, 'Unable to delete organization') do
        schema type: :object,
               properties: {
                 status: { type: :string, example: 'error' },
                 message: { type: :string, example: 'Failed to delete organization' },
                 errors: { type: :object, example: { "base" => ["Cannot delete organization with active documents"] } }
               },
               required: ['status', 'message', 'errors']

        let(:Authorization) { 'Bearer valid_jwt_token' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
