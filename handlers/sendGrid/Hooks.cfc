// hooks is used to receive the response from send grid

component {
	property name="sentGridNotificationsService" inject="sentGridNotificationsService";
	public void function index( event, rc, prc ) {
		try {
			var result = DeSerializeJson(request.http.body);

			sentGridNotificationsService.processEvents(
				events = ( IsArray( result ) ? result :  arrayNew() )
			);
		} catch ( any e ) {
			logError( event );
		}

		event.renderData( type="text", data="WeebHook received", statuscode=200 );

	}

}
