/**
 * @singleton
 * @presideservice
 *
 */
component {

	/**
	 * @emailLoggingService.inject emailLoggingService
	 *
	 */
	public any function init( required any emailLoggingService ) {
		setSendGridEmailLoggingService( arguments.emailLoggingService );

		return this;
	}

// calling hook events
	public void function processEvents( required array events ) {
		for ( var event in events ) {
			processEvent( event );
		}
	}

	public void function processEvent( required struct event ){
		var loggingService = getSendGridEmailLoggingService();
		var eventType      = arguments.event.event    ?: "";
		var messageId      = arguments.event.sg_message_id ?: "";

		if ( !messageId.len() ) {
			return;
		}

		switch( eventType ) {
			case "open":
				loggingService.markAsOpened( id=messageId );
			break;
			case "Delivered":
				loggingService.markAsDelivered( id=messageId );
			break;
			case "bounce":
				loggingService.markAsHardBounced(
					  id     = messageId
					, reason = arguments.event.REASON ?: ""
					, code   = lISTfIRST(arguments.event.REASON, " ")
				);
			break;
			case "dropped":
				loggingService.markAsFailed(
					 id     = messageId
					, reason = arguments.event.REASON ?: ""
					, code   = lISTfIRST(arguments.event.REASON, " ")
				);
			break;
			case "unsubscribe":
				loggingService.markAsUnsubscribed( id=messageId );
			break;
			case "spamreport":
				loggingService.markAsMarkedAsSpam( id=messageId );
			break;
			case "click":
				loggingService.recordClick( id=messageId, link=arguments.event.url ?: "" );
			break;
		}
	}

// GETTERS AND SETTERS
	private any function getSendGridEmailLoggingService() {
		return _emailLoggingService;
	}
	private void function setSendGridEmailLoggingService( required any emailLoggingService ) {
		_emailLoggingService = arguments.emailLoggingService;
	}
}