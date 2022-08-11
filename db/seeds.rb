# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!([{
               name: 'Manager', email: 'manager@email.com', password: 'test@123', user_type: 0
             },
              {
                name: 'Developer', email: 'developer@email.com', password: 'test@123', user_type: 1
              },
              {
                name: 'QA', email: 'qa@email.com', password: 'test@123', user_type: 2
              }])
Rails.logger.debug "Created #{User.count} Users"
