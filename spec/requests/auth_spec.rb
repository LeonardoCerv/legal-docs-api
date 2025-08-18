require 'swagger_helper'

RSpec.describe 'Authentication API', type: :request do

  path '/auth/login' do

    post('Authenticate user and receive JWT token') do
      tags 'Authentication'
      description 'Authenticate with your username and password to receive a JWT token. You should include the token in your auth header for protected paths.'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          username: { 
            type: :string, 
            description: "Your username",
            example: 'john_doe'
          },
          password: { 
            type: :string, 
            description: "Your password",
            example: 'securepassword123'
          }
        },
        required: ['username', 'password']
      }

      response(200, 'Authentication successful') do
        schema type: :object,
               properties: {
                 user: {
                   type: :object,
                   properties: {
                     id: { type: :integer, example: 1 },
                     username: { type: :string, example: 'john_doe' },
                     bio: { type: :string, example: 'Mikes roofing llc' },
                     created_at: { type: :string, format: 'date-time' },
                     updated_at: { type: :string, format: 'date-time' }
                   }
                 },
                 token: { 
                   type: :string, 
                   description: 'JWT auth token',
                   example: 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.abc123'
                 }
               },
               required: ['user', 'token']

        let(:credentials) { { username: 'test_user', password: 'password123' } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'Invalid credentials') do
        schema type: :object,
               properties: {
                 error: { 
                   type: :string, 
                   example: 'Invalid credentials' 
                 },
                 message: { 
                   type: :string, 
                   example: 'Username or password is incorrect' 
                 }
               },
               required: ['error', 'message']

        let(:credentials) { { username: 'invalid_user', password: 'wrong_password' } }

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
