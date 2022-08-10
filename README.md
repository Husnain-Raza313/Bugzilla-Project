# Project Name : Bugzilla

## Developed in : Rails 5.2

## Description:
It is a simple project and the motivation behind its development is to have a platform where developers, QAs and project managers can easily coordinate with each other e.g creating new projects, reporting bugs, updating the status of reported bugs.

## Prerequisites:
To run this project locally, system needs to have following softwares installed
  * Git
  * Ruby [2.7.2]
  * Rails [5.2.0]
  * Postgresql db

## Setup
To run this project on your machine locally, following steps need to be taken:
  1. ### Clone the repo
  First of all you need to clone this repo through following command
  <code> git clone https://github.com/husnainrazadevsinc/Bugzilla-Project.git </code>

  2. ### Run the migrations
  After cloning the repo, refer to the cloned repo through the terminal. then run the following command
  <code> rails db:migrate </code>
  This will run all the migrations and generate a DB schema.

  3. ### Run the seeds.rb
  To store the initial data into the database to make application usable, run command
  <code> rails db:seeds </code>
  This will store all the initial data present inside seeds.rb file in the database

  4. ### Initiate the server
  When the migrations are done, start the server using the following command
  <code> rails s </code>
  and then app can be viewed on localhost:3000/ address

## Important Gems used:
In this project, the gems which were used other than the default ones are mentioned below along with their usage
* Devise -> This gem was used for handling user authentication and basic functionalities like registration and login
* Pundit -> This was used for authorization to restrict the users' scope.
* carrier-wave gem -> This gem was used to preview, store and use the screenshot of a bug.
* Cloudinary -> This gem was used for cloud storage availability.
* client_side_validations -> this gem was used for client side validations

## Assumptions
One must need to know the following assumptions about the project to make good use of it.
* 3 types of users can be registered on this app and each one of them will have seperate authorities.
  1. Manager
  2. Developer
  3. QA
  #### Manager
  * Manager will be able to create, edit, view and delete the projects, he created.
  * Manager will also be able to add developers and QAs to the projects, he created.
  * Manager will be able to see only the projects he has created.

  #### Developer:
  * Developer will be able to only see the projects with which he is assigned.
  * Developer will not be able to edit or delete any project.
  * A developer can not only see the bugs but can assign himself bugs/features and can update their status.
  * A developer can not create or delete a bug/feature.

  #### QA
  * A qa will be able to view all the projects but will not be able to edit or delete projects.
  * A qa will be able to report new bugs in all the projects, QA is assigned with.
  * As the creator of the bugs, QA will be able to create, view, edit or delete the bugs.
