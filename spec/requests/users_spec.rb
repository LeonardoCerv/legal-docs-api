require 'swagger_helper'

RSpec.describe 'User Management API', type: :request do

  path '/users' do

    post('Create a new user') do
      tags 'Authentication'
      description 'Create a new user. Upon successful registration, returns the user object and an JWT auth token for accesing protected paths.'
      consumes 'application/json'
      produces 'application/json'
      
      parameter name: :user_data, in: :body, schema: {
        type: :object,
        properties: {
          username: { 
            type: :string, 
            description: 'Username for the new account',
            example: 'john_doe'
          },
          password: { 
            type: :string, 
            description: 'Password for the new account',
            example: 'securepassword123'
          },
          bio: { 
            type: :string, 
            description: 'Optional bio',
            example: 'Mikes roofing llc'
          }
        },
        required: ['username', 'password']
      }

      response(201, 'User created successfully') do
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

        let(:user_data) { { username: 'test_user', password: 'password123', bio: 'Test user bio' } }

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
                 errors: {
                   type: :array,
                   items: { type: :string },
                   example: ['Username has already been taken']
                 }
               },
               required: ['errors']

        let(:user_data) { { username: '', password: 'password123' } }

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

  path '/me' do
    get('Get your user info') do
      tags 'Authentication'
      description 'Retrieve information about the current user. Requires a valid JWT token in the Auth header (bearer token).'
      produces 'application/json'
      security [bearerAuth: []]
      
      parameter name: 'Authorization', in: :header, type: :string, 
                description: 'JWT token for authentication', 
                example: 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.abc123'

      response(200, 'Current user information') do
        schema type: :object,
               properties: {
                 id: { type: :integer, example: 1 },
                 username: { type: :string, example: 'john_doe' },
                 bio: { type: :string, example: 'Mikes roofing llc' },
                 created_at: { type: :string, format: 'date-time' },
                 updated_at: { type: :string, format: 'date-time' }
               },
               required: ['id', 'username']

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

      response(401, 'Authentication required') do
        schema type: :object,
               properties: {
                 message: { 
                   type: :string, 
                   example: 'Please log in' 
                 }
               },
               required: ['message']

        let(:Authorization) { '' }

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
