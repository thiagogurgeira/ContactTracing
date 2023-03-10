trigger LeadTrigger2 on SOBJECT (before insert, before update) {
    for(Lead leadRecord : Trigger.new){
        if(String.isBlank(leadRecord.Rating)){
            leadRecord = 'Warm';
        }
    }
    
}