---
title: "API for obtaining client certificates"
weight: 520
---

# API for obtaining client certificates

The server on demo.eduroam.no can be accessed directly by a user, where he is required to authenticate and then allowed to download a client certificated, packed in a profile (eap-metadata, mobileconfig, pkcs12, pem).  But not all platforms have support for importing configuration files; some operating systems only have internal APIs for configuring wireless profiles (e.g. Windows and Android).  For these platforms, the server allows retrieving profiles through a web API.  This is a description of the API.

## Discovery

For discovery, use the discovery JSON file hosted at https://discovery.eduroam.app/v1/discovery.json

**TODO** document the format of the discovery.  It is rather straightforward, but explicit documentation is better


## Authorization endpoint

Build a URL for the authorization endpoint; take the `authorization_endpoint` string from the discovery,
and add the following GET parameters:

  * `response_type` (set to `code`)
  * `code_challenge_method` (set to `S256`)
  * `scope` (choose between `eap-metadata` and `mobileconfig`)
  * `code_challenge` (a code challenge, as documented in RFC7636 section 4)
  * `redirect_uri` (where the user should be redirected after accepting or rejecting your application, GET parameters will added to this URL by the server)
  * `client_id` (your client ID as known by the server)
  * `state` (a random string that will be set in a GET parameter to the `redirect_uri`, for you to verify it's the same flow)

You have created a URL, for example:

	https://demo.eduroam.no/authorize.php?response_type=code&code_challenge_method=S256&scope=eap-metadata&code_challenge=E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM&redirect_uri=http%3A%2F%2Flocalhost%3A1080%2Fcallback&client_id=00000000-0000-0000-0000-000000000000&state=0

You open a local webbrowser to this URL on the users' device and listen on the `redirect_uri` for a request to return.
Upon receiving a request, reclaim focus to your application and handle the request.
You may receive these GET parameters:

  * `code` (a code that you can use on the token endpoint)
  * `error` (an error message that you can present to the user)
  * `state` (the same value as your earlier `state` GET parameter)

As a reply to this request, you may simply return a message to the user stating that he should return to the application.
Depending on the platform, you may also return code to trigger a return to the application.


## Token endpoint

The token endpoint requires a `code`, which you obtain via the Authorization endpoint.
Use the `token_endpoint` string from the discovery.

You need the following POST parameters:

  * `grant_type` (set to `authorization_code`)
  * `code` (the code received from the authorization endpoint)
  * `redirect_uri` (repeat the value used in the previous request, as mandated by RFC7636)
  * `client_id` (repeat the value used in the previous request, as mandated by RFC7636)
  * `code_verifier` (a code verifier, as documented in RFC7636 section 4)

You get back a JSON dictionary, containing the following keys:

  * `access_token`
  * `token_type` (set to `Bearer`)
  * `expires_in` (validity of the `access_token` in seconds)

Example HTTP conversation

	POST /token.php HTTP/1.1
	Accept: application/json
	Content-Type: application/x-www-form-urlencoded
	Content-Length: 209

	grant_type=authorization_code&code=v2.local.AAAAAA&redirect_uri=http%3A%2F%2Flocalhost%3A1080%2Fcallback&client_id=00000000-0000-0000-0000-000000000000&code_verifier=dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk

	HTTP/1.1 200 OK
	Cache-Control: no-store
	Content-Type: application/json;charset=UTF-8
	Pragma: no-cache

	{
		"access_token": "v2.local.AAAAA…==",
		"token_type": "Bearer",
		"expires_in": 3600
	}


## Generator endpoint

The generator requires an access_token, as bearer.  You've obtained this from the token endpoint.
For the URL to the generator, use the `generator_endpoint` string from the discovery.

	POST /generate.php? HTTP/1.1
	Accept: application/x-eap-config
	Authorization: Bearer AAAAAA…==
	Content-Type: application/x-www-form-urlencoded
	Content-Length: 19

	format=eap-metadata

	HTTP/1.1 200 OK
	Cache-Control: no-store
	Content-Disposition: attachment; filename="johndoe.xml"
	Content-Type: application/eap-config
	Pragma: no-cache

	<?xml version="1.0" encoding="utf-8"?>
	…
