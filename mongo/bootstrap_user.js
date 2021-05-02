

db.getSiblingDB('api_service_development').createUser(
  {
    user: "admin",
    pwd: "password",
    roles:[
      { role: 'root', db: 'admin'}
    ]
  }
);

db.getSiblingDB('api_service_test').createUser(
  {
    user: "admin",
    pwd: "password",
    roles:[
      {role: 'root', db: 'admin'}
    ]
  }
);
