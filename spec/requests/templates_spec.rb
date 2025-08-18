require 'swagger_helper'

RSpec.describe 'Templates API', type: :request do

  path '/templates/{type}' do
    parameter name: 'type', in: :path, type: :string,
              description: 'Type of document template to retrieve. Same types as documents but returns template content instead of user-specific documents.',
              enum: ['privacy_policy', 'privacy-policy', 'terms_of_service', 'terms-of-service', 'cookie_policy', 'cookie-policy', 'disclaimer', 'acceptable_use_policy', 'acceptable-use-policy'],
              example: 'privacy_policy'

    get('Retrieve document template') do
      tags 'Legal Templates'
      description 'Get a template for a specific document type. Templates provide a starting point for creating legal documents. These are generic templates with placeholder text that can be customized. This endpoint does not require authentication.'
      produces 'application/json'
      
      response(200, 'Template retrieved successfully') do
        schema type: :string,
               description: 'Template content in markdown format with placeholders',
               example: <<~TEMPLATE
                 # Terms of Service
                 
                 **Effective Date:** [DATE]
                 
                 Welcome to [COMPANY NAME]. These Terms of Service govern your use of our website and services.
                 
                 ## 1. Acceptance of Terms
                 
                 By accessing and using this service, you accept and agree to be bound by the terms and provision of this agreement.
                 
                 ## 2. Use License
                 
                 Permission is granted to temporarily download one copy of the materials on [COMPANY NAME]'s website for personal, non-commercial transitory viewing only.
                 
                 ## 3. Disclaimer
                 
                 The materials on [COMPANY NAME]'s website are provided on an 'as is' basis.
                 
                 [Additional template content...]
               TEMPLATE

        let(:type) { 'terms_of_service' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'Template not found') do
        schema type: :object,
               properties: {
                 error: { 
                   type: :string, 
                   example: 'Template not found' 
                 }
               },
               required: ['error']

        let(:type) { 'invalid_type' }

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
