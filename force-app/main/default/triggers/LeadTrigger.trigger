trigger LeadTrigger on Lead (before insert, before update, after insert) {
    
    switch on Trigger.operationType {

        when BEFORE_INSERT {
            for(Lead leadRecord : Trigger.new){
                if(String.isBlank(leadRecord.LeadSource)){
                    leadRecord.LeadSource = 'Other';
        }
                if(String.isBlank(leadRecord.Industry)){
                    leadRecord.addError('The industry field cannot be blank');

                }
                
            }
        }
        when AFTER_INSERT{
            List<Task> leadTasks = new LIst<Task>(); 
            for(Lead leadRecord : Trigger.new){
                Task leadTask = new Task(Subject='Follow uo on Lead Status', WhoId=leadRecord.Id);
                leadTasks.add(leadTask);
            }
            insert leadTasks;
        }

        when BEFORE_UPDATE {
            for(Lead leadRecord : Trigger.new){
                if(String.isBlank(leadRecord.LeadSource)){
                    leadRecord.LeadSource = 'Other';
        }

                if((leadRecord.Status == 'Closed - Converted' || leadRecord.Status == 'Closed - Not Converted' ) && Trigger.oldMap.get(leadRecord.Id).Status == 'Open - Not Contacted'){
                    leadRecord.Status.addError('Youn cannot directly close an open lead record');

                 }
            }
        }
    }
       
 }