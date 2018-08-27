/**
 * This CFC allows you to connect to the reCaptcha service for rendering and validation
 */
component singleton accessors="true"{

	// DI
	property name="settings" inject="coldbox:modulesettings:google-recaptcha";

	/**
	* Google Private Key
	*/
	property name="privateKey" 	default="";

	/**
 	* Constructor
	*/
	recaptchaService function init(){
		return this;
	}

	/**
	 * Validate the captcha
	 *
	 * @response The Response from the form
	 * @remoteIP The remote IP
	 */
	boolean function isValid( string response, string remoteIP=getRemoteIp() ){
		var result = httpSend( response, remoteIp );

		var check = deserializeJSON( result.filecontent );

		return check.success;
	}

	/**
	 * Send the HTTP request
	 *
	 * @response The Response from the form
	 * @remoteIP The remote IP
	 */
	struct function httpSend( required string response, string remoteIP ){

		var httpService = new http(
			method  = "post",
			url 	= config.APIURL,
			timeout = 10
		);

	    httpService.addParam( type="header",    name="Content-Type", value="application/x-www-form-urlencoded");
	    httpService.addParam( type="formfield", name="response", 	 value="#arguments.response#");
	    httpService.addParam( type="formfield", name="remoteip",  	 value="#arguments.remoteIp#");
	    httpService.addParam( type="formfield", name="secret",		 value="#getSecretKey()#");

		return httpService.send().getPrefix();
	}

	/**
	 * Get the public key from the ContentBox settings
	 */
	function getPublicKey() {
		var allSettings = getAllSettings();

		if( structKeyExists( allSettings, 'publicKey' ) ){
			return allSettings.publicKey;
		}

		return 'Public Key Not Set';
	}

	/**
	 * Get the secret key from the ContentBox settings
	 */
	function getSecretKey() {
		var allSettings = getAllSettings();

		if( structKeyExists( allSettings, 'privateKey' ) ){
			return allSettings.privateKey;
		}

		return 'Private Key Not Set';
	}

	/**
	 * Return the HTML for the reCaptcha form
	 */
	function renderForm(){
		savecontent variable="local.outputForm"{
			writeOutput( "
			<script src='https://www.google.com/recaptcha/api.js'></script>
			<div class=""form-group"">
				<div class=""g-recaptcha"" data-sitekey=""#getPublicKey()#""></div>
			</div>
			" );
		}

		return local.outputForm;
	}

	/*********************************** PRIVATE ***********************************/

	/**
	* Get Real IP, by looking at clustered, proxy headers and locally.
	*/
	private function getRemoteIp(){
		var headers = GetHttpRequestData().headers;

		// Very balanced headers
		if( structKeyExists( headers, 'x-cluster-client-ip' ) ){
			return headers[ 'x-cluster-client-ip' ];
		}
		if( structKeyExists( headers, 'X-Forwarded-For' ) ){
			return headers[ 'X-Forwarded-For' ];
		}

		return len( cgi.remote_addr ) ? cgi.remote_addr : '127.0.0.1';
	}

	/**
	 * Get all recaptcha settings from ContentBox
	 */
	private function getAllSettings(){
		var settings = settingService
			.findWhere( criteria = { name="cbReCaptcha" } )
			.getValue();
		return deserializeJson( settings );
	}

}
