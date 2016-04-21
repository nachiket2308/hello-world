public class SearchFilterCriteria {

    //Variable Declaration
    public List<OpportunityWrapper> opportunityWrapperList {get; set;}
    private String QueryOpportunity;
    public String RecPerPage {get; set;}

    //Construtor
    public SearchFilterCriteria() {
        
    }

    //Standard Set Controller.
    public ApexPages.StandardSetController StdSetControllerOpportunity {
        get {
            if(StdSetControllerOpportunity == null) {
                StdSetControllerOpportunity = new ApexPages.StandardSetController(Database.getQueryLocator(QueryOpportunity));
                // sets the number of records in each page set
                StdSetControllerOpportunity.setPageSize(Integer.valueOf(RecPerPage));
            }
            return StdSetControllerOpportunity;
        }
        set;
    }

    public List<OpportunityWrapper> getOpportunityWrapperList(){
        opportunityWrapperList = new List<OpportunityWrapper> ();
        for (Opportunity objOpp : (list<Opportunity>)StdSetControllerOpportunity.getRecords()) {
            opportunityWrapperList.add(new OpportunityWrapper(objOpp));
        }
        return opportunityWrapperList;
    }//getOpportunityWrapperList

    //OpportunityWrapper
    public class OpportunityWrapper{
        public Boolean isSelected {get; set;}
        public Opportunity objOpp {get; set;}

        public OpportunityWrapper(Opportunity opportunityObj){
            this.objOpp = opportunityObj;
            this.isSelected = false;
        }
    }//OpportunityWrapper
}//SearchFilterCriteria