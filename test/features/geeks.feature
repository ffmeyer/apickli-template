Feature:
	API Test for GetGeeks Plataform, GET method

	@setup
	Scenario: Get Token - geeks
		Given I set headers to
		| name                        | value				|
		| Content-Type                | application/json	|
		| User-Agent                  | apickli				|		

		Given I store the raw value { "email": "joao@qaninja.com.br", "password": "pwd123" } as myPayload in scenario scope
		
		And I set body to `myPayload`
		And I POST to /sessions
		And response code should be 200
		And I store the value of body path $.token as access_token in global scope


	 Scenario: 001_INCORRECT_EMAIL
		Given I store the raw value { "email": "joao.qaninja.com.br", "password": "pwd123" } as incorrect_email in scenario scope
		
		Then I set headers to
                  | name                        | value                             |
                  | Authorization               | Bearer `access_token`             |		
				  | Content-Type				| application/json                  |
                  | Accept           			| application/json                  |
		Then I set body to `incorrect_email`
		And I POST to /sessions
		And response code should be 400
		And response body should be valid json
		And response body path $.error should be Incorrect email

	 Scenario: 002_INCORRECT_PASS
		Given I store the raw value { "email": "joao@qaninja.com.br", "password": "pwd124" } as incorrect_pass in scenario scope
		
		Then I set headers to
                  | name                        | value                             |
                  | Authorization               | Bearer `access_token`             |		
				  | Content-Type				| application/json                  |
                  | Accept           			| application/json                  |
		Then I set body to `incorrect_pass`
		And I POST to /sessions
		And response code should be 401
		And response body should be valid json
		And response body path $.error should be Unauthorized


	 Scenario: 003_USER_NOT_FOUND
		Given I store the raw value { "email": "joao@404.com.br", "password": "pwd123" } as user_not_found in scenario scope
		
		Then I set headers to
                  | name                        | value                             |
                  | Authorization               | Bearer `access_token`             |		
				  | Content-Type				| application/json                  |
                  | Accept           			| application/json                  |
		Then I set body to `user_not_found`
		And I POST to /sessions
		And response code should be 401
		And response body should be valid json
		And response body path $.error should be Unauthorized


	 Scenario: 004_EMPTY_EMAIL
		Given I store the raw value { "email": "", "password": "pwd123" } as empty_email in scenario scope
		
		Then I set headers to
                  | name                        | value                             |
                  | Authorization               | Bearer `access_token`             |		
				  | Content-Type				| application/json                  |
                  | Accept           			| application/json                  |
		Then I set body to `empty_email`
		And I POST to /sessions
		And response code should be 400
		And response body should be valid json
		And response body path $.error should be Required email


	 Scenario: 005_NO_PARAM_EMAIL
		Given I store the raw value { "password": "pwd123" } as no_param_email in scenario scope
		
		Then I set headers to
                  | name                        | value                             |
                  | Authorization               | Bearer `access_token`             |		
				  | Content-Type				| application/json                  |
                  | Accept           			| application/json                  |
		Then I set body to `no_param_email`
		And I POST to /sessions
		And response code should be 400
		And response body should be valid json
		And response body path $.error should be Required email
		

	Scenario: 006_EMPTY_PASS
		Given I store the raw value { "email": "joao@qaninja.com.br", "password": "" } as empty_pass in scenario scope
		
		Then I set headers to
                  | name                        | value                             |
                  | Authorization               | Bearer `access_token`             |		
				  | Content-Type				| application/json                  |
                  | Accept           			| application/json                  |
		Then I set body to `empty_pass`
		And I POST to /sessions
		And response code should be 400
		And response body should be valid json
		And response body path $.error should be Required pass


	 Scenario: 007_NO_PARAM_PASS
		Given I store the raw value { "email": "joao@qaninja.com.br" } as no_param_pass in scenario scope
		
		Then I set headers to
                  | name                        | value                             |
                  | Authorization               | Bearer `access_token`             |		
				  | Content-Type				| application/json                  |
                  | Accept           			| application/json                  |
		Then I set body to `no_param_pass`
		And I POST to /sessions
		And response code should be 400
		And response body should be valid json
		And response body path $.error should be Required pass	


	@smoke
	Scenario: 008_CORRECT_EMAIL
		Given I store the raw value { "email": "joao@qaninja.com.br", "password": "pwd123" } as correct_email in scenario scope
		
		Then I set headers to
					| name						| value                             |
					| Authorization				| Bearer `access_token`             |		
					| Content-Type				| application/json                  |
					| Accept           			| application/json                  |
		Then I set body to `correct_email`
		And I POST to /sessions
		And response code should be 200
		And response body should be valid json
		And response body path $.user.email should be joao@qaninja.com.br
		And response body path $.user.name should be João Lucas