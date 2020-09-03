using com.sap.realtor  as realtor from '../db/data-model';
/* User Registration Service*/
@impl: './property-service.js'
service PropertyService @(requires:'authenticated-user'){
    entity PropertyStatus as Select from realtor.OwnerProperties{key propertyId,status,Property} excluding{ownerId};
    // as ownprop join realtor.Property as property
    // on ownprop.Property = property.ID{key property.ID as ID,
    //                                        property.propertyName as propertyName,
    //                                        ownprop.status as status} ;//  
     
   entity PropertyRequest as select from  realtor.PropertyRequests;
}    
annotate PropertyService.PropertyRequest with
@restrict: [
    {grant: 'READ', to: 'buyer-role', where: 'createdBy = $user'},
    {grant: 'WRITE',to: 'buyer-role'},
    {grant: 'UPDATE',to: 'buyer-role', where: 'createdBy = $user'}
] ;
