require 'swagger_helper'

RSpec.describe 'Document Management API', type: :request do

  path '/documents/{type}' do
    parameter name: 'type', in: :path, type: :string, 
              description: 'Type of legal document to manage. Supported types: privacy_policy, terms_of_service, cookie_policy, disclaimer, acceptable_use_policy',
              enum: ['privacy_policy', 'privacy-policy', 'terms_of_service', 'terms-of-service', 'cookie_policy', 'cookie-policy', 'disclaimer', 'acceptable_use_policy', 'acceptable-use-policy'],
              example: 'privacy_policy'

    get('Retrieve and generate legal document') do
      tags 'Legal Documents'
      description 'Retrieve a legal document of the specified type for the authenticated user. Returns the document configuration, organization information, and generated content. The generated content is a complete legal document in markdown format that can be used directly.'
      produces 'application/json'
      security [bearerAuth: []]
      
      parameter name: 'Authorization', in: :header, type: :string, 
                description: 'JWT token for authentication'

      response(200, 'Document retrieved and generated successfully') do
        schema type: :object,
               properties: {
                 document: {
                   type: :object,
                   description: 'The document object with all its properties'
                 },
                 organization: {
                   type: :object,
                   description: 'Organization information used for document generation'
                 },
                 generated_content: {
                   type: :string,
                   description: 'The generated legal document content in markdown format',
                   example: "# Privacy Policy\n\n**Effective Date:** 2024-01-01\n\nThis privacy policy describes..."
                 }
               },
               required: ['document', 'organization', 'generated_content']

        let(:type) { 'privacy_policy' }
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

      response(404, 'Document not found') do
        schema type: :object,
               properties: {
                 error: { 
                   type: :string, 
                   example: 'Document not found' 
                 }
               },
               required: ['error']

        let(:type) { 'privacy_policy' }
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

      response(400, 'Invalid document type') do
        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Invalid document type' },
                 message: { type: :string, example: "Document type 'invalid_type' is not supported" },
                 supported_types: {
                   type: :array,
                   items: { type: :string },
                   example: ['terms_of_service', 'privacy_policy', 'cookie_policy', 'disclaimer', 'acceptable_use_policy']
                 }
               },
               required: ['error', 'message', 'supported_types']

        let(:type) { 'invalid_type' }
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

    post('Create new legal document') do
      tags 'Legal Documents'
      description 'Create a new legal document of the specified type. The request body varies depending on the document type. Each user can have one document of each type.'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]
      
      parameter name: 'Authorization', in: :header, type: :string, 
                description: 'JWT token for authentication'
      
      parameter name: :document_data, in: :body, schema: {
        type: :object,
        properties: {
          document: {
            type: :object,
            description: 'Document properties (varies by document type)',
            anyOf: [
              {
                title: 'Privacy Policy',
                type: :object,
                properties: {
                  title: { type: :string, example: 'Privacy Policy' },
                  effective_date: { type: :string, format: :date, example: '2024-01-01' },
                  data_types_collected: { type: :string, example: 'Personal information, usage data, cookies' },
                  cookies_used: { type: :boolean, example: true },
                  third_party_sharing: { type: :boolean, example: false },
                  international_transfers: { type: :boolean, example: true },
                  user_rights_access: { type: :boolean, example: true },
                  user_rights_deletion: { type: :boolean, example: true },
                  user_rights_portability: { type: :boolean, example: true },
                  data_retention_period: { type: :integer, example: 365 },
                  contact_method: { type: :string, example: 'email' },
                  gdpr_compliant: { type: :boolean, example: true },
                  ccpa_compliant: { type: :boolean, example: true }
                },
                required: ['title', 'effective_date']
              },
              {
                title: 'Terms of Service',
                type: :object,
                properties: {
                  title: { type: :string, example: 'Terms of Service' },
                  effective_date: { type: :string, format: :date, example: '2024-01-01' },
                  acceptance_required: { type: :boolean, example: true },
                  minimum_age: { type: :integer, example: 13 },
                  governing_law: { type: :string, example: 'California, USA' },
                  jurisdiction: { type: :string, example: 'San Francisco County, California' },
                  dispute_resolution: { type: :string, example: 'arbitration' },
                  user_data_collection: { type: :boolean, example: true },
                  account_termination_notice_days: { type: :integer, example: 30 },
                  refund_policy: { type: :string, example: 'no_refunds' },
                  service_availability: { type: :string, example: 'best_effort' },
                  user_generated_content_policy: { type: :string, example: 'moderated' }
                },
                required: ['title', 'effective_date']
              }
            ]
          }
        },
        required: ['document']
      }

      response(200, 'Document created successfully') do
        schema type: :object,
               properties: {
                 status: { type: :string, example: 'success' },
                 message: { type: :string, example: 'Document successfully created' },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer, example: 1 },
                     created_at: { type: :string, format: 'date-time' }
                   }
                 }
               },
               required: ['status', 'message', 'data']

        let(:type) { 'privacy_policy' }
        let(:Authorization) { 'Bearer valid_jwt_token' }
        let(:document_data) { 
          { 
            document: {
              title: 'Privacy Policy',
              effective_date: '2024-01-01',
              data_types_collected: 'Personal information, usage data',
              cookies_used: true
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

      response(400, 'Invalid document type') do
        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Invalid document type' },
                 message: { type: :string, example: "Document type 'invalid_type' is not supported" },
                 supported_types: {
                   type: :array,
                   items: { type: :string },
                   example: ['terms_of_service', 'privacy_policy', 'cookie_policy', 'disclaimer', 'acceptable_use_policy']
                 }
               },
               required: ['error', 'message', 'supported_types']

        let(:type) { 'invalid_type' }
        let(:Authorization) { 'Bearer valid_jwt_token' }
        let(:document_data) { { document: {} } }

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
                 message: { type: :string, example: 'Failed to create document' },
                 errors: { type: :object, example: { "title" => ["can't be blank"] } }
               },
               required: ['status', 'message', 'errors']

        let(:type) { 'privacy_policy' }
        let(:Authorization) { 'Bearer valid_jwt_token' }
        let(:document_data) { { document: { title: '' } } }

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

    put('Update existing legal document') do
      tags 'Legal Documents'
      description 'Update an existing legal document of the specified type. Only the fields provided in the request will be updated. The request body format is the same as the POST endpoint.'
      consumes 'application/json'
      produces 'application/json'
      security [bearerAuth: []]
      
      parameter name: 'Authorization', in: :header, type: :string, 
                description: 'JWT token for authentication'
      
      parameter name: :document_data, in: :body, schema: {
        type: :object,
        properties: {
          document: {
            type: :object,
            description: 'Document fields to update (varies by document type)'
          }
        },
        required: ['document']
      }

      response(200, 'Document updated successfully') do
        schema type: :object,
               properties: {
                 status: { type: :string, example: 'success' },
                 message: { type: :string, example: 'Document successfully updated' },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer, example: 1 },
                     updated_at: { type: :string, format: 'date-time' }
                   }
                 }
               },
               required: ['status', 'message', 'data']

        let(:type) { 'privacy_policy' }
        let(:Authorization) { 'Bearer valid_jwt_token' }
        let(:document_data) { { document: { title: 'Updated Privacy Policy' } } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(400, 'Invalid document type') do
        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Invalid document type' }
               },
               required: ['error']

        let(:type) { 'invalid_type' }
        let(:Authorization) { 'Bearer valid_jwt_token' }
        let(:document_data) { { document: {} } }

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
                 message: { type: :string, example: 'Failed to update document' },
                 errors: { type: :object, example: { "effective_date" => ["is not a valid date"] } }
               },
               required: ['status', 'message', 'errors']

        let(:type) { 'privacy_policy' }
        let(:Authorization) { 'Bearer valid_jwt_token' }
        let(:document_data) { { document: { effective_date: 'invalid-date' } } }

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

    delete('Delete legal document') do
      tags 'Legal Documents'
      description 'Permanently delete a legal document of the specified type. This action cannot be undone.'
      produces 'application/json'
      security [bearerAuth: []]
      
      parameter name: 'Authorization', in: :header, type: :string, 
                description: 'JWT token for authentication'

      response(200, 'Document deleted successfully') do
        schema type: :object,
               properties: {
                 status: { type: :string, example: 'success' },
                 message: { type: :string, example: 'Document successfully deleted' },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer, example: 1 },
                     deleted_at: { type: :string, format: 'date-time' }
                   }
                 }
               },
               required: ['status', 'message', 'data']

        let(:type) { 'privacy_policy' }
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

      response(400, 'Invalid document type') do
        schema type: :object,
               properties: {
                 error: { type: :string, example: 'Invalid document type' }
               },
               required: ['error']

        let(:type) { 'invalid_type' }
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

      response(422, 'Unable to delete document') do
        schema type: :object,
               properties: {
                 status: { type: :string, example: 'error' },
                 message: { type: :string, example: 'Failed to delete document' },
                 errors: { type: :object, example: { "base" => ["Document is referenced by other records"] } }
               },
               required: ['status', 'message', 'errors']

        let(:type) { 'privacy_policy' }
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
