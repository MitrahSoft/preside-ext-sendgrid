// hooks is used to receive the response from send grid
component {

	public void function index( event, rc, prc ) {
		try {
			
			result = GetHTTPRequestData();
		} catch ( any e ) {
			logError( e );
		}

		event.renderData( type="text", data="Webhook received", statuscode=200 );
	}

}