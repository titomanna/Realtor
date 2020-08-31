using com.sap.realtor  as realtor from '../db/data-model';
/* User Registration Service*/
/*service RegisterService  @(requires:'authenticated-user'){*/
service RegisterService{    
    @insertonly entity User as projection on realtor.User; 
}
