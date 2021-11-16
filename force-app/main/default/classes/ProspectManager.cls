public without sharing class ProspectManager {
   //lista de usuarios , via role
   @AuraEnabled
    public static list<User> Getusers() { 
        string role= userinfo.getUserRoleId();
        List<UserRole> lstofuserRole = new List<UserRole>();
        set<Id> setofChildID = new Set<ID>();  
        lstofuserRole =[ Select u.ParentRoleId, u.Name, u.Id From UserRole u where ParentRoleId=:role];
        if(lstofuserRole!=null && lstofuserRole.size()>0)
        {
            for(UserRole uroleObj:lstofuserRole )
            {
                setofChildID.add(uroleObj.ID);
            }
        }         
        //list<User> usuarios = [select id,firstname,lastname,name from user where isactive=true and UserRoleId IN:setofChildID];
        list<User> usuarios = [select id,firstname,lastname,name from user where isactive=true];
        return usuarios;
    }
    @AuraEnabled
    public integer offst;
    @AuraEnabled
    public integer total;
    @AuraEnabled
    public boolean hasprev;
    @AuraEnabled
    public boolean hasnext;
    @AuraEnabled
    public List <lead> lstLeads;
    private static integer pagesize;
    private static integer offset;
    
        //obtener registros de ofertas para paginarlos
    @AuraEnabled
    public static ProspectManager getleadsuser(boolean next,boolean prev,decimal off, decimal recordsshow,string iduser,String searchKey) {
        offset = (integer) off;                                          
        pagesize = (integer) recordsshow;
        ProspectManager pm = new ProspectManager();
        integer iRecordCount =[Select count() from lead where isconverted=false and ownerid=:iduser];
        if (next == false && prev == false) {   } 
        else if (next == true && (offset + pagesize) <= iRecordCount) {
            offset = offset + pagesize;
        } else if (prev == true && offset > 0) {
            offset = offset - pagesize;
        }
        List <Lead> lstLeads; 
        lstLeads = [select id,firstname,lastname,CI_Reasigment__c from lead where isconverted=false and ownerid=:iduser LIMIT: pagesize OFFSET: offset];
        pm.lstLeads = lstLeads;
        pm.offst = offset;
        pm.hasprev = hasprev(offset);
        pm.hasnext = hasnxt(offset, iRecordCount, pagesize);
        pm.total = iRecordCount;
        return pm;
    }
    
    private static boolean hasprev(integer off) {
        if (off > 0)
            return false;
        return true;
    }
    
    private static boolean hasnxt(integer off, integer li, integer ps) {
        if (off + ps < li)
            return false;
        return true;
    }
   @AuraEnabled
    public static void UpdateAsignacion(string idlead, boolean asignacion) {
        lead pros = [select id,CI_Reasigment__c from lead where id=:idlead];
        pros.CI_Reasigment__c = asignacion;
        update pros;
    }
    @AuraEnabled
    public static void UpdateAsignacionMass(List<string> idleads, boolean asignacion) {
        list<lead> prospect = [select id, CI_Reasigment__c from lead where id IN:idleads];
        list<lead> prospectupd = new list<lead>();
        for(lead l:prospect){
         l.CI_Reasigment__c = asignacion;
         prospectupd.add(l);   
        }        
        update prospectupd;
    }
    @AuraEnabled
    public static void Changeowner(List<string> idejecutivos,string idusuario) {
        list<user>resetlistauser = new list<user>();
        list<user>resetuser = [select id,Prospectos_Reasignados__c from user where id IN:idejecutivos];
        For (user ur : resetuser) {
            ur.Prospectos_Reasignados__c = 0;
            resetlistauser.add(ur);
        }
        update resetlistauser;    
        BatchReasigmentLeads M = new BatchReasigmentLeads(idejecutivos, idusuario,'Seleccionados');
        Database.executeBatch(M, 1);
    }
     @AuraEnabled
    public static void ChangeownerMass(List<string> idejecutivos,string idusuario) {
     list<user>resetlistauser = new list<user>();
        list<user>resetuser = [select id,Prospectos_Reasignados__c from user where id IN:idejecutivos];
        For (user ur : resetuser) {
            ur.Prospectos_Reasignados__c = 0;
            resetlistauser.add(ur);
        }
        update resetlistauser;    
        BatchReasigmentLeads M = new BatchReasigmentLeads(idejecutivos, idusuario,'Todo');
        Database.executeBatch(M, 1);       
    }
    //proceso de oportunidades
    @AuraEnabled
    public integer totalOP;
    @AuraEnabled
    public List <opportunity> lstOpps;
    @AuraEnabled
    public static ProspectManager getopportunitiesbysuser(boolean next,boolean prev,decimal off, decimal recordsshow,string iduser) {
        offset = (integer) off;                                          
        pagesize = (integer) recordsshow;
        ProspectManager pmop = new ProspectManager();
        integer iRecordCount =[Select count() from opportunity where isclosed=false and ownerid=:iduser and Account.CI_Tipo_de_Cliente__c='Prospecto Potencial'];
        if (next == false && prev == false) {   } 
        else if (next == true && (offset + pagesize) <= iRecordCount) {
            offset = offset + pagesize;
        } else if (prev == true && offset > 0) {
            offset = offset - pagesize;
        }
        List < opportunity > lstOpps;                                           
        lstOpps = [select id,name,amount,closedate,account.Name,CI_Reasigment__c from opportunity where isclosed=false and ownerid=:iduser and Account.CI_Tipo_de_Cliente__c='Prospecto Potencial' LIMIT: pagesize OFFSET: offset];
        pmop.lstOpps = lstOpps;
        pmop.offst = offset;
        pmop.hasprev = hasprev(offset);
        pmop.hasnext = hasnxt(offset, iRecordCount, pagesize);
        pmop.totalOP = iRecordCount;
        return pmop;
      }
    @AuraEnabled
    public static void UpdateAsignacionOpp(string idopp, boolean asignacion) {
        Opportunity op = [select id,CI_Reasigment__c from Opportunity where id=:idopp];
        op.CI_Reasigment__c = asignacion;
        update op;
    }
    @AuraEnabled
    public static void UpdateAsignacionMassOpp(List<string> idopps, boolean asignacion) {
        list<Opportunity> oport = [select id, CI_Reasigment__c from Opportunity where id IN:idopps];
        list<Opportunity> oportupd = new list<Opportunity>();
        for(Opportunity o:oport){
         o.CI_Reasigment__c = asignacion;
         oportupd.add(o);   
        }        
        update oportupd;
    }
    @AuraEnabled
    public static void ChangeownerOpp(string userorigen,string userdestino) {
        list<user>resetlistauser = new list<user>();
        list<user>resetuser = [select id,Prospectos_Reasignados__c from user where id=:userdestino];
        For (user ur : resetuser) {
            ur.Prospectos_Reasignados__c = 0;
            resetlistauser.add(ur);
        }
        update resetlistauser;  
        BatchReasigmentOpp M = new BatchReasigmentOpp(userorigen, userdestino,'Seleccionados');
        Database.executeBatch(M, 1);
    }
    @AuraEnabled
    public static void ChangeownerMassOpp(string userorigen,string userdestino) { 
        list<user>resetlistauser = new list<user>();
        list<user>resetuser = [select id,Prospectos_Reasignados__c from user where id=:userdestino];
        For (user ur : resetuser) {
            ur.Prospectos_Reasignados__c = 0;
            resetlistauser.add(ur);
        }
        update resetlistauser;  
        BatchReasigmentOpp M = new BatchReasigmentOpp(userorigen, userdestino,'Todo');
        Database.executeBatch(M, 1);       
    }
    
}