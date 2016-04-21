public class ExternalServiceCall {
    public PageReference callMethod() {
        String Endpoint = 'https://login.salesforce.com/services/oauth2/authorize?response_type=code&client_id=3MVG9ZL0ppGP5UrBC9FfDbF6MkomCCS3EnqTQnPjUP5mDr99N.Lsrekj1Z0rtIPcawyDgbvN2japFUP0LJVJZ&redirect_uri=https://ap2.salesforce.com/06628000004Yi5l&state=mystate1';
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(Endpoint);
        req.setMethod('POST');
        HTTPResponse res = http.send(req);
        System.debug('----------------'+res.getBody());
        return null;
    }
}