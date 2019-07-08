# Routes
Using lvh.me to correctly work with subdomains.

- `identity.lvh.me:4000` - login page, use "admin" to login
- `identity.lvh.me:4000/protected` - only visible to authenticated users
- `shipping.lvh.me:4001` - only visible to authenticated users

Trying access any protected route will redirect you to the login page and redirect back once logged in.

Shipping authentication is done by `IdentityWeb.AuthVerify` pipeline using a domain level cookie.

# Flow
```
- access shipping.lvh.me:4001                                                 |
- via 'IdentityWeb.AuthVerify' pipeline will try to identify the user         | Done on shipping server / port 4001
- if none is found, it will store subdomain, port and path in session         |
- redirect to identify.lvh.me:4000 (url still hardcoded)                      |

- user identifies itself                                                      |
- cookie is set with user data                                                | Done on identity server / port 4000
- reads subdomain, port and path from session and redirects                   |

- shipping server repeats previous steps                                      |
- now the user is identified                                                  | Done on shipping server / port 4001
- render the root path                                                        | 
```

# TODO
- development/test environment