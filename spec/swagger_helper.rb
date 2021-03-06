# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'http://localhost:4321',
          description: 'Local docker-compose development'
        }
      ],
      components: {
        schemas: {
          Timestamps: {
            type: :object,
            properties: {
              created_at: {
                type: :string,
                format: 'date-time',
                description: 'Entity creation date and time'
              },
              updated_at: {
                type: :string,
                format: 'date-time',
                description: 'Entity update date and time'
              }
            },
            required: %w[created_at updated_at]
          },
          Media: {
            type: :array,
            items: {
              '$ref': '#/components/schemas/Medium'
            }
          },
          Medium: {
            allOf: [
              {
                type: :object,
                properties: {
                  id: {
                    type: :integer,
                    format: :int64,
                    description: 'Medium ID',
                    example: 1
                  },
                  title: {
                    type: :string,
                    description: 'Medium title',
                    example: 'Medium title'
                  },
                  description: {
                    type: :string,
                    description: 'Medium description',
                    example: 'Medium description',
                    nullable: true
                  }
                },
                required: %w[id title]
              },
              {
                '$ref': '#/components/schemas/Timestamps'
              }
            ]
          },
          CreateMediumAttributes: {
            type: :object,
            properties: {
              title: {
                type: :string,
                description: 'Medium title',
                example: 'Medium title'
              },
              description: {
                type: :string,
                description: 'Medium description',
                example: 'Medium description'
              }
            },
            required: ['title']
          },
          UpdateMediumAttributes: {
            type: :object,
            properties: {
              title: {
                type: :string,
                description: 'Medium title',
                example: 'Medium title'
              },
              description: {
                type: :string,
                description: 'Medium description',
                example: 'Medium description'
              }
            }
          },
          User: {
            allOf: [
              {
                type: :object,
                properties: {
                  id: {
                    type: :integer,
                    format: :int64,
                    description: 'User ID',
                    example: 1
                  },
                  first_name: {
                    type: :string,
                    description: 'User first name',
                    example: 'John'
                  },
                  last_name: {
                    type: :string,
                    description: 'User last name',
                    example: 'Doe'
                  },
                  email: {
                    type: :string,
                    format: :email,
                    description: 'User email',
                    example: 'john@doe.com'
                  }
                },
                required: %w[id first_name last_name email]
              },
              {
                '$ref': '#/components/schemas/Timestamps'
              }
            ]
          },
          Users: {
            type: :array,
            items: {
              '$ref': '#/components/schemas/User'
            }
          },
          CreateUserAttributes: {
            type: :object,
            properties: {
              first_name: {
                type: :string,
                description: 'User first name',
                example: 'John'
              },
              last_name: {
                type: :string,
                description: 'User last name',
                example: 'Doe'
              },
              email: {
                type: :string,
                format: :email,
                description: 'User email',
                example: 'john@doe.com'
              }
            },
            required: %w[id first_name last_name email]
          },
          UpdateUserAttributes: {
            type: :object,
            properties: {
              first_name: {
                type: :string,
                description: 'User first name',
                example: 'John',
                nullable: true
              },
              last_name: {
                type: :string,
                description: 'User last name',
                example: 'Doe',
                nullable: true
              },
              email: {
                type: :string,
                format: :email,
                description: 'User email',
                example: 'john@doe.com',
                nullable: true
              }
            }
          },
          Share: {
            allOf: [
              {
                type: :object,
                properties: {
                  id: {
                    type: :integer,
                    format: :int64,
                    description: 'Share ID',
                    example: 1
                  },
                  user_id: {
                    type: :integer,
                    format: :int64,
                    description: 'User ID',
                    example: 1
                  },
                  medium_id: {
                    type: :integer,
                    format: :int64,
                    description: 'Medium ID',
                    example: 1
                  }
                },
                required: %w[id user_id medium_id]
              },
              {
                '$ref': '#/components/schemas/Timestamps'
              }
            ]
          },
          Shares: {
            type: :array,
            items: {
              '$ref': '#/components/schemas/Share'
            }
          },
          CreateShareAttributes: {
            type: :object,
            properties: {
              user_id: {
                type: :integer,
                format: :int64,
                description: 'User ID',
                example: 1
              },
              medium_id: {
                type: :integer,
                format: :int64,
                description: 'Medium ID',
                example: 1
              }
            },
            required: %w[user_id medium_id]
          },
          LikeableType: {
            type: :string,
            enum: %w[shares comments]
          },
          Like: {
            type: :object,
            properties: {
              id: {
                type: :integer,
                format: :int64,
                description: 'Like ID',
                example: 1
              },
              likable_id: {
                type: :integer,
                format: :int64,
                description: 'Likeable ID',
                example: 1
              },
              likable_type: {
                type: :string,
                enum: %w[Share Comment],
                description: 'Likeable type',
                example: 'Share'
              },
              user_id: {
                type: :integer,
                format: :int64,
                description: 'ID of user that liked the likeable',
                example: 1
              }
            },
            required: %w[id likable_id likable_type user_id]
          },
          Likes: {
            type: :array,
            items: {
              '$ref': '#/components/schemas/Like'
            }
          },
          CreateLikeAttributes: {
            type: :object,
            properties: {
              like: {
                type: :object,
                properties: {
                  user_id: {
                    type: :integer,
                    format: :int64,
                    description: 'ID of user that liked the likeable',
                    example: 1
                  }
                },
                required: ['user_id']
              }
            },
            required: ['like']
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
