using com.sap.realtor  as realtor from '../db/data-model';
/* User Registration Service*/
service PropertyrService @(requires:'authenticated-user'){
    @readonly entity Property as Select from realtor.Property excluding { ownerId } ; 
    entity PropertyRequest as projection on realtor.PropertyRequets;
}
annotate PropertyService.PropertyRequest with
@restrict: [
    {grant: 'READ', to: 'authenticated-user', where: 'createdBy = $user'},
    {grant: 'DELETE', to: 'authenticated-user', where: 'createdBy = $user'}
] ;
