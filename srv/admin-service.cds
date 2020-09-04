using com.sap.realtor as realtor from '../db/data-model';
service AdminService {
 //admin services   
 entity Property as projection on realtor.Property;
 entity User as projection on realtor.User;
 entity OwnerProperties as projection on realtor.OwnerProperties;
 entity Requests as projection on realtor.PropertyRequests;
    
}