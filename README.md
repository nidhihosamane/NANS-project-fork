# MySQL + Flask Boilerplate Project

This repo contains a boilerplate setup for spinning up 3 Docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API
1. A Local AppSmith Server

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 


Project Overview:
Our product, FitBase, aims to organize the system of a newly-opened private gym, FitClub. The product will help the new gym with their struggles of keeping track of their customers, presonal training sessions, class sessions, trainers, and other employees. The product will help marketers market the gym in order to gain new members and keep old members involved. A gym member can access this product in order to gain information on available classes and their profile. Their profile contains member demographics as well as their specific membership plan. Trainers will use the product to view class and personal training information and update their own information (ie: certifications obtained/expired). Meanwhile, gym administration can view managers and the section of the gym they oversee, as well as payroll-related information for their employees. General gym employees can view their own profiles and payroll-related information. 






