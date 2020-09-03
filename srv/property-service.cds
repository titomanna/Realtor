using com.sap.realtor  as realtor from '../db/data-model';
/* User Registration Service*/
@impl: './property-service.js'
service PropertyService @(requires:'authenticated-user'){
    entity Property as Select from realtor.Property  excluding{createdBy,modifiedBy,createdAt,modifiedAt}; 

    entity PropertyRequest as select from  realtor.PropertyRequests;
}    
annotate PropertyService.PropertyRequest with
@restrict: [
    {grant: 'READ', to: 'buyer-role', where: 'createdBy = $user'},
    {grant: 'WRITE',to: 'buyer-role'},
    {grant: 'UPDATE',to: 'buyer-role', where: 'createdBy = $user'}
] ;
