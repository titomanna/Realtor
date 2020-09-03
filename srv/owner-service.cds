using com.sap.realtor  as realtor from '../db/data-model';

/* Owner Service*/
@impl: './owner-service.js'
service OwnerService @(requires:'owner-role') {
    entity Property as select from realtor.Property ; 
    entity OwnerProperty as select from realtor.OwnerProperties;
    view PropertyRequest as select from realtor.PropertyRequests ;
    
}
annotate OwnerService.PropertyRequest with
@restrict: [
    {grant: 'READ', to: 'owner-role'},
    {grant: 'UPDATE', to: 'owner-role'}
] ;
annotate OwnerService.OwnerProperty with
@restrict: [
    {grant: 'READ', to: 'owner-role', where: 'ownerId_userId = $user'},
    {grant: 'UPDATE', to: 'owner-role', where: 'ownerId_userId = $user'},
] ;
annotate OwnerService.Property with
@restrict: [
    {grant: 'READ', to: 'owner-role', where: 'createdBy = $user'},
    {grant: 'DELETE', to: 'owner-role', where: 'createdBy = $user'},
    {grant: 'UPDATE', to: 'owner-role', where: 'createdBy = $user'},
    {grant: 'WRITE', to: 'owner-role'}
] ;