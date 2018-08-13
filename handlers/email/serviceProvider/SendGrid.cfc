/**
 * This Service Provider send the mail from SendGrid SMTP server
 *
 */
component {
	property name="emailTemplateService" inject="emailTemplateService";

	private boolean function send( struct sendArgs={}, struct settings={} ) {
		var template = emailTemplateService.getTemplate( sendArgs.template ?: "" );

		sendArgs.messageId = sendArgs.messageId ?: "";
		sendArgs.params = sendArgs.params ?: {};
		sendArgs.params[ "xHeader" ] = {
			  name  = "x-smtpapi"
			, value = ' {"unique_args":{"MessageID-SG":"#sendArgs.messageId#"}}'
		};
		settings.username = "apikey";
		settings.password = settings.sendgrid_api_key ?: "";

		var result = runEvent(
			  event          = "email.serviceProvider.smtp.send"
			, private        = true
			, prepostExempt  = true
			, eventArguments = {
				  sendArgs = sendArgs
				, settings = settings
			  }
		);

		return result;
	}

	private any function validateSettings( required struct settings, required any validationResult ) {
		return validationResult;
	}
}