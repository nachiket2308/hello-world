public class PaginationController {

    //Variable Declaration
    public List<opportunityWrapper> opportunityWrapperList {get;set;}
    private integer counter=0;  //keeps track of the offset
    private integer list_size=30; //sets the page size
    public integer total_size; //used to show user the total size of the list

    //Constructor
    public PaginationController(){
        total_size = [select count() from Opportunity]; //set the total size in the constructor
    }

    //Method to process Selected records
    public PageReference processSelectedRecords() {
        //List To Hold Selected Opportunities
        List<Opportunity> selectedOpportunities = new List<Opportunity>();

        //We will cycle through our list of opportunityWrapper and will check to see if the selected property is set to true, 
        //if it is we add the Opportunities to the selectedOpportunities list
        for(opportunityWrapper objOpportunity: getOpportunityRecords()) {
            if(objOpportunity.isSelected == true) {
                selectedOpportunities.add(objOpportunity.objOpp);
            }
        }

        //Now we have our list of selected Opportunities
        System.debug('These are the selected Opportunities...');
        for(Opportunity objOppor: selectedOpportunities) {
            system.debug('*****Selected Opportunities*****'+objOppor);
        }
        opportunityWrapperList =null; // we need this line if we performed a write operation  because getOpportunityRecords gets a fresh list now
        return null;
    }

    //Method to return Wrapper List
    public List<opportunityWrapper> getOpportunityRecords(){
        if(opportunityWrapperList == null){
            opportunityWrapperList = new List<opportunityWrapper> ();
            for(Opportunity objOpp : [Select Id,Name,CloseDate,StageName,CreatedDate From Opportunity order by CreatedDate 
                                      limit :list_size offset :counter]){
                opportunityWrapperList.add(new opportunityWrapper(objOpp));
            }//for
        }//if
        system.debug('****opportunityWrapperList****'+opportunityWrapperList);
        return opportunityWrapperList;
    }//getOpportunityRecords

    //user clicked beginning
    public PageReference Beginning() { 
        counter = 0;
        return null;
    }

    //user clicked previous button
    public PageReference Previous() {
        counter -= list_size;
        return null;
    }

    //user clicked next button
    public PageReference Next() {
        counter += list_size;
        return null;
    }

    //user clicked end
    public PageReference End() {
        counter = total_size - math.mod(total_size, list_size);
        return null;
    }

    public Boolean getDisablePrevious() { 
        //this will disable the previous and beginning buttons
        if (counter>0) return false; else return true;
    }

    //this will disable the next and end buttons
    public Boolean getDisableNext() {
        if (counter + list_size < total_size) return false; else return true;
    }

    public Integer getTotal_size() {
        return total_size;
    }

    public Integer getPageNumber() {
        return counter/list_size + 1;
    }

    public Integer getTotalPages() {
        if (math.mod(total_size, list_size) > 0) {
            return total_size/list_size + 1;
        } else {
            return (total_size/list_size);
        }
    }

    //Wrapper Class For Opportunity Records
    public class opportunityWrapper {
        public Opportunity objOpp {get; set;}
        public Boolean isSelected {get; set;}

        public opportunityWrapper(Opportunity opp){
            this.objOpp = opp;
            this.isSelected = false;
        }//opportunityWrapper
    }//opportunityWrapper
}//PaginationController