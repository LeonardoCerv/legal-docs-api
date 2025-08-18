require 'swagger_helper'

RSpec.describe 'documents', type: :request do

  path '/documents/{type}' do
    # You'll want to customize the parameter types...
    parameter name: 'type', in: :path, type: :string, description: 'type'

    get('show document') do
      response(200, 'successful') do
        let(:type) { '123' }

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

    post('create document') do
      response(200, 'successful') do
        let(:type) { '123' }

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

    put('update document') do
      response(200, 'successful') do
        let(:type) { '123' }

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

    delete('delete document') do
      response(200, 'successful') do
        let(:type) { '123' }

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
