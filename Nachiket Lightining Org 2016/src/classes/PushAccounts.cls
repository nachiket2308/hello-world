public class PushAccounts{
    private final String clientId = '3MVG9ZL0ppGP5UrBC9FfDbF6MkuFSSa7q0QGXCCBc_.Ogvsf.Iu5JVd0U.hCisDYpY5RXfa3CYi7x1xkgivxO';
    private final String clientSecret = '16344933809979152';
    private final String username = 'nachiket.deshpande@developerorg.com';
    private final String password = 'na8chiket';
    
    public class deserializeResponse{
      public String id;
      public String access_token;
    }
    
    public String ReturnAccessToken (PushAccounts acount){
      String reqbody = 'https://login.salesforce.com/services/oauth2/token?grant_type=authorization_code&client_id='+clientId+'&client_secret='+clientSecret+'&code='+'aPrxqJ8A8kLOza.w5jSo7xDt6cpKtW8.BqZQW6kTDUsVAY5jzzN9fSzfggUBv.a9OrTJw46DMQ==';
      Http h = new Http();
      HttpRequest req = new HttpRequest();
      req.setBody('');
      req.setMethod('POST');
      req.setEndpoint(reqbody);
      HttpResponse res = h.send(req);
      deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
      system.debug('@@@@access_token@@'+resp1 );
      return resp1.access_token;
   }

   public static list<Account> callgetAccount (String accId){
       PushAccounts acount1 = new PushAccounts();
       String accessToken;
       accessToken = acount1.ReturnAccessToken (acount1);
       //list<Account> accountList=new List<Contact>();
       list<Account> accountList =new List<Account>();
       if(accessToken != null){
       String endPoint = 'https://ap2.salesforce.com/services/apexrest/v1/getContacts/' +accId;
       //String jsonstr = '{"accId" : "' + accId+ '"}';
       Http h2 = new Http();
       HttpRequest req1 = new HttpRequest();
       req1.setHeader('Authorization','Bearer ' + accessToken);
       req1.setHeader('Content-Type','application/json');
       req1.setHeader('accept','application/json');
       //req1.setBody(jsonstr);
       req1.setMethod('GET');
       req1.setEndpoint(endPoint);
       HttpResponse res1 = h2.send(req1);
       String trimmedResponse = res1.getBody().unescapeCsv().remove('\\');
       system.debug('@@@RESPONSE@@'+trimmedResponse);
       JSONParser parser = JSON.createParser(res1.getBody());
       set<Account> accuntSet=new set<Account>();
        
        while (parser.nextToken() != null) {
            //Id
            
            if((parser.getCurrentToken() == JSONToken.FIELD_NAME) ){
                Account cont;
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'Id')) {
                // Get the value.
                parser.nextToken();
                // Compute the grand total price for all invoices.
                string sId= parser.getText();
                cont=new Account();
                cont.Id=sId;
                system.debug('Id@@@' + sId);
                
                parser.nextToken();
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                    (parser.getText() == 'Name')) {
                    // Get the value.
                    parser.nextToken();
                    // Compute the grand total price for all invoices.
                    string sName= parser.getText();
                    cont.Name=sName;
                    system.debug('Name@@@' + sName );
                }
                
                //Email
               /* parser.nextToken();
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                    (parser.getText() == 'Email')) {
                    // Get the value.
                    parser.nextToken();
                    // Compute the grand total price for all invoices.
                    string sEmail= parser.getText();
                    cont.Email=sEmail;
                    system.debug('Email@@@' + sEmail);
                }
                */
            
            }
            accuntSet.add(cont); 
            }
            
            
            
            accuntSet.remove(null);
            
        }
        accountList.AddAll(accuntSet);
        system.debug('accuntSet@@@@'+Json.serialize(accountList));
        
        
       
    
    }
    return accountList;
   }
}