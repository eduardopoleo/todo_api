- Users
- List
- task


post '/users'
{
  name,
  email,
}

post '/lists'
{
  name,
  user_id,    
}




post '/tasks'
{
  list_id
  name
  completed
}


How do we authenticate these api calls
- Write main apis
- Are indexes required
  - What are indexes how do they work?
- Write authentication ?
  - JWT for api calls
  - login?
- Deployment with docker and AWS
- Asset deployment and generation

