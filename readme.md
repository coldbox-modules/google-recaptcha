# cbReCaptcha

Implements Google reCaptcha for ColdBox 5.x applications.

## Installation

- register your site at https://www.google.com/recaptcha/intro/index.html
- install the module via commandbox box install `cbReCaptcha`
- enter your public and private key at module section

## Configuration

Please add into your `config/ColdBox.cfc` in the `moduleSettings` the `google-recaptcha` key with the following configuration settings:

```js
moduleSettings = {

	"google-recaptcha" = {
		// Public key once you register your site in google
		"publicKey" 	= "",
		// Private key once you register your site in google
		"privateKey" 	= ""
	}

}
```


## Usage