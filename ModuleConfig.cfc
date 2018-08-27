/**
 * Copyright since 2012 by Ortus Solutions, Corp
 * ---
 * Google Recaptcha module config
 */
component hint="My Module Configuration"{

	// Module Properties
	this.title 				= "google-recaptcha";
	this.author 			= "Ortus Solutions, Corp";
	this.webURL 			= "https://www.ortussolutions.com";
	this.description 		= "Implements Google reCaptcha for ColdBox 5.x applications";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "google-recaptcha";

	/**
	 * COnfigure this module
	 */
	function configure(){

		// module settings - stored in modules.name.settings
		settings = {
			"apiUrl" 		= 'https://www.google.com/recaptcha/api/siteverify',
			// Public key once you register your site in google
			"publicKey" 	= "",
			// Private key once you register your site in google
			"privateKey" 	= ""
		};

		// Custom Declared Points
		interceptorSettings = {
			customInterceptionPoints = ""
		};

		// Custom Declared Interceptors
		interceptors = [
		];

	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){

	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){

	}

}