@RestResource(urlMapping='/sfdcCalling/*')
global class SalesforceOrg{
    @HttpGet
    global static List<Contact> sfdcMethod(){ 
        List<Contact> sfdcContact = new List<Contact>();
        sfdcContact = [select Name,Email from Contact];
        return sfdcContact;
    }
}