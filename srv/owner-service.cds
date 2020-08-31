using com.sap.realtor  as realtor from '../db/data-model';
/* Owner Service*/
service OwnerService @(requires:'owner-role') {
    entity Property as select from realtor.Property ; 
    entity PropertyRequest as projection on realtor.PropertyRequets;
}
annotate OwnerService.PropertyRequest with
@restrict: [
    {grant: 'READ', to: 'owner-role', where: 'propertyId.createdBy = $user'},
    {grant: 'UPDATE', to: 'owner-role', where: 'propertyId.createdBy = $user'}
] ;
annotate OwnerService.Property with
@restrict: [
    {grant: 'READ', to: 'owner-role', where: 'createdBy = $user'},
    {grant: 'DELETE', to: 'owner-role', where: 'createdBy = $user'},
    {grant: 'WRITE', to: 'owner-role'}
] ;