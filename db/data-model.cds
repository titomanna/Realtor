namespace com.sap.realtor;
using { managed, Country, cuid } from '@sap/cds/common';

entity Property: managed{
    key propertyId:Integer;
    propertyName: String;
    propertyType: String;
    propertyBhk: Integer;
    propertyCountry: Country;
    propertyArea: String;
    propertyAddress: String;
}
entity OwnerProperties: managed {
    key ownerId: Association to one OwnerUser;
    key propertyId: Association to one Property;
    status: String;
}
entity OwnerUser: managed {
    key ownerId: Integer; 
    ownerName: String(50);
    ownerEmail: String(50);
    ownerPhone: String(15);
    
}

entity PropertyRequets: managed,cuid{
    requesterName: String;
    requesterEmail: String(50);
    requeterPhone: String(15);
    propertyId: Association to one Property;
    requestStatus: Boolean;
}