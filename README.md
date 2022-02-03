# Push docker image to heroku

- sudo docker-compose -f docker-compose-heroku.yml build
- sudo heroku container:push worker
- sudo heroku container:release worker

# Test image locally
- sudo docker-compose -f docker-compose-local.yml up --build
