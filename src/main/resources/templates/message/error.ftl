<xml>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
    <soap12:Body>
        <mGetOutMessageResponse xmlns="http://tempuri.org/crm_server/Crm_OutMessage">
            <mGetOutMessageResult>
                <success>${isSuccess}</success>
                <ID>${id}</ID>
                <errors>
                    <Errors>
                        <StatusCode>-1</StatusCode>
                        <message>${error}</message>
                    </Errors>
                </errors>
            </mGetOutMessageResult>
        </mGetOutMessageResponse>
    </soap12:Body>
</soap12:Envelope>
</xml>