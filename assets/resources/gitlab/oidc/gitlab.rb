gitlab_rails['omniauth_allow_single_sign_on'] = true
gitlab_rails['omniauth_block_auto_created_users'] = false
gitlab_rails['omniauth_providers'] = [
  { 'name' => 'openid_connect',
    'label' => 'keycloak',
    #'icon' => '<custom_provider_icon>',
    'args' => {
      'name' => 'openid_connect',
      'scope' => ['openid','profile','email'],
      'response_type' => 'code',
      'issuer' => 'http://keycloak_keycloak_1:8080/auth/realms/test',
      #'issuer' => 'http://keycloak_keycloak_1:8080/auth/realms/test',
      'discovery' => false,
      'client_auth_method' => 'query',
      #'client_auth_method' => 'basic',
      'uid_field' => 'preferred_username',
      'send_scope_to_token_endpoint' => 'false',
      'client_options' => {
        'identifier' => 'gitlab1',
        'secret' => '5c4d8305-c03d-47bf-a7d8-4999c1417990',
        'redirect_uri' => 'http://gitlab1:9080/users/auth/openid_connect/callback',
        'authorization_endpoint' => 'http://keycloak_keycloak_1:8080/auth/realms/test/protocol/openid-connect/auth',
        'token_endpoint' => 'http://keycloak_keycloak_1:8080/auth/realms/test/protocol/openid-connect/token',
        'userinfo_endpoint' => 'http://keycloak_keycloak_1:8080/auth/realms/test/protocol/openid-connect/userinfo',
        'jwks_uri' => 'http://keycloak_keycloak_1:8080/auth/realms/test/protocol/openid-connect/certs',
        'end_session_endpoint' => 'https://keycloak_keycloak_1:8443/auth/realms/test/protocol/openid-connect/logout'
      }
    }
  }
]